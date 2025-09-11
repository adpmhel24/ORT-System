import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../repositories/bp_repo.dart';

class PostBpUC implements UseCase<String, PostParams> {
  final BusinessPartnerRepository repository;

  PostBpUC(this.repository);

  @override
  Future<Either<Failure, String>> call(PostParams params) {
    return repository.create(params.body);
  }
}
