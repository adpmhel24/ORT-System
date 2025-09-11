import 'package:dartz/dartz.dart';
import '../../data/models/job_order_model.dart';
import '../../../../../core/errors/failures.dart';
import '../repositories/job_order_repo.dart';

class GetJobOrderById {
  final JobOrderRepository repository;
  GetJobOrderById(this.repository);

  Future<Either<Failure, JobOrderModel>> call(int id) {
    return repository.getById(id);
  }
}
