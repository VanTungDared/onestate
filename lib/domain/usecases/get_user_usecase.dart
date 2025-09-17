import 'package:dartz/dartz.dart';

import '../repositories/user_repository.dart';

class GetUserUseCase {
  final UserRepository repository;

  GetUserUseCase(this.repository);

  Future<Either> call() {
    return repository.getUser();
  }

  Future<Either> logout() {
    return repository.logout();
  }
}
