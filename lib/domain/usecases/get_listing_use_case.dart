import 'package:dartz/dartz.dart';

import '../../data/models/ListingModel.dart';
import '../repositories/listing_repository.dart';

class GetListingUseCase {
  final ListingRepository repository;

  GetListingUseCase(this.repository);

  Future<Either<String, List<ListingModel>>> call(
      int page,
      int limit,
      String listingType, {
        String sort = "default",
      }) {
    return repository.getListing(
      page,
      limit,
      listingType,
      sort: sort,
    );
  }
}
