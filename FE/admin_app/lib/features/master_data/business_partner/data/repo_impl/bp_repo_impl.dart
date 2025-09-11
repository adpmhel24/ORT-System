import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/network/network_info.dart';
import '../../domain/repositories/bp_repo.dart';
import '../datasources/bp_api_service.dart';
import '../models/bp_model.dart';

class BusinessPartnerRepoImpl extends BusinessPartnerRepository {
  final BPApiService apiService;
  final NetworkInfo networkInfo;

  BusinessPartnerRepoImpl(
      {required this.apiService, required this.networkInfo});

  @override
  Future<Either<Failure, String>> create(Map<String, dynamic> data) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await apiService.create(data);
        return Right(response.data['message'] as String);
      } on DioException catch (e) {
        return Left(CustomDioReturnError.error(e));
      } catch (e) {
        return Left(FrontEndFailure(e.toString()));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, BusinessPartnerModel>> getById(int id) async {
    // Implementation for fetching a business partner by ID
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<BusinessPartnerModel>>> getAll(
      Map<String, dynamic>? params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await apiService.getAll(params);
        final List<BusinessPartnerModel> partners =
            List<BusinessPartnerModel>.from(
          response.data['data'].map(
            (e) => BusinessPartnerModelMapper.fromMap(e),
          ),
        );
        return Right(partners);
      } on DioException catch (e) {
        return Left(CustomDioReturnError.error(e));
      } catch (e) {
        return Left(FrontEndFailure(e.toString()));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }
}
