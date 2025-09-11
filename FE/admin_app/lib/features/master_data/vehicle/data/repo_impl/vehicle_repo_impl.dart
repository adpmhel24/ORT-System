import 'package:admin_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/network/network_info.dart';
import '../../domain/repositories/vehicle_repo.dart';
import '../datasources/vehicle_api_service.dart';
import '../models/vehicle_model.dart';

class VehicleRepositoryImpl extends VehicleRepository {
  final VehicleApiService apiService;
  final NetworkInfo networkInfo;
  VehicleRepositoryImpl({
    required this.apiService,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, String>> create(Map<String, dynamic> data) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await apiService.create(data);
        return Right(result.data['message']);
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
  Future<Either<Failure, List<VehicleModel>>> getAllVehicle(
      Map<String, dynamic>? queryParams) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await apiService.getAll(queryParams);
        return Right(
          List<VehicleModel>.from(
            result.data['data'].map(
              (e) => VehicleModelMapper.fromMap(e),
            ),
          ),
        );
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
