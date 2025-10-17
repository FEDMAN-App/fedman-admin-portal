
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:fedman_admin_app/core/utils/logger_service.dart';
import 'package:get_it/get_it.dart';


import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/network/paginated_response.dart';
import '../models/discipline_model.dart';

class DisciplineRepo {
  final ApiClient apiClient;

  DisciplineRepo({required this.apiClient});
  final logger = GetIt.I.get<LoggerService>();

  Future<ApiResponse<PaginatedResponse<DisciplineModel>>> getDisciplines({
    int page = 1,
    int? limit = 10,
    String? search,
    bool? status,
    String? sportType,
    bool? hasRanking,
  }) async {
    final Map<String, dynamic> queryParams = {'page': page};

    if (search != null && search.isNotEmpty) {
      queryParams['search'] = search;
    }

    if (status != null) {
      queryParams['includeInactive'] = !status;
    }

    if (sportType != null && sportType.isNotEmpty && sportType != 'All Sports') {
      queryParams['sportType'] = sportType;
    }

    if (hasRanking != null) {
      queryParams['hasRanking'] = hasRanking;
    }

    if (limit != null) {
      queryParams['limit'] = limit;
    }

    final Response response = await apiClient.get(
      '/federation-admin-service/disciplines',
      queryParameters: queryParams,
    );

    if (response.data["status"] == "success") {
      GetIt.I.get<LoggerService>().i(response.data["data"]);
      try {
        final paginatedResponse = PaginatedResponse.fromJson(
          response.data["data"],
          (json) {
            return DisciplineModel.fromJson(json);
          },
        );

        return ApiResponse.success(
          paginatedResponse,
          message: response.data["message"],
          statusCode: response.statusCode,
        );
      } catch (e, stackTrace) {
        logger.e('Failed to parse disciplines data + $e');
        return ApiResponse.failure('Failed to parse disciplines data: $e');
      }
    } else {
      logger.e('Failed to get disciplines: ${response.data["message"]}');
      return ApiResponse.failure(response.data["message"]);
    }
  }

  Future<ApiResponse<DisciplineModel>> getDiscipline(int disciplineId) async {
    final Response response = await apiClient.get(
      '/federation-admin-service/disciplines/$disciplineId',
    );

    if (response.data["status"] == "success") {
      final disciplineData = DisciplineModel.fromJson(response.data["data"]);
      GetIt.I.get<LoggerService>().i(response.data["data"]);
      return ApiResponse.success(
        disciplineData,
        message: response.data["message"],
        statusCode: response.statusCode,
      );
    } else {
      logger.e('Failed to get discipline: ${response.data["message"]}');
      return ApiResponse.failure(response.data["message"]);
    }
  }

  Future<ApiResponse<DisciplineModel>> createDiscipline(
    DisciplineModel discipline,
  ) async {
    final Response response = await apiClient.post(
      '/federation-admin-service/disciplines',
      data: discipline.toJson(),
    );
    GetIt.I.get<LoggerService>().i(discipline.toJson());
    if (response.data["status"] == "success") {
      final disciplineData = DisciplineModel.fromJson(response.data["data"]);
      return ApiResponse.success(
        disciplineData,
        message: response.data["message"],
        statusCode: response.statusCode,
      );
    } else {
      logger.e('Failed to create discipline: ${response.data["message"]}');
      return ApiResponse.failure(response.data["message"]);
    }
  }

  Future<ApiResponse<DisciplineModel>> updateDiscipline(
    int disciplineId,
    DisciplineModel discipline,
  ) async {
    final Response response = await apiClient.put(
      '/federation-admin-service/disciplines/$disciplineId',
      data: discipline.toJson(),
    );
    GetIt.I.get<LoggerService>().i(discipline.toJson());
    if (response.data["status"] == "success") {
      final disciplineData = DisciplineModel.fromJson(response.data["data"]);
      return ApiResponse.success(
        disciplineData,
        message: response.data["message"],
        statusCode: response.statusCode,
      );
    } else {
      logger.e('Failed to update discipline: ${response.data["message"]}');
      return ApiResponse.failure(response.data["message"]);
    }
  }

  Future<ApiResponse<bool>> deactivateDiscipline(int disciplineId) async {
    final Response response = await apiClient.put(
      '/federation-admin-service/disciplines/$disciplineId/deactivate',
    );

    if (response.data["status"] == "success") {
      return ApiResponse.success(
        true,
        message: response.data["message"],
        statusCode: response.statusCode,
      );
    } else {
      logger.e('Failed to deactivate discipline: ${response.data["message"]}');
      return ApiResponse.failure(response.data["message"]);
    }
  }

  Future<ApiResponse<bool>> activateDiscipline(int disciplineId) async {
    final Response response = await apiClient.put(
      '/federation-admin-service/disciplines/$disciplineId/activate',
    );

    if (response.data["status"] == "success") {
      return ApiResponse.success(
        true,
        message: response.data["message"],
        statusCode: response.statusCode,
      );
    } else {
      logger.e('Failed to activate discipline: ${response.data["message"]}');
      return ApiResponse.failure(response.data["message"]);
    }
  }

  Future<ApiResponse<bool>> deleteDiscipline(int disciplineId) async {
    final Response response = await apiClient.delete(
      '/federation-admin-service/disciplines/$disciplineId',
    );

    if (response.data["status"] == "success") {
      return ApiResponse.success(
        true,
        message: response.data["message"],
        statusCode: response.statusCode,
      );
    } else {
      logger.e('Failed to delete discipline: ${response.data["message"]}');
      return ApiResponse.failure(response.data["message"]);
    }
  }

  Future<ApiResponse<String>> getDisciplineImage(int disciplineId) async {
    final Response response = await apiClient.get(
      '/federation-admin-service/disciplines/$disciplineId/logo',
    );

    if (response.data["status"] == "success") {
      return ApiResponse.success(
        response.data["data"]?? '',
        message: response.data["message"],
        statusCode: response.statusCode,
      );
    } else {
      logger.e('Failed to get discipline image: ${response.data["message"]}');
      return ApiResponse.failure(response.data["message"]);
    }
  }

  /// Uploads a logo for a discipline
  /// [disciplineId] - The ID of the discipline
  /// [logoFileBytes] - The logo file bytes
  /// [fileName] - The name of the file
  Future<ApiResponse<String>> uploadDisciplineImage({
    required int disciplineId,
    required Uint8List logoFileBytes,
    String? fileName,
  }) async {
      final formData = FormData.fromMap({
        'logo': MultipartFile.fromBytes(
          logoFileBytes.toList(),
          filename: fileName ?? 'logo.png',
        ),
      });

      final Response response = await apiClient.post(
        '/federation-admin-service/disciplines/$disciplineId/logo',
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
        logger.e('Failed to upload discipline image: ${response.data["message"]}');
        return ApiResponse.failure(response.data["message"]);
      }

  }

  Future<ApiResponse<bool>> deleteDisciplineImage(int disciplineId) async {
    final Response response = await apiClient.delete(
      '/federation-admin-service/disciplines/$disciplineId/logo',
    );

    if (response.data["status"] == "success") {
      return ApiResponse.success(
        true,
        message: response.data["message"],
        statusCode: response.statusCode,
      );
    } else {
      logger.e('Failed to delete discipline image: ${response.data["message"]}');
      return ApiResponse.failure(response.data["message"]);
    }
  }
}