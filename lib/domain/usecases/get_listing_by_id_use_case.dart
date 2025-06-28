import 'package:dartz/dartz.dart';

import '../../data/models/listing_detail_model.dart';
import '../repositories/listing_repository.dart';

class GetListingByIdUseCase {
  final ListingRepository repository;

  GetListingByIdUseCase(this.repository);

  Future<Either<String, ListingDetailModel>> call({required String id}) {
    return repository.getListingById(id: id);
  }
}
