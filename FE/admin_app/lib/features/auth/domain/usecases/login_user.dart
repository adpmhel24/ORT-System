import 'package:admin_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/auth_response_model.dart';

class LoginUseCase implements UseCase<void, PostParams> {
  final AuthUserRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, AuthResponseModel>> call(PostParams params) {
    return repository.login(params.body);
  }
}
