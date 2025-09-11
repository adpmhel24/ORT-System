import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../../data/models/personnel_model.dart';

abstract class PersonnelRepository {
  Future<Either<Failure, String>> create(Map<String, dynamic> data);
  // Future<Either<Failure, PersonnelModel>> getById(int id);
  Future<Either<Failure, List<PersonnelModel>>> getAllPersonnel(
      Map<String, dynamic>? params);
  // Future<Either<Failure, void>> deletePersonnel(int id);
}
