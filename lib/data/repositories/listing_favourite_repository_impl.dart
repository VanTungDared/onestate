import 'package:app_real_estate/data/datasources/remote/listing_favourite_remote_data_source.dart';
import 'package:app_real_estate/domain/repositories/listing_favourite_repository.dart';
import 'package:dartz/dartz.dart';

import '../models/listing_detail_model.dart';
import '../models/listing_reponse_model.dart';

class ListingFavouriteRepositoryImpl implements ListingFavouriteRepository {
  final ListingFavouriteRemoteDataSource remoteDataSource;

  ListingFavouriteRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<String, ListingResponse>> getListingFavourite(
    int page,
    int limit,
    String listingType, {
    String sort = "default",
  }) async {
    final result = await remoteDataSource.getListingFavourite(
      page: page,
      limit: limit,
      listingType: listingType,
      sort: sort,
    );

    return result.fold((error) => Left(error), (listings) => Right(listings));
  }

  @override
  Future<Either<String, ListingDetailModel>> getListingFavouriteById({
    required String id,
  }) async {
    final result = await remoteDataSource.getListingFavouriteById(id: id);

    return result.fold((error) => Left(error), (listings) => Right(listings));
  }

  @override
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
  }) async {
    final result = await remoteDataSource.filterListingFavourite(
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
    return result.fold((error) => Left(error), (listings) => Right(listings));
  }

  @override
  Future<Either<String, ListingResponse>> filterListingFavouriteByTypeHouse({
    required int page,
    required int limit,
    required String listingType,
    List<String>? propertyTypes,
    int? minPrice,
    int? maxPrice,
    required String sort,
  }) async {
    final result = await remoteDataSource.filterListingFavouriteByTypeHouse(
      page: page,
      limit: limit,
      listingType: listingType,
      propertyTypes: propertyTypes,
      minPrice: minPrice,
      maxPrice: maxPrice,
      sort: sort,
    );
    return result.fold((error) => Left(error), (listings) => Right(listings));
  }
}
