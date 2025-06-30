import 'package:dartz/dartz.dart';

import '../../data/models/listing_detail_model.dart';
import '../../data/models/listing_reponse_model.dart';

abstract class ListingRepository {
  Future<Either<String, ListingResponse>> getListing(
    int page,
    int limit,
    String listingType, {
    String sort,
  });

  Future<Either<String, ListingDetailModel>> getListingById({required String id});
}
