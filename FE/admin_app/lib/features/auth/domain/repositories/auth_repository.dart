import 'package:admin_app/features/auth/data/models/auth_response_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

abstract class AuthUserRepository {
  Future<Either<Failure, AuthResponseModel>> login(Map<String, dynamic> data);

  Future<Either<Failure, String>> logout(Map<String, dynamic> body);
}
