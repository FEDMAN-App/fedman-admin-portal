import 'package:dio/dio.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/network/paginated_response.dart';
import '../models/federation_model.dart';

class FederationRepo {
  final ApiClient apiClient;

  FederationRepo({required this.apiClient});

  Future<ApiResponse<PaginatedResponse<FederationModel>>> getFederations({
    int page = 1,
    int? limit = 10,
    String? search,
    String? federationType,
    String? country,
  }) async {
    final Map<String, dynamic> queryParams = {'page': page};

    if (search != null && search.isNotEmpty) {
      queryParams['search'] = search;
    }

    if (federationType != null &&
        federationType.isNotEmpty &&
        federationType != 'Select type') {
      queryParams['type'] = federationType;
    }

    if (country != null && country.isNotEmpty && country != 'All Locations') {
      queryParams['country'] = country;
    }
    if (limit != null) {
      queryParams['limit'] = limit;
    }

    final Response response = await apiClient.get(
      '/federation-admin-service/federations',
      queryParameters: queryParams,
    );

    if (response.data["status"] == "success") {
      try {
        final paginatedResponse = PaginatedResponse.fromJson(
          response.data["data"],
          (json) {
            return FederationModel.fromJson(json);
          },
        );

        return ApiResponse.success(
          paginatedResponse,
          message: response.data["message"],
          statusCode: response.statusCode,
        );
      } catch (e, stackTrace) {
        return ApiResponse.failure('Failed to parse federations data: $e');
      }
    } else {
      return ApiResponse.failure(response.data["message"]);
    }
  }

  Future<ApiResponse<FederationModel>> createFederation(
    FederationModel federation,
  ) async {
    final Response response = await apiClient.post(
      '/federation-admin-service/federations',
      data: federation.toJson(),
    );

    if (response.data["status"] == "success") {
      final federationData = FederationModel.fromJson(response.data["data"]);
      return ApiResponse.success(
        federationData,
        message: response.data["message"],
        statusCode: response.statusCode,
      );
    } else {
      return ApiResponse.failure(response.data["message"]);
    }
  }

  Future<ApiResponse<FederationModel>> updateFederation(
    int federationId,
    FederationModel federation,
  ) async {
    final Response response = await apiClient.put(
      '/federation-admin-service/federations/$federationId',
      data: federation.toJson(),
    );

    if (response.data["status"] == "success") {
      final federationData = FederationModel.fromJson(response.data["data"]);
      return ApiResponse.success(
        federationData,
        message: response.data["message"],
        statusCode: response.statusCode,
      );
    } else {
      return ApiResponse.failure(response.data["message"]);
    }
  }

  Future<ApiResponse<FederationModel>> getFederationById(
    int federationId,
  ) async {
    final Response response = await apiClient.get(
      '/federation-admin-service/federations/$federationId',
    );

    if (response.data["status"] == "success") {
      final federationData = FederationModel.fromJson(response.data["data"]);
      return ApiResponse.success(
        federationData,
        message: response.data["message"],
        statusCode: response.statusCode,
      );
    } else {
      return ApiResponse.failure(response.data["message"]);
    }
  }
}
