import 'package:admin_app/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../../data/models/personnel_model.dart';
import '../repositories/personnel_repo.dart';

class GetAllPersonnelUC extends UseCase<List<PersonnelModel>, QueryParams?> {
  final PersonnelRepository repository;

  GetAllPersonnelUC(this.repository);

  @override
  Future<Either<Failure, List<PersonnelModel>>> call(QueryParams? queryParams) {
    return repository.getAllPersonnel(queryParams?.data);
  }
}
