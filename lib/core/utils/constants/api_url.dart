class ApiUrl {
  static const baseUrl = 'http://192.168.10.102:3001/';

  static const apiV = "api/v1/";

  static const signup = "${apiV}auth/login";

  static const getUser = "${apiV}auth/me";

  static const logout = "${apiV}auth/logout";

  static String getListing({
    required int page,
    required int limit,
    required String listingType,
    String sort = "default",
  }) {
    return "${apiV}listings?page=$page&limit=$limit&listingType=$listingType&sort=$sort";
  }

  static String getListingMe({
    required int page,
    required int limit,
    required String listingType,
    String sort = "default",
  }) {
    return "${apiV}listings/me?page=$page&limit=$limit&listingType=$listingType&sort=$sort";
  }

  static String getListingFavourite({
    required int page,
    required int limit,
    required String listingType,
    String sort = "default",
  }) {
    return "${apiV}listings/liked?page=$page&limit=$limit&listingType=$listingType&sort=$sort";
  }

  static String getListingById({required String id}) {
    return "${apiV}listings/$id";
  }

  static String getListingMeById({required String id}) {
    return "${apiV}listings/me/$id";
  }

  static String getListingFavouriteById({required String id}) {
    return "${apiV}listings/liked/$id";
  }

  static const baseUrlProd = "https://api.onestate-dev.ontik.vn/";

  static const baseUrlImage = "https://file.dev.ontik.vn/re-storage";

  static String getDistricts({required String codeDistrict}) {
    return "${apiV}provinces/$codeDistrict/districts";
  }

  static String getWards({
    required String codeDistrict,
    required String codeWard,
  }) {
    return "${apiV}provinces/$codeDistrict/districts/$codeWard/wards";
  }

  static String filterListingUrl({
    required int page,
    required int limit,
    required String provinceCode,
    required String districtCode,
    required String wardCode,
    required List<String> tags,
    required String streetName,
    required double minActualAreaSqm,
    required double maxActualAreaSqm,
    required double minNumberOfFloors,
    required double maxNumberOfFloors,
    required double minFrontageMeters,
    required double maxFrontageMeters,
    required String listingType,
    required String sort,
  }) {
    try {
      final queryParams = {
        'page': page.toString(),
        'limit': limit.toString(),
        'provinceCode': provinceCode,
        'districtCode': districtCode,
        'wardCode': wardCode,
        'streetName': streetName,
        'minActualAreaSqm': minActualAreaSqm.toString(),
        'maxActualAreaSqm': maxActualAreaSqm.toString(),
        'minNumberOfFloors': minNumberOfFloors.toString(),
        'maxNumberOfFloors': maxNumberOfFloors.toString(),
        'minFrontageMeters': minFrontageMeters.toString(),
        'maxFrontageMeters': maxFrontageMeters.toString(),
        'listingType': listingType,
        'sort': sort,
      };

      final baseQuery = Uri(queryParameters: queryParams).query;

      final tagQuery = tags
          .map((tag) => 'tags=${Uri.encodeComponent(tag)}')
          .join('&');

      final fullQuery = [
        baseQuery,
        tagQuery,
      ].where((q) => q.isNotEmpty).join('&');

      return '${apiV}listings?$fullQuery';
    } catch (e) {
      return '';
    }
  }

  static String filterListingMeUrl({
    required int page,
    required int limit,
    required String provinceCode,
    required String districtCode,
    required String wardCode,
    required List<String> tags,
    required String streetName,
    required double minActualAreaSqm,
    required double maxActualAreaSqm,
    required double minNumberOfFloors,
    required double maxNumberOfFloors,
    required double minFrontageMeters,
    required double maxFrontageMeters,
    required String listingType,
    required String sort,
  }) {
    try {
      final queryParams = {
        'page': page.toString(),
        'limit': limit.toString(),
        'provinceCode': provinceCode,
        'districtCode': districtCode,
        'wardCode': wardCode,
        'streetName': streetName,
        'minActualAreaSqm': minActualAreaSqm.toString(),
        'maxActualAreaSqm': maxActualAreaSqm.toString(),
        'minNumberOfFloors': minNumberOfFloors.toString(),
        'maxNumberOfFloors': maxNumberOfFloors.toString(),
        'minFrontageMeters': minFrontageMeters.toString(),
        'maxFrontageMeters': maxFrontageMeters.toString(),
        'listingType': listingType,
        'sort': sort,
      };

      final baseQuery = Uri(queryParameters: queryParams).query;

      final tagQuery = tags
          .map((tag) => 'tags=${Uri.encodeComponent(tag)}')
          .join('&');

      final fullQuery = [
        baseQuery,
        tagQuery,
      ].where((q) => q.isNotEmpty).join('&');

      return '${apiV}listings/me?$fullQuery';
    } catch (e) {
      return '';
    }
  }

  static String filterListingFavouriteUrl({
    required int page,
    required int limit,
    required String provinceCode,
    required String districtCode,
    required String wardCode,
    required List<String> tags,
    required String streetName,
    required double minActualAreaSqm,
    required double maxActualAreaSqm,
    required double minNumberOfFloors,
    required double maxNumberOfFloors,
    required double minFrontageMeters,
    required double maxFrontageMeters,
    required String listingType,
    required String sort,
  }) {
    try {
      final queryParams = {
        'page': page.toString(),
        'limit': limit.toString(),
        'provinceCode': provinceCode,
        'districtCode': districtCode,
        'wardCode': wardCode,
        'streetName': streetName,
        'minActualAreaSqm': minActualAreaSqm.toString(),
        'maxActualAreaSqm': maxActualAreaSqm.toString(),
        'minNumberOfFloors': minNumberOfFloors.toString(),
        'maxNumberOfFloors': maxNumberOfFloors.toString(),
        'minFrontageMeters': minFrontageMeters.toString(),
        'maxFrontageMeters': maxFrontageMeters.toString(),
        'listingType': listingType,
        'sort': sort,
      };

      final baseQuery = Uri(queryParameters: queryParams).query;

      final tagQuery = tags
          .map((tag) => 'tags=${Uri.encodeComponent(tag)}')
          .join('&');

      final fullQuery = [
        baseQuery,
        tagQuery,
      ].where((q) => q.isNotEmpty).join('&');

      return '${apiV}listings/liked?$fullQuery';
    } catch (e) {
      return '';
    }
  }

  static String filterListingByTypeHouseUrl({
    required int page,
    required int limit,
    required String listingType,
    List<String>? propertyTypes,
    int? minPrice,
    int? maxPrice,
    required String sort,
  }) {
    try {
      final queryParams = {
        'page': page.toString(),
        'limit': limit.toString(),
        'listingType': listingType,
        'sort': sort,
      };

      if (minPrice != null) {
        queryParams['minPrice'] = (minPrice * 1000000000).toString();
      }
      if (maxPrice != null) {
        queryParams['maxPrice'] = (maxPrice * 1000000000).toString();
      }

      final baseQuery = Uri(queryParameters: queryParams).query;

      final propertyTypesQuery =
          (propertyTypes != null && propertyTypes.isNotEmpty)
              ? propertyTypes
                  .map((type) => 'propertyTypes=${Uri.encodeComponent(type)}')
                  .join('&')
              : '';

      final fullQuery = [
        baseQuery,
        propertyTypesQuery,
      ].where((q) => q.isNotEmpty).join('&');

      return '${apiV}listings?$fullQuery';
    } catch (e) {
      return '';
    }
  }

  static String filterListingMeByTypeHouseUrl({
    required int page,
    required int limit,
    required String listingType,
    List<String>? propertyTypes,
    int? minPrice,
    int? maxPrice,
    required String sort,
  }) {
    try {
      final queryParams = {
        'page': page.toString(),
        'limit': limit.toString(),
        'listingType': listingType,
        'sort': sort,
      };

      if (minPrice != null) {
        queryParams['minPrice'] = (minPrice * 1000000000).toString();
      }
      if (maxPrice != null) {
        queryParams['maxPrice'] = (maxPrice * 1000000000).toString();
      }

      final baseQuery = Uri(queryParameters: queryParams).query;

      final propertyTypesQuery =
          (propertyTypes != null && propertyTypes.isNotEmpty)
              ? propertyTypes
                  .map((type) => 'propertyTypes=${Uri.encodeComponent(type)}')
                  .join('&')
              : '';
      final fullQuery = [
        baseQuery,
        propertyTypesQuery,
      ].where((q) => q.isNotEmpty).join('&');

      return '${apiV}listings/me?$fullQuery';
    } catch (e) {
      return '';
    }
  }

  static String filterListingFavouriteByTypeHouseUrl({
    required int page,
    required int limit,
    required String listingType,
    List<String>? propertyTypes,
    int? minPrice,
    int? maxPrice,
    required String sort,
  }) {
    try {
      final queryParams = {
        'page': page.toString(),
        'limit': limit.toString(),
        'listingType': listingType,
        'sort': sort,
      };

      if (minPrice != null) {
        queryParams['minPrice'] = (minPrice * 1000000000).toString();
      }
      if (maxPrice != null) {
        queryParams['maxPrice'] = (maxPrice * 1000000000).toString();
      }

      final baseQuery = Uri(queryParameters: queryParams).query;

      final propertyTypesQuery =
          (propertyTypes != null && propertyTypes.isNotEmpty)
              ? propertyTypes
                  .map((type) => 'propertyTypes=${Uri.encodeComponent(type)}')
                  .join('&')
              : '';
      final fullQuery = [
        baseQuery,
        propertyTypesQuery,
      ].where((q) => q.isNotEmpty).join('&');

      return '${apiV}listings/me?$fullQuery';
    } catch (e) {
      return '';
    }
  }

  static String likeListing({required String id}) {
    return "${apiV}listings/$id/like";
  }
}
