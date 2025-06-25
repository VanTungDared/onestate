import 'package:dio/dio.dart';

import '../constants/api_url.dart';
import 'interceptor.dart';

class DioClient {
  late final Dio _dio;
  late final AuthorizationInterceptor _authorizationInterceptor;
  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiUrl.baseUrl,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        responseType: ResponseType.json,
        sendTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );
    _authorizationInterceptor = AuthorizationInterceptor(_dio);

    _dio.interceptors.addAll([_authorizationInterceptor, LoggerInterceptor()]);
  }

  // GET METHOD
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }

  // POST METHOD
  Future<Response> post(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.post(
        url,
        data: data,
        options: options,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // PUT METHOD
  Future<Response> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // DELETE METHOD
  Future<dynamic> delete(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final Response response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}


// Future<Map<String, dynamic>> getListings({
//   int page = 1,
//   int limit = 10,
//   String? title,
//   String? status, // DRAFT hoặc PUBLISHED
// }) async {
//   try {
//     // Lấy token từ SharedPreferences
//     String? token = SharedPreferenceApp.handleGetString('accessToken');
//     if (token == null) {
//       return {"error": "Token không tồn tại. Vui lòng đăng nhập lại."};
//     }
//
//     // Chuẩn bị query parameters
//     Map<String, dynamic> queryParams = {'page': page, 'limit': limit};
//
//     if (title != null && title.isNotEmpty) {
//       queryParams['title'] = title;
//     }
//     if (status != null && status.isNotEmpty) {
//       queryParams['status'] = status;
//     }
//
//     // Gọi API
//     Response response = await _dio.get(
//       "listings",
//       queryParameters: queryParams,
//       options: Options(
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//       ),
//     );
//
//     Map<String, dynamic> data = response.data;
//     if (response.statusCode == 200) {
//       Map<String, dynamic> result = data["data"];
//       return result;
//     } else {
//       return {"error": "Có lỗi xảy ra: ${response.statusMessage}"};
//     }
//   } catch (e) {
//     print("Lỗi khi gọi API listings: $e");
//     return {"error": "Lỗi khi gọi API"};
//   }
// }
//
// String getFullUrl(String? path) {
//   if (path == null || path.isEmpty) {
//     return "https://via.placeholder.com/150"; // fallback nếu không có ảnh
//   }
//   if (path.startsWith('http')) {
//     return path; // đã full URL rồi thì trả thẳng
//   }
//   return "$_baseUrl/$path";
// }
//
// Future<Map<String, dynamic>> getListingDetail(String id) async {
//   try {
//     // Lấy token từ SharedPreferences
//     String? token = SharedPreferenceApp.handleGetString('accessToken');
//     if (token == null) {
//       return {"error": "Token không tồn tại. Vui lòng đăng nhập lại."};
//     }
//
//     // Gọi API
//     Response response = await _dio.get(
//       "listings/$id",
//       options: Options(
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//       ),
//     );
//
//     Map<String, dynamic> data = response.data;
//     if (response.statusCode == 200) {
//       Map<String, dynamic> result = data["data"];
//       return result;
//     } else {
//       return {"error": "Có lỗi xảy ra: ${response.statusMessage}"};
//     }
//   } catch (e) {
//     print("Lỗi khi gọi API listing detail: $e");
//     return {"error": "Lỗi khi gọi API"};
//   }
// }
//
// Future<Map<String, dynamic>> likeListing(String id) async {
//   try {
//     // Lấy token từ SharedPreferences
//     String? token = SharedPreferenceApp.handleGetString('accessToken');
//     if (token == null) {
//       return {"error": "Token không tồn tại. Vui lòng đăng nhập lại."};
//     }
//
//     // Gọi API POST
//     Response response = await _dio.post(
//       "listings/$id/like",
//       options: Options(
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//       ),
//     );
//
//     if (response.statusCode == 200) {
//       // Giả sử API trả về { "message": "Listing liked successfully" }
//       return {
//         "success": true,
//         "message": response.data['message'] ?? "Đã thích thành công",
//       };
//     } else {
//       return {"error": "Có lỗi xảy ra: ${response.statusMessage}"};
//     }
//   } catch (e) {
//     print("Lỗi khi gọi API like listing: $e");
//     return {"error": "Lỗi khi gọi API"};
//   }
// }
//
// Future<Map<String, dynamic>> getCurrentUser() async {
//   try {
//     // Lấy token
//     String? token = SharedPreferenceApp.handleGetString('accessToken');
//     if (token == null) {
//       return {"error": "Token không tồn tại. Vui lòng đăng nhập lại."};
//     }
//
//     // Gọi API
//     final response = await _dio.get(
//       'auth/me',
//       options: Options(
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//       ),
//     );
//
//     Map<String, dynamic> data = response.data;
//     if (response.statusCode == 200) {
//       Map<String, dynamic> result = data["data"];
//       return result;
//     } else {
//       return {"error": "Có lỗi xảy ra: ${response.statusMessage}"};
//     }
//   } catch (e) {
//     return {"error": "Lỗi khi gọi API"};
//   }
// }
//
// Future<Map<String, dynamic>> getListingsMe({
//   int page = 1,
//   int limit = 10,
//   String? title,
//   String? status, // DRAFT hoặc PUBLISHED
// }) async {
//   try {
//     // Lấy token từ SharedPreferences
//     String? token = SharedPreferenceApp.handleGetString('accessToken');
//     if (token == null) {
//       return {"error": "Token không tồn tại. Vui lòng đăng nhập lại."};
//     }
//
//     // Chuẩn bị query parameters
//     Map<String, dynamic> queryParams = {'page': page, 'limit': limit};
//
//     if (title != null && title.isNotEmpty) {
//       queryParams['title'] = title;
//     }
//     if (status != null && status.isNotEmpty) {
//       queryParams['status'] = status;
//     }
//
//     // Gọi API
//     Response response = await _dio.get(
//       "listings/me",
//       queryParameters: queryParams,
//       options: Options(
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//       ),
//     );
//
//     Map<String, dynamic> data = response.data;
//     if (response.statusCode == 200) {
//       Map<String, dynamic> result = data["data"];
//       return result;
//     } else {
//       return {"error": "Có lỗi xảy ra: ${response.statusMessage}"};
//     }
//   } catch (e) {
//     print("Lỗi khi gọi API listings: $e");
//     return {"error": "Lỗi khi gọi API"};
//   }
// }
//
// Future<Map<String, dynamic>> getListingsLiked({
//   int page = 1,
//   int limit = 10,
//   String? title,
//   String? status, // DRAFT hoặc PUBLISHED
// }) async {
//   try {
//     // Lấy token từ SharedPreferences
//     String? token = SharedPreferenceApp.handleGetString('accessToken');
//     if (token == null) {
//       return {"error": "Token không tồn tại. Vui lòng đăng nhập lại."};
//     }
//
//     // Chuẩn bị query parameters
//     Map<String, dynamic> queryParams = {'page': page, 'limit': limit};
//
//     if (title != null && title.isNotEmpty) {
//       queryParams['title'] = title;
//     }
//     if (status != null && status.isNotEmpty) {
//       queryParams['status'] = status;
//     }
//
//     // Gọi API
//     Response response = await _dio.get(
//       "listings/liked",
//       queryParameters: queryParams,
//       options: Options(
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//       ),
//     );
//
//     Map<String, dynamic> data = response.data;
//     if (response.statusCode == 200) {
//       Map<String, dynamic> result = data["data"];
//       return result;
//     } else {
//       return {"error": "Có lỗi xảy ra: ${response.statusMessage}"};
//     }
//   } catch (e) {
//     print("Lỗi khi gọi API listings: $e");
//     return {"error": "Lỗi khi gọi API"};
//   }
// }
