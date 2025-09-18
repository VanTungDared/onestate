import 'package:app_real_estate/domain/repositories/listing_repository.dart';
import 'package:dartz/dartz.dart';

class LikeListingUseCase {
  final ListingRepository repository;

  LikeListingUseCase(this.repository);

  Future<Either<String, void>> call({required String listingId}) async {
    return await repository.likeListing(listingId: listingId);
  }
}
