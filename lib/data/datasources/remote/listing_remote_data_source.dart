import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../core/utils/api/api_client.dart';
import '../../../core/utils/constants/api_url.dart';
import '../../models/listing_detail_model.dart';
import '../../models/listing_reponse_model.dart';

abstract class ListingRemoteDataSource {
  Future<Either<String, ListingResponse>> getListing({
    required int page,
    required int limit,
    required String listingType,
    String sort,
  });

  Future<Either<String, ListingDetailModel>> getListingById({
    required String id,
  });

  Future<Either<String, ListingResponse>> filterListing({
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
  });

  Future<Either<String, ListingResponse>> filterListingByTypeHouse({
    required int page,
    required int limit,
    required String listingType,
    List<String>? propertyTypes,
    int? minPrice,
    int? maxPrice,
    required String sort,
  });
}

class ListingRemoteDataSourceImpl implements ListingRemoteDataSource {
  @override
  Future<Either<String, ListingResponse>> getListing({
    required int page,
    required int limit,
    required String listingType,
    String sort = "default",
  }) async {
    try {
      final url = ApiUrl.getListing(
        page: page,
        limit: limit,
        listingType: listingType,
        sort: sort,
      );

      final response = await Get.find<DioClient>().get(url);
      final jsonData = response.data['data'];
      final result = ListingResponse.fromJson(jsonData);
      return Right(result);
    } catch (e) {
      if (e is DioException) {
        final errorMessage =
            e.response?.data['message'] ?? 'Get listing failure';
        return Left(errorMessage);
      }
      //return const Left('An unexpected error occurred');
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, ListingDetailModel>> getListingById({
    required String id,
  }) async {
    try {
      final url = ApiUrl.getListingById(id: id);

      final response = await Get.find<DioClient>().get(url);
      final data = response.data['data'];
      final listing = ListingDetailModel.fromJson(data);

      return Right(listing);
    } catch (e) {
      if (e is DioException) {
        final errorMessage =
            e.response?.data['message'] ?? 'Get listing failure';
        return Left(errorMessage);
      }
      //return const Left('An unexpected error occurred');
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, ListingResponse>> filterListing({
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
  }) async {
    try {
      final url = ApiUrl.filterListingUrl(
        page: page,
        limit: limit,
        provinceCode: provinceCode,
        districtCode: districtCode,
        wardCode: wardCode,
        tags: tags,
        streetName: streetName,
        minActualAreaSqm: minActualAreaSqm,
        maxActualAreaSqm: maxActualAreaSqm,
        minNumberOfFloors: minNumberOfFloors,
        maxNumberOfFloors: maxNumberOfFloors,
        minFrontageMeters: minFrontageMeters,
        maxFrontageMeters: maxFrontageMeters,
        listingType: listingType,
        sort: sort,
      );

      final response = await Get.find<DioClient>().get(url);
      final jsonData = response.data['data'];
      final result = ListingResponse.fromJson(jsonData);
      return Right(result);
    } catch (e) {
      if (e is DioException) {
        final errorMessage =
            e.response?.data['message'] ?? 'Get listing failure';
        return Left(errorMessage);
      }
      //return const Left('An unexpected error occurred');
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, ListingResponse>> filterListingByTypeHouse({
    required int page,
    required int limit,
    required String listingType,
    List<String>? propertyTypes,
    int? minPrice,
    int? maxPrice,
    required String sort,
  }) async {
    try {
      final url = ApiUrl.filterListingByTypeHouseUrl(
        page: page,
        limit: limit,
        listingType: listingType,
        propertyTypes: propertyTypes,
        minPrice: minPrice,
        maxPrice: maxPrice,
        sort: sort,
      );

      final response = await Get.find<DioClient>().get(url);
      final jsonData = response.data['data'];
      final result = ListingResponse.fromJson(jsonData);
      return Right(result);
    } catch (e) {
      if (e is DioException) {
        final errorMessage =
            e.response?.data['message'] ?? 'Get listing failure';
        return Left(errorMessage);
      }
      //return const Left('An unexpected error occurred');
      return Left(e.toString());
    }
  }
}
