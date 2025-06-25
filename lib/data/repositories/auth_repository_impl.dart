import 'package:dartz/dartz.dart';

import '../../domain/repositories/auth_repository.dart';
import '../datasources/dblocal/shared_preferences.dart';
import '../datasources/remote/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either> login(String phoneNumber, String password) async {
    final result = await remoteDataSource.login(phoneNumber, password);
    result.fold(
      (error) {
        return Left(error);
      },
      (response) async {
        SharedPreferenceApp.handleSetString(
          'access_token',
          response['data']['accessToken'],
        );
        return Right(response);
      },
    );
    return result;
  }
}
