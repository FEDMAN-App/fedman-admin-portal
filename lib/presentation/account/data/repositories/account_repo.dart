import 'package:dio/dio.dart';
import 'package:fedman_admin_app/presentation/account/data/models/fedman_user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/utils/managers/google_signin_manager.dart';
import 'local/local_auth_repo.dart';

class AccountRepo {
  final ApiClient apiClient;

   late FedmanUserModel fedmanUser;

  AccountRepo({required this.apiClient});

  Future<ApiResponse<FedmanUserModel>> loginWithGoogle(GoogleSignInAccount googleSignInAccount) async {





    if (googleSignInAccount.authentication.idToken == null) {
      return ApiResponse.failure("idToken is null");
    }
    final requestData = {
      'provider': 'google',
      'idToken': googleSignInAccount.authentication.idToken,
    };

    // Call social login API
    final Response response = await apiClient.post(
      '/auth-service/auth/social-login',
      data: requestData,
    );

    if (response.data["status"] == "success") {
      fedmanUser=FedmanUserModel.fromJson(response.data!["data"]["user"]);
      return ApiResponse.success(

        accessToken: response.data!["data"]["access_token"],
        fedmanUser,
        message: response.data!["message"],
        statusCode: response.statusCode,
      );
    } else {
      return ApiResponse.failure(response.data["message"]);
    }
  }

  Future<ApiResponse<String>> getProfilePhoto() async {
    try {
      final Response response = await apiClient.get('/auth-service/users/profile/photo');

      if (response.data["status"] == "success") {
        return ApiResponse.success(
          response.data["data"] as String,
          message: response.data["message"],
          statusCode: response.statusCode,
        );
      } else {
        return ApiResponse.failure(response.data["message"]);
      }
    } catch (e) {
      return ApiResponse.failure('Failed to get profile photo: $e');
    }
  }

  Future<ApiResponse<FedmanUserModel>> getUser(String userId) async {
    try {
      final Response response = await apiClient.get('/auth-service/users/admin/$userId');

      if (response.data["status"] == "success") {
        final userData = response.data["data"] as Map<String, dynamic>;
        
        // Fetch profile photo URL
        final profilePhotoResult = await getProfilePhoto();
        String? profilePhotoUrl;
        if (profilePhotoResult.success && profilePhotoResult.data != null) {
          profilePhotoUrl = profilePhotoResult.data;
        } else {
          profilePhotoUrl = null;
        }

        // Add profile photo URL to user data
        final userDataWithPhoto = Map<String, dynamic>.from(userData);
        userDataWithPhoto['profilePhotoUrl'] = profilePhotoUrl;
        fedmanUser = FedmanUserModel.fromJson(userDataWithPhoto);
        
        return ApiResponse.success(
          fedmanUser,
          message: response.data["message"],
          statusCode: response.statusCode,
        );
      } else {
        return ApiResponse.failure(response.data["message"]);
      }
    } catch (e) {
      return ApiResponse.failure('Failed to get user: $e');
    }
  }

  Future<ApiResponse<void>> logout() async {
    final localAuthRepo = GetIt.instance<LocalAuthRepository>();
    await localAuthRepo.clearAuthData();
    return ApiResponse.success(null, message: "Logged out successfully");
  }
}
