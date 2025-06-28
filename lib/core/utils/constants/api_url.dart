class ApiUrl {
  static const baseUrl = 'http://192.168.10.102:3001/';

  static const apiV = "api/v1/";

  static const signup = "${apiV}auth/login";

  static const getUser = "${apiV}auth/me";

  static String getListing({
    required int page,
    required int limit,
    required String listingType,
    String sort = "default",
  }) {
    return "${apiV}listings?page=$page&limit=$limit&listingType=$listingType&sort=$sort";
  }

  static String getListingById({required String id}) {
    return "${apiV}listings/$id";
  }

  static const baseUrlProd = "https://api.onestate-dev.ontik.vn/";

  static const baseUrlImage = "https://file.dev.ontik.vn/re-storage";
}

