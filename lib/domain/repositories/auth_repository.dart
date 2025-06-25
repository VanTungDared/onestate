import 'package:dartz/dartz.dart';


abstract class AuthRepository {
  Future<Either> login(String phoneNumber, String password);
}
