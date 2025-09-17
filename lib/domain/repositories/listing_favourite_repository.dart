import 'package:dartz/dartz.dart';

import '../../data/models/listing_detail_model.dart';
import '../../data/models/listing_reponse_model.dart';

abstract class ListingFavouriteRepository {
  Future<Either<String, ListingResponse>> getListingFavourite(
    int page,
    int limit,
    String listingType, {
    String sort,
  });

  Future<Either<String, ListingDetailModel>> getListingFavouriteById({
    required String id,
  });

  Future<Either<String, ListingResponse>> filterListingFavourite({
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

  Future<Either<String, ListingResponse>> filterListingFavouriteByTypeHouse({
    required int page,
    required int limit,
    required String listingType,
    List<String>? propertyTypes,
    int? minPrice,
    int? maxPrice,
    required String sort,
  });
}
