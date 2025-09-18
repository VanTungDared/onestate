import 'package:dartz/dartz.dart';

import '../../domain/repositories/listing_repository.dart';
import '../datasources/remote/listing_remote_data_source.dart';
import '../models/listing_detail_model.dart';
import '../models/listing_reponse_model.dart';

class ListingRepositoryImpl implements ListingRepository {
  final ListingRemoteDataSource remoteDataSource;

  ListingRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<String, ListingResponse>> getListing(
    int page,
    int limit,
    String listingType, {
    String sort = "default",
  }) async {
    final result = await remoteDataSource.getListing(
      page: page,
      limit: limit,
      listingType: listingType,
      sort: sort,
    );

    return result.fold((error) => Left(error), (listings) => Right(listings));
  }

  @override
  Future<Either<String, ListingDetailModel>> getListingById({
    required String id,
  }) async {
    final result = await remoteDataSource.getListingById(id: id);

    return result.fold((error) => Left(error), (listings) => Right(listings));
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
    final result = await remoteDataSource.filterListing(
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
  Future<Either<String, ListingResponse>> filterListingByTypeHouse({
    required int page,
    required int limit,
    required String listingType,
    List<String>? propertyTypes,
    int? minPrice,
    int? maxPrice,
    required String sort,
  }) async {
    final result = await remoteDataSource.filterListingByTypeHouse(
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

  @override
  Future<Either<String, void>> likeListing({required String listingId}) async {
    final result = await remoteDataSource.likeListing(id: listingId);
    return result.fold((error) => Left(error), (_) => const Right(null));
  }
}
