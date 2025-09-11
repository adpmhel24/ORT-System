import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../repositories/vehicle_repo.dart';

class PostVehicleUC implements UseCase<String, PostParams> {
  final VehicleRepository repository;

  PostVehicleUC(this.repository);

  @override
  Future<Either<Failure, String>> call(PostParams params) {
    return repository.create(params.body);
  }
}
