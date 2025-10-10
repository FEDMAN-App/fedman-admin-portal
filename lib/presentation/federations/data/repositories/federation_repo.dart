import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:fedman_admin_app/core/utils/logger_service.dart';
import 'package:get_it/get_it.dart';

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
      GetIt.I.get<LoggerService>().i(response.data);
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
          response.data["data"]?["documentsUrl"] ?? "Documents uploaded successfully",
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
}
