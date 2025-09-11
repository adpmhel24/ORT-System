import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../../data/models/bp_model.dart';

abstract class BusinessPartnerRepository {
  Future<Either<Failure, String>> create(Map<String, dynamic> data);
  Future<Either<Failure, BusinessPartnerModel>> getById(int id);
  Future<Either<Failure, List<BusinessPartnerModel>>> getAll(
      Map<String, dynamic>? params);
  // Future<Either<Failure, void>> deletePersonnel(int id);
}
