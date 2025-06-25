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
    return await result.fold((error) async => Left(error), (response) async {
      final data = response.data;

      if (data != null && data['data'] != null) {
        await SharedPreferenceApp.handleSetString(
          'accessToken',
          data['data']['accessToken'],
        );
        return Right(response);
      } else {
        return const Left('Invalid response format');
      }
    });
  }
}
