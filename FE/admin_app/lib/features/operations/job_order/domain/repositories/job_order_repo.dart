import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../../data/models/job_order_model.dart';

abstract class JobOrderRepository {
  Future<Either<Failure, String>> create(Map<String, dynamic> data);
  Future<Either<Failure, JobOrderModel>> getById(int id);
  Future<Either<Failure, List<JobOrderModel>>> getAll(
      Map<String, dynamic>? params);
  // Future<Either<Failure, void>> deletePersonnel(int id);
}
