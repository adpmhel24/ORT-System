import 'package:admin_app/features/master_data/employee_position/domain/repositories/employee_position_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/usecases/usecase.dart';

class PostEmplPosition implements UseCase<String, PostParams> {
  final EmployeePositionRepository repository;

  PostEmplPosition(this.repository);

  @override
  Future<Either<Failure, String>> call(PostParams params) {
    return repository.create(params.body);
  }
}
