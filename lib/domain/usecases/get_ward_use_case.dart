import 'package:dartz/dartz.dart';

import '../../data/models/provinces_model.dart';
import '../repositories/provinces_repository.dart';

class GetWardUseCase {
  final ProvincesRepository repository;

  GetWardUseCase(this.repository);

  Future<Either<String,  List<ProvincesModel>>> call({
    required String codeDistrict,
    required String codeWard,
  }) {
    return repository.getWards(codeDistrict, codeWard);
  }
}
