import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/network/network_info.dart';
import '../../data/models/job_order_model.dart';
import '../../domain/repositories/job_order_repo.dart';
import '../datasources/job_order_api_service.dart';

class JobOrderRepositoryImpl implements JobOrderRepository {
  final JobOrderApiService apiService;
  final NetworkInfo networkInfo;

  JobOrderRepositoryImpl({required this.apiService, required this.networkInfo});
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
  Future<Either<Failure, JobOrderModel>> getById(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await apiService.getById(id);
        final JobOrderModel partners = response.data['data'].map(
          (e) => JobOrderModelMapper.fromMap(e),
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

  @override
  Future<Either<Failure, List<JobOrderModel>>> getAll(
      Map<String, dynamic>? params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await apiService.getAll(params);
        final List<JobOrderModel> partners = List<JobOrderModel>.from(
          response.data['data'].map(
            (e) => JobOrderModelMapper.fromMap(e),
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
