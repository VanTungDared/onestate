import 'package:dartz/dartz.dart';

import '../../domain/repositories/listing_repository.dart';
import '../datasources/remote/listing_remote_data_source.dart';
import '../models/ListingModel.dart';
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
}
