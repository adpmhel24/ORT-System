import 'package:admin_app/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../../data/models/vehicle_model.dart';
import '../repositories/vehicle_repo.dart';

class GetAllVehicleUC extends UseCase<List<VehicleModel>, QueryParams?> {
  final VehicleRepository repository;

  GetAllVehicleUC(this.repository);

  @override
  Future<Either<Failure, List<VehicleModel>>> call(QueryParams? queryParams) {
    return repository.getAllVehicle(queryParams?.data);
  }
}
