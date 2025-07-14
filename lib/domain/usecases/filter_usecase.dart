import 'package:dartz/dartz.dart';

import '../../data/models/listing_reponse_model.dart';
import '../repositories/listing_repository.dart';

class FilterUseCase {
  final ListingRepository repository;

  FilterUseCase(this.repository);

  Future<Either<String, ListingResponse>> call({
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
  }) {
    return repository.filterListing(
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
  }
}
