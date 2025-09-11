import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../repositories/personnel_repo.dart';

class CreatePersonnelUC implements UseCase<String, PostParams> {
  final PersonnelRepository repository;

  CreatePersonnelUC(this.repository);

  @override
  Future<Either<Failure, String>> call(PostParams params) {
    return repository.create(params.body);
  }
}
