import 'dart:io';

import 'package:app_real_estate/core/utils/log_utils.dart';
import 'package:app_real_estate/data/datasources/dblocal/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class ApiMethod {
  Map<String, dynamic> cleanEmptyFields(Map<String, dynamic>? data) {
    if (data == null) {
      return {};
    }
    Map<String, dynamic> cleaned = {};

    data.forEach((key, value) {
      if (value == null) {
        // Bỏ qua nếu là null
        return;
      }

      if (value is String && value.trim().isEmpty) {
        // Bỏ qua nếu là chuỗi rỗng hoặc chỉ chứa khoảng trắng
        return;
      }

      if (value is List) {
        List<dynamic> cleanedList =
            value
                .map((item) {
                  if (item is Map<String, dynamic>) {
                    return cleanEmptyFields(item);
                  }
                  return item;
                })
                .where((item) {
                  if (item is Map) {
                    return item.values.any(
                      (v) => !(v is String && v.toString().trim().isEmpty),
                    );
                  }
                  return true;
                })
                .toList();

        cleaned[key] = cleanedList;
      } else if (value is Map<String, dynamic>) {
        final nestedCleaned = cleanEmptyFields(value);
        cleaned[key] = nestedCleaned;
      } else {
        cleaned[key] = value;
      }
    });

    return cleaned;
  }

  Map<String, dynamic> _handleApiError(dynamic error) {
    if (error is DioException) {
      // Trường hợp có response từ server
      if (error.response != null) {
        final statusCode = error.response?.statusCode;
        final data = error.response?.data;

        String message = "Không thành công";

        // ✅ Nếu response.data là Map
        if (data is Map<String, dynamic>) {
          // Ưu tiên lấy message
          if (data["message"] is String) {
            message = data["message"];
          }

          // Nếu có errors
          final errors = data["errors"];
          if (errors is List && errors.isNotEmpty) {
            message = errors.first.toString();
          }
        } else if (data is String) {
          // Nếu server trả về string
          message = data;
        }

        switch (statusCode) {
          // case 400:
          //   return {"error": "Yêu cầu không hợp lệ: $message"};
          // case 401:
          //   return {"error": "Không có quyền truy cập: $message"};
          // case 403:
          //   return {"error": "Bị từ chối truy cập: $message"};
          // case 404:
          //   return {"error": "Không tìm thấy dữ liệu: $message"};
          case 422:
            return {"error": message};
          // case 500:
          //   return {"error": "Lỗi server: $message"};
          default:
            return {"error": message};
        }
      } else {
        // Lỗi không có response => kết nối
        switch (error.type) {
          case DioExceptionType.connectionTimeout:
            return {"error": "Kết nối quá hạn"};
          case DioExceptionType.receiveTimeout:
            return {"error": "Quá thời gian phản hồi"};
          case DioExceptionType.connectionError:
            return {"error": "Không thể kết nối hệ thống"};
          default:
            return {"error": "Lỗi mạng: ${error.message}"};
        }
      }
    }

    // Trường hợp lỗi không phải Dio
    return {"error": "Lỗi không xác định: $error"};
  }

  Dio get _dio => Dio(
    BaseOptions(
      baseUrl:
          "https://api.onestate-dev.ontik.vn/api/v1/", // 💡 Lấy baseUrl động mỗi lần dùng
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      contentType: "application/json",
    ),
  );

  Dio get _dioFormData => Dio(
    BaseOptions(
      baseUrl:
          "https://file.dev.ontik.vn/re-storage", // 💡 Lấy baseUrl động mỗi lần dùng
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      contentType: "application/json",
    ),
  );

  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParams,
    bool isToken = true,
  }) async {
    try {
      Map<String, dynamic> headers = {
        'Content-Type': 'application/json',
        'accept': 'application/json',
      };
      if (isToken == true) {
        String? token = SharedPreferenceApp.handleGetString('accessToken');
        if (token == null) {
          return {"error": "Token không tồn tại. Vui lòng đăng nhập lại."};
        }
        headers["Authorization"] = 'Bearer $token';
      }
      body = cleanEmptyFields(body);
      Log.showLoggerMapList({
        "method": "post",
        "queryParameters": queryParams,
        "path": path,
        "body": body,
      });
      Response response = await _dio.post(
        queryParameters: queryParams,
        path,
        data: body,
        options: Options(headers: headers),
      );
      Map<String, dynamic> data = response.data;

      if (data['statusCode'] == 200) {
        return data;
      } else {
        return {"error": "${data['error']}"};
      }
    } catch (e) {
      return _handleApiError(e);
    }
  }

  Future<Map<String, dynamic>> put(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParams,
    bool isToken = true,
  }) async {
    try {
      Map<String, dynamic> headers = {
        'Content-Type': 'application/json',
        'accept': 'application/json',
      };
      if (isToken == true) {
        String? token = SharedPreferenceApp.handleGetString('accessToken');
        if (token == null) {
          return {"error": "Token không tồn tại. Vui lòng đăng nhập lại."};
        }
        headers["Authorization"] = 'Bearer $token';
      }
      body = cleanEmptyFields(body);
      Log.showLoggerMapList({
        "method": "put",
        "queryParameters": queryParams,
        "path": path,
        "body": body,
      });
      Response response = await _dio.put(
        queryParameters: queryParams,
        path,
        data: body,
        options: Options(headers: headers),
      );
      Map<String, dynamic> data = response.data;
      if (data['statusCode'] == 200) {
        return data;
      } else {
        return {"error": "${data['error']}"};
      }
    } catch (e) {
      return _handleApiError(e);
    }
  }

  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParams,
    bool isToken = true,
  }) async {
    try {
      Map<String, dynamic> headers = {
        'Content-Type': 'application/json',
        'accept': 'application/json',
      };
      if (isToken == true) {
        String? token = SharedPreferenceApp.handleGetString('accessToken');
        if (token == null) {
          return {"error": "Token không tồn tại. Vui lòng đăng nhập lại."};
        }
        headers["Authorization"] = 'Bearer $token';
      }
      body = cleanEmptyFields(body);
      Log.showLoggerMapList({
        "method": "get",
        "path": path,
        "body": body,
        "queryParameters": queryParams,
      });
      Response response = await _dio.get(
        queryParameters: queryParams,
        path,
        data: body,
        options: Options(headers: headers),
      );
      Map<String, dynamic> data = response.data;
      if (data['statusCode'] == 200) {
        return data;
      } else {
        return {"error": "${data['error']}"};
      }
    } catch (e) {
      return _handleApiError(e);
    }
  }

  Future<Map<String, dynamic>> delete(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParams,
    bool isToken = true,
  }) async {
    try {
      Map<String, dynamic> headers = {
        'Content-Type': 'application/json',
        'accept': 'application/json',
      };
      if (isToken == true) {
        String? token = SharedPreferenceApp.handleGetString('accessToken');
        if (token == null) {
          return {"error": "Token không tồn tại. Vui lòng đăng nhập lại."};
        }
        headers["Authorization"] = 'Bearer $token';
      }
      body = cleanEmptyFields(body);
      Log.showLoggerMapList({
        "method": "delete",
        "queryParameters": queryParams,
        "path": path,
        "body": body,
      });
      Response response = await _dio.delete(
        queryParameters: queryParams,
        path,
        data: body,
        options: Options(headers: headers),
      );
      Map<String, dynamic> data = response.data;

      if (data['statusCode'] == 200) {
        return data;
      } else {
        return {"error": "${data['error']}"};
      }
    } catch (e) {
      return _handleApiError(e);
    }
  }

  Future<Map<String, dynamic>> uploadFile(
    String path, {
    required File file,
    String fieldName = "file",
    Map<String, dynamic>? extraData, // nếu cần gửi thêm dữ liệu kèm file
    bool isToken = true,
  }) async {
    try {
      // Chuẩn bị headers
      Map<String, dynamic> headers = {
        'accept': 'application/json',
        'Content-Type': 'multipart/form-data',
      };

      if (isToken) {
        String? token = SharedPreferenceApp.handleGetString('accessToken');
        if (token == null) {
          return {"error": "Token không tồn tại. Vui lòng đăng nhập lại."};
        }
        headers["Authorization"] = 'Bearer $token';
      }

      // Lấy tên file & mimeType
      final fileName = file.path.split('/').last;
      final mimeType = lookupMimeType(file.path) ?? "application/octet-stream";

      // Multipart file
      final multipartFile = await MultipartFile.fromFile(
        file.path,
        filename: fileName,
        contentType: MediaType.parse(mimeType),
      );

      // Gom FormData
      final formData = FormData.fromMap({
        fieldName: multipartFile,
        ...?extraData, // nếu có thêm data kèm theo
      });

      // Log request
      Log.showLoggerMapList({
        "method": "post",
        "upload": true,
        "path": path,
        "file": fileName,
        "extraData": extraData,
      });

      // Gửi request
      final response = await _dioFormData.post(
        path,
        data: formData,
        options: Options(headers: headers),
      );

      // Xử lý response
      if (response.statusCode == 200 || response.statusCode == 201) {
        final resData = response.data;
        if (resData is Map<String, dynamic>) {
          return resData;
        } else {
          return {"data": resData};
        }
      } else {
        return {
          "error": "Lỗi: ${response.statusCode} - ${response.statusMessage}",
        };
      }
    } catch (e) {
      return _handleApiError(e);
    }
  }
}
