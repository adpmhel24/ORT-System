import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/network/network_info.dart';
import '../../domain/repositories/personnel_repo.dart';
import '../datasources/personnel_api_service.dart';
import '../models/personnel_model.dart';

class PersonnelRepositoryImpl implements PersonnelRepository {
  final PersonnelApiService apiService;
  final NetworkInfo networkInfo;

  PersonnelRepositoryImpl(
      {required this.apiService, required this.networkInfo});

  @override
  Future<Either<Failure, String>> create(Map<String, dynamic> body) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await apiService.create(body);
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
  Future<Either<Failure, List<PersonnelModel>>> getAllPersonnel(
      Map<String, dynamic>? queryParams) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await apiService.getAll(queryParams);
        return Right(
          List<PersonnelModel>.from(
            result.data['data'].map(
              (e) => PersonnelModelMapper.fromMap(e),
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
