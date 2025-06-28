import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/api/api_client.dart';
import '../../../core/utils/constants/api_url.dart';
import '../../models/ListingModel.dart';
import '../../models/listing_detail_model.dart';

abstract class ListingRemoteDataSource {
  Future<Either<String, List<ListingModel>>> getListing({
    required int page,
    required int limit,
    required String listingType,
    String sort,
  });

  Future<Either<String, ListingDetailModel>> getListingById({required String id});
}

class ListingRemoteDataSourceImpl implements ListingRemoteDataSource {
  @override
  Future<Either<String, List<ListingModel>>> getListing({
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
      final data = response.data['data']['data'] as List;

      final listings = data.map((json) => ListingModel.fromJson(json)).toList();
      return Right(listings);
    } catch (e) {
      if (e is DioException) {
        final errorMessage =
            e.response?.data['message'] ?? 'Get listing failure';
        return Left(errorMessage);
      }
      //return const Left('An unexpected error occurred');
      debugPrint(e.toString());
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
}
