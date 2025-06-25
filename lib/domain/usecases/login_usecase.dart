import 'package:dartz/dartz.dart';

import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either> call(String phoneNumber, String password) {
    return repository.login(phoneNumber, password);
  }
}