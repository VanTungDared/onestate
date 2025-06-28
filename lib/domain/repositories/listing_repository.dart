import 'package:dartz/dartz.dart';

import '../../data/models/ListingModel.dart';
import '../../data/models/listing_detail_model.dart';

abstract class ListingRepository {
  Future<Either<String, List<ListingModel>>> getListing(
    int page,
    int limit,
    String listingType, {
    String sort,
  });

  Future<Either<String, ListingDetailModel>> getListingById({required String id});
}
