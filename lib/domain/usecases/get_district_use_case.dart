import 'package:app_real_estate/data/models/provinces_model.dart';
import 'package:dartz/dartz.dart';

import '../repositories/provinces_repository.dart';

class GetDistrictUseCase {
  final ProvincesRepository repository;

  GetDistrictUseCase(this.repository);

  Future<Either<String,  List<ProvincesModel>>> call({required String province}) {
    return repository.getDistricts(province);
  }
}
