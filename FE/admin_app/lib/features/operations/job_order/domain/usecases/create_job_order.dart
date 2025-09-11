import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failures.dart';
import '../repositories/job_order_repo.dart';

class CreateJobOrder {
  final JobOrderRepository repository;
  CreateJobOrder(this.repository);

  Future<Either<Failure, String>> call(Map<String, dynamic> data) {
    return repository.create(data);
  }
}
