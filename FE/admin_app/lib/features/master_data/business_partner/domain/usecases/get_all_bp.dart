import 'package:admin_app/core/usecases/usecase.dart';
import 'package:admin_app/features/master_data/business_partner/data/models/bp_model.dart';
import 'package:admin_app/features/master_data/business_partner/domain/repositories/bp_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';

class GetAllBpUC extends UseCase<List<BusinessPartnerModel>, QueryParams?> {
  final BusinessPartnerRepository repository;

  GetAllBpUC(this.repository);

  @override
  Future<Either<Failure, List<BusinessPartnerModel>>> call(
      QueryParams? queryParams) {
    return repository.getAll(queryParams?.data);
  }
}
