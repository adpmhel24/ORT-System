import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../../data/models/employee_position_model.dart';

abstract class EmployeePositionRepository {
  Future<Either<Failure, String>> create(Map<String, dynamic> data);
  Future<Either<Failure, EmployeePositionModel>> getById(int id);
  Future<Either<Failure, List<EmployeePositionModel>>> getAll(
      Map<String, dynamic>? params);
  // Future<Either<Failure, void>> deletePersonnel(int id);
}
