import 'package:app_real_estate/dblocal/shared_preferences.dart';
import 'package:dio/dio.dart';

class ApiClient {
  static const String _baseUrl = "https://file.dalianperfume.com/re-storage";
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl:
          "https://bds-api.dalianperfume.com/api/v1/", // 🔹 Đổi URL API tại đây
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      contentType: "application/json",
    ),
  );

  // final Dio _dioStore = Dio(
  //   BaseOptions(
  //     baseUrl: "https://apps.ontik.vn/", // 🔹 Đổi URL API tại đây
  //     connectTimeout: const Duration(seconds: 10),
  //     receiveTimeout: const Duration(seconds: 10),
  //     contentType: "application/json",
  //   ),
  // );

  Future<Map<String, dynamic>> login({
    String phoneNumber = '0985495876',
    String password = 'Hao2000@8x',
  }) async {
    try {
      Response response = await _dio.post(
        "auth/login",
        data: {"phoneNumber": phoneNumber, "password": password},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      Map<String, dynamic> data = response.data;
      if (data['statusCode'] == 200) {
        Map<String, dynamic> result = data["data"];
        return result;
      } else {
        return {"error": "Không đúng định dạng"};
      }
    } catch (e) {
      print("Lỗi khi gọi API: $e");
      return {"error": "Lỗi khi gọi API"};
    }
  }

  Future<Map<String, dynamic>> getListings({
    int page = 1,
    int limit = 10,
    String? title,
    String? status, // DRAFT hoặc PUBLISHED
  }) async {
    try {
      // Lấy token từ SharedPreferences
      String? token = SharedPreferenceApp.handleGetString('accessToken');
      if (token == null) {
        return {"error": "Token không tồn tại. Vui lòng đăng nhập lại."};
      }

      // Chuẩn bị query parameters
      Map<String, dynamic> queryParams = {'page': page, 'limit': limit};

      if (title != null && title.isNotEmpty) {
        queryParams['title'] = title;
      }
      if (status != null && status.isNotEmpty) {
        queryParams['status'] = status;
      }

      // Gọi API
      Response response = await _dio.get(
        "listings",
        queryParameters: queryParams,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      Map<String, dynamic> data = response.data;
      if (response.statusCode == 200) {
        Map<String, dynamic> result = data["data"];
        return result;
      } else {
        return {"error": "Có lỗi xảy ra: ${response.statusMessage}"};
      }
    } catch (e) {
      print("Lỗi khi gọi API listings: $e");
      return {"error": "Lỗi khi gọi API"};
    }
  }

  String getFullUrl(String? path) {
    if (path == null || path.isEmpty) {
      return "https://via.placeholder.com/150"; // fallback nếu không có ảnh
    }
    if (path.startsWith('http')) {
      return path; // đã full URL rồi thì trả thẳng
    }
    return "$_baseUrl/$path";
  }

  Future<Map<String, dynamic>> getListingDetail(String id) async {
    try {
      // Lấy token từ SharedPreferences
      String? token = SharedPreferenceApp.handleGetString('accessToken');
      if (token == null) {
        return {"error": "Token không tồn tại. Vui lòng đăng nhập lại."};
      }

      // Gọi API
      Response response = await _dio.get(
        "listings/$id",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      Map<String, dynamic> data = response.data;
      if (response.statusCode == 200) {
        Map<String, dynamic> result = data["data"];
        return result;
      } else {
        return {"error": "Có lỗi xảy ra: ${response.statusMessage}"};
      }
    } catch (e) {
      print("Lỗi khi gọi API listing detail: $e");
      return {"error": "Lỗi khi gọi API"};
    }
  }

  Future<Map<String, dynamic>> likeListing(String id) async {
    try {
      // Lấy token từ SharedPreferences
      String? token = SharedPreferenceApp.handleGetString('accessToken');
      if (token == null) {
        return {"error": "Token không tồn tại. Vui lòng đăng nhập lại."};
      }

      // Gọi API POST
      Response response = await _dio.post(
        "listings/$id/like",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Giả sử API trả về { "message": "Listing liked successfully" }
        return {
          "success": true,
          "message": response.data['message'] ?? "Đã thích thành công",
        };
      } else {
        return {"error": "Có lỗi xảy ra: ${response.statusMessage}"};
      }
    } catch (e) {
      print("Lỗi khi gọi API like listing: $e");
      return {"error": "Lỗi khi gọi API"};
    }
  }

  Future<Map<String, dynamic>> getCurrentUser() async {
    try {
      // Lấy token
      String? token = SharedPreferenceApp.handleGetString('accessToken');
      if (token == null) {
        return {"error": "Token không tồn tại. Vui lòng đăng nhập lại."};
      }

      // Gọi API
      final response = await _dio.get(
        'auth/me',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      Map<String, dynamic> data = response.data;
      if (response.statusCode == 200) {
        Map<String, dynamic> result = data["data"];
        return result;
      } else {
        return {"error": "Có lỗi xảy ra: ${response.statusMessage}"};
      }
    } catch (e) {
      return {"error": "Lỗi khi gọi API"};
    }
  }

  Future<Map<String, dynamic>> getListingsMe({
    int page = 1,
    int limit = 10,
    String? title,
    String? status, // DRAFT hoặc PUBLISHED
  }) async {
    try {
      // Lấy token từ SharedPreferences
      String? token = SharedPreferenceApp.handleGetString('accessToken');
      if (token == null) {
        return {"error": "Token không tồn tại. Vui lòng đăng nhập lại."};
      }

      // Chuẩn bị query parameters
      Map<String, dynamic> queryParams = {'page': page, 'limit': limit};

      if (title != null && title.isNotEmpty) {
        queryParams['title'] = title;
      }
      if (status != null && status.isNotEmpty) {
        queryParams['status'] = status;
      }

      // Gọi API
      Response response = await _dio.get(
        "listings/me",
        queryParameters: queryParams,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      Map<String, dynamic> data = response.data;
      if (response.statusCode == 200) {
        Map<String, dynamic> result = data["data"];
        return result;
      } else {
        return {"error": "Có lỗi xảy ra: ${response.statusMessage}"};
      }
    } catch (e) {
      print("Lỗi khi gọi API listings: $e");
      return {"error": "Lỗi khi gọi API"};
    }
  }

  Future<Map<String, dynamic>> getListingsLiked({
    int page = 1,
    int limit = 10,
    String? title,
    String? status, // DRAFT hoặc PUBLISHED
  }) async {
    try {
      // Lấy token từ SharedPreferences
      String? token = SharedPreferenceApp.handleGetString('accessToken');
      if (token == null) {
        return {"error": "Token không tồn tại. Vui lòng đăng nhập lại."};
      }

      // Chuẩn bị query parameters
      Map<String, dynamic> queryParams = {'page': page, 'limit': limit};

      if (title != null && title.isNotEmpty) {
        queryParams['title'] = title;
      }
      if (status != null && status.isNotEmpty) {
        queryParams['status'] = status;
      }

      // Gọi API
      Response response = await _dio.get(
        "listings/liked",
        queryParameters: queryParams,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      Map<String, dynamic> data = response.data;
      if (response.statusCode == 200) {
        Map<String, dynamic> result = data["data"];
        return result;
      } else {
        return {"error": "Có lỗi xảy ra: ${response.statusMessage}"};
      }
    } catch (e) {
      print("Lỗi khi gọi API listings: $e");
      return {"error": "Lỗi khi gọi API"};
    }
  }
}
