import 'package:app_real_estate/domain/repositories/listing_me_repository.dart';
import 'package:dartz/dartz.dart';

import '../../data/models/listing_reponse_model.dart';

class GetListingMeUseCase {
  final ListingMeRepository repository;

  GetListingMeUseCase(this.repository);

  Future<Either<String, ListingResponse>> call(
    int page,
    int limit,
    String listingType, {
    String sort = "default",
  }) {
    return repository.getListingMe(page, limit, listingType, sort: sort);
  }
}
