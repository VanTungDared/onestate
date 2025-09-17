import 'package:app_real_estate/data/datasources/remote/listing_me_remote_data_source.dart';
import 'package:app_real_estate/domain/repositories/listing_me_repository.dart';
import 'package:dartz/dartz.dart';

import '../models/listing_detail_model.dart';
import '../models/listing_reponse_model.dart';

class ListingMeRepositoryImpl implements ListingMeRepository {
  final ListingMeRemoteDataSource remoteDataSource;

  ListingMeRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<String, ListingResponse>> getListingMe(
    int page,
    int limit,
    String listingType, {
    String sort = "default",
  }) async {
    final result = await remoteDataSource.getListingMe(
      page: page,
      limit: limit,
      listingType: listingType,
      sort: sort,
    );

    return result.fold((error) => Left(error), (listings) => Right(listings));
  }

  @override
  Future<Either<String, ListingDetailModel>> getListingMeById({
    required String id,
  }) async {
    final result = await remoteDataSource.getListingMeById(id: id);

    return result.fold((error) => Left(error), (listings) => Right(listings));
  }

  @override
  Future<Either<String, ListingResponse>> filterListingMe({
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
    final result = await remoteDataSource.filterListingMe(
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
  Future<Either<String, ListingResponse>> filterListingMeByTypeHouse({
    required int page,
    required int limit,
    required String listingType,
    List<String>? propertyTypes,
    int? minPrice,
    int? maxPrice,
    required String sort,
  }) async {
    final result = await remoteDataSource.filterListingMeByTypeHouse(
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
