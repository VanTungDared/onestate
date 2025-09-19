import 'package:dartz/dartz.dart';

import '../../data/models/listing_reponse_model.dart';
import '../repositories/listing_repository.dart';

class FilterApartmentUseCase {
  final ListingRepository repository;

  FilterApartmentUseCase(this.repository);

  Future<Either<String, ListingResponse>> call({
    required int page,
    required int limit,
    required String listingType,
    List<String>? propertyTypes,
    int? minPrice,
    int? maxPrice,
    String? title,
    required String sort,
  }) {
    return repository.filterListingByTypeHouse(
      page: page,
      limit: limit,
      listingType: listingType,
      propertyTypes: propertyTypes,
      minPrice: minPrice,
      maxPrice: maxPrice,
      title: title,
      sort: sort,
    );
  }
}
