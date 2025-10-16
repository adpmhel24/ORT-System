import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/network/network_info.dart';
import '../../domain/repositories/employee_position_entity.dart';
import '../datasources/empl_position_api_service.dart';
import '../models/employee_position_model.dart';

class EmployeePositionRepositoryImpl extends EmployeePositionRepository {
  final EmplPositionApiService apiService;
  final NetworkInfo networkInfo;

  EmployeePositionRepositoryImpl(
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
  Future<Either<Failure, EmployeePositionModel>> getById(int id) async {
    // Implementation for fetching a business partner by ID
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<EmployeePositionModel>>> getAll(
      Map<String, dynamic>? params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await apiService.getAll(params);
        final List<EmployeePositionModel> partners =
            List<EmployeePositionModel>.from(
          response.data['data'].map(
            (e) => EmployeePositionModelMapper.fromMap(e),
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
