import 'package:dartz/dartz.dart';
import '../../data/models/job_order_model.dart';
import '../../../../../core/errors/failures.dart';
import '../repositories/job_order_repo.dart';

class GetAllJobOrders {
  final JobOrderRepository repository;
  GetAllJobOrders(this.repository);

  Future<Either<Failure, List<JobOrderModel>>> call(
      [Map<String, dynamic>? params]) {
    return repository.getAll(params);
  }
}
