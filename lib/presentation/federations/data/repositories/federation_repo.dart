import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:fedman_admin_app/core/utils/logger_service.dart';
import 'package:fedman_admin_app/presentation/federations/data/models/document_model.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/network/paginated_response.dart';
import '../models/federation_model.dart';
import '../models/federation_member_model.dart';

class FederationRepo {
  final ApiClient apiClient;

  FederationRepo({required this.apiClient});
  final logger= GetIt.I.get<LoggerService>();
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
      GetIt.I.get<LoggerService>().i(response.data["data"]);
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

    logger.i(federation.toJson());
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
    GetIt.I.get<LoggerService>().i(federation.toJson());
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
      GetIt.I.get<LoggerService>().i(response.data["data"]);
      return ApiResponse.success(
        federationData,
        message: response.data["message"],
        statusCode: response.statusCode,
      );
    } else {
      return ApiResponse.failure(response.data["message"]);
    }
  }

  /// Uploads a logo for a federation
  /// [federationId] - The ID of the federation
  /// [logoFileBytes] - The logo file bytes
  /// [fileName] - The name of the file
  Future<ApiResponse<String>> uploadFederationLogo({
    required int federationId,
    required Uint8List logoFileBytes,
    String? fileName,
  }) async {
    try {
      final formData = FormData.fromMap({
        'logo': MultipartFile.fromBytes(
          logoFileBytes.toList(),
          filename: fileName ?? 'logo.png',
        ),
      });

      final Response response = await apiClient.post(
        '/federation-admin-service/federations/$federationId/logo',
        data: formData,
      );

      if (response.data["status"] == "success") {
        GetIt.I.get<LoggerService>().i(response.data);
        return ApiResponse.success(
          response.data["data"]?["logoUrl"] ?? "Logo uploaded successfully",
          message: response.data["message"],
          statusCode: response.statusCode,
        );
      } else {
        return ApiResponse.failure(response.data["message"]);
      }
    } catch (e) {
      return ApiResponse.failure('Failed to upload logo: $e');
    }
  }

  /// Gets the logo URL for a federation
  /// [federationId] - The ID of the federation
  Future<ApiResponse<String>> getFederationLogo(int federationId) async {
    try {
      final Response response = await apiClient.get(
        '/federation-admin-service/federations/$federationId/logo',
      );

      if (response.data["status"] == "success") {
        GetIt.I.get<LoggerService>().i(response.data);
        return ApiResponse.success(
          response.data["data"],
          message: response.data["message"],
          statusCode: response.statusCode,
        );
      } else {
        return ApiResponse.failure(response.data["message"]);
      }
    } catch (e) {
      return ApiResponse.failure('Failed to get federation logo: $e');
    }
  }

  /// Gets the signed URL of a federation docs
  Future<ApiResponse<String>> getFederationDoc({required int fedId, required String docId}) async {
    try {
      final Response response = await apiClient.get(
        '/federation-admin-service/federations/$fedId/documents/$docId/url',
      );

      if (response.data["status"] == "success") {
        GetIt.I.get<LoggerService>().i(response.data);
        return ApiResponse.success(
          response.data["data"],
          message: response.data["message"],
          statusCode: response.statusCode,
        );
      } else {
        return ApiResponse.failure(response.data["message"]);
      }
    } catch (e) {
      return ApiResponse.failure('Failed to get federation logo: $e');
    }
  }

  Future<ApiResponse<List<DocumentModel>>> getFederationDocs({required int fedId}) async {
    try {
      final Response response = await apiClient.get(
        '/federation-admin-service/federations/$fedId/documents',
      );

      if (response.data["status"] == "success") {
        GetIt.I.get<LoggerService>().i(response.data);
        return ApiResponse.success(
          (response.data["data"] as List).map((e) => DocumentModel.fromJson(e)).toList(),
          message: response.data["message"],
          statusCode: response.statusCode,
        );
      } else {
        return ApiResponse.failure(response.data["message"]);
      }
    } catch (e) {
      return ApiResponse.failure('Failed to get federation logo: $e');
    }
  }



  Future<ApiResponse<bool>> deleteFederationDoc({required int fedId, required String docId}) async {
    try {
      final Response response = await apiClient.delete(
        '/federation-admin-service/federations/$fedId/documents/$docId',
      );

      if (response.data["status"] == "success") {
        GetIt.I.get<LoggerService>().i(response.data);
        return ApiResponse.success(
          response.data["data"],
          message: response.data["message"],
          statusCode: response.statusCode,
        );
      } else {
        return ApiResponse.failure(response.data["message"]);
      }
    } catch (e) {
      return ApiResponse.failure('Failed to get federation logo: $e');
    }
  }


  /// Uploads documents for a federation
  /// [federationId] - The ID of the federation
  /// [documentsFileBytes] - The documents file bytes
  /// [fileName] - The name of the file
  Future<ApiResponse<String>> uploadFederationDocuments({
    required int federationId,
    required Uint8List documentsFileBytes,
    String? fileName,
  }) async {
    try {
      final formData = FormData.fromMap({
        'documents': MultipartFile.fromBytes(
          documentsFileBytes.toList(),
          filename: fileName ?? 'documents.pdf',
        ),
      });

      final Response response = await apiClient.post(
        '/federation-admin-service/federations/$federationId/documents',
        data: formData,
      );

      if (response.data["status"] == "success") {
        GetIt.I.get<LoggerService>().i(response.data);
        return ApiResponse.success(
          response.data["data"]?["documentsUrl"] ??
              "Documents uploaded successfully",
          message: response.data["message"],
          statusCode: response.statusCode,
        );
      } else {
        return ApiResponse.failure(response.data["message"]);
      }
    } catch (e) {
      return ApiResponse.failure('Failed to upload documents: $e');
    }
  }

  Future<ApiResponse<bool>> deleteFederation(int federationId) async {
    final Response response = await apiClient.delete(
      '/federation-admin-service/federations/$federationId',
    );

    if (response.data["status"] == "success") {
      return ApiResponse.success(
        true,
        message: response.data["message"],
        statusCode: response.statusCode,
      );
    } else {
      return ApiResponse.failure(response.data["message"]);
    }
  }

  /// Gets member federations for international or continental federations
  Future<ApiResponse<List<FederationMemberModel>>> getMembers(int federationId) async {
    try {
      final Response response = await apiClient.get(
        '/federation-admin-service/federations/$federationId/member-federations',
      );

      if (response.data["status"] == "success") {
        GetIt.I.get<LoggerService>().i(response.data);
        return ApiResponse.success(
          (response.data["data"] as List).map((e) => FederationMemberModel.fromJson(e)).toList(),
          message: response.data["message"],
          statusCode: response.statusCode,
        );
      } else {
        return ApiResponse.failure(response.data["message"]);
      }
    } catch (e) {
      return ApiResponse.failure('Failed to get member federations: $e');
    }
  }

  /// Gets parent federations for national or regional federations
  Future<ApiResponse<List<FederationMemberModel>>> getAffiliations(int federationId) async {
    try {
      final Response response = await apiClient.get(
        '/federation-admin-service/federations/$federationId/parent-federations',
      );

      if (response.data["status"] == "success") {
        GetIt.I.get<LoggerService>().i(response.data);
        return ApiResponse.success(
          (response.data["data"] as List).map((e) => FederationMemberModel.fromJson(e)).toList(),
          message: response.data["message"],
          statusCode: response.statusCode,
        );
      } else {
        return ApiResponse.failure(response.data["message"]);
      }
    } catch (e) {
      return ApiResponse.failure('Failed to get parent federations: $e');
    }
  }

  /// Sets member federations for international or continental federations
  Future<ApiResponse<bool>> setMemberFederations(int federationId, List<int> memberIds) async {
    try {
      final Response response = await apiClient.post(
        '/federation-admin-service/federations/$federationId/member-federations',
        data: {'memberFederationIds': memberIds},
      );

      if (response.data["status"] == "success") {
        logger.i(response.data);
        return ApiResponse.success(
          true,
          message: response.data["message"],
          statusCode: response.statusCode,
        );
      } else {
        return ApiResponse.failure(response.data["message"]);
      }
    } catch (e) {
      logger.e(e);
      return ApiResponse.failure('Failed to set member federations: $e');
    }
  }

  /// Sets parent federations for national or regional federations
  Future<ApiResponse<bool>> setFederationAffiliations(int federationId, List<int> parentIds) async {
    try {
      final Response response = await apiClient.post(
        '/federation-admin-service/federations/$federationId/parent-federations',
        data: {'parentIds': parentIds},
      );

      if (response.data["status"] == "success") {
        GetIt.I.get<LoggerService>().i(response.data);
        return ApiResponse.success(
          true,
          message: response.data["message"],
          statusCode: response.statusCode,
        );
      } else {
        return ApiResponse.failure(response.data["message"]);
      }
    } catch (e) {
      return ApiResponse.failure('Failed to set federation affiliations: $e');
    }
  }
}
