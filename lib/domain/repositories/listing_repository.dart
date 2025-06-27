import 'package:dartz/dartz.dart';

import '../../data/models/ListingModel.dart';

abstract class ListingRepository {
  Future<Either<String, List<ListingModel>>> getListing(
      int page,
      int limit,
      String listingType, {
        String sort,
      });
}
