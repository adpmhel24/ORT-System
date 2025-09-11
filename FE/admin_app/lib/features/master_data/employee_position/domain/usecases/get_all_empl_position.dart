import 'package:admin_app/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../../data/models/employee_position_model.dart';
import '../repositories/employee_position_entity.dart';

class GetAllEmplPositions
    extends UseCase<List<EmployeePositionModel>, QueryParams?> {
  final EmployeePositionRepository repository;

  GetAllEmplPositions(this.repository);

  @override
  Future<Either<Failure, List<EmployeePositionModel>>> call(
      QueryParams? queryParams) {
    return repository.getAll(queryParams?.data);
  }
}
