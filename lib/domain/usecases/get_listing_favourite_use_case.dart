import 'package:app_real_estate/domain/repositories/listing_favourite_repository.dart';
import 'package:dartz/dartz.dart';

import '../../data/models/listing_reponse_model.dart';

class GetListingFavouriteUseCase {
  ListingFavouriteRepository repository;

  GetListingFavouriteUseCase(this.repository);

  Future<Either<String, ListingResponse>> call(
    int page,
    int limit,
    String listingType, {
    String sort = "default",
  }) {
    return repository.getListingFavourite(page, limit, listingType, sort: sort);
  }
}
