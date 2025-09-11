import 'package:admin_app/features/auth/data/models/auth_user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_user_api_service.dart';
import '../models/auth_response_model.dart';

class AuthUserRepositoryImpl implements AuthUserRepository {
  final AuthUserApiService apiService;
  final NetworkInfo networkInfo;

  AuthUserRepositoryImpl({
    required this.apiService,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, AuthResponseModel>> login(
      Map<String, dynamic> data) async {
    // FormData formData = FormData.fromMap(data);

    if (await networkInfo.isConnected) {
      try {
        final result = await apiService.login(data);
        final authUser = AuthUserModelMapper.fromMap(result.data['data']);
        result.data['data'] = authUser;
        return Right(AuthResponseModelMapper.fromMap(result.data));
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
  Future<Either<Failure, String>> logout(Map<String, dynamic> body) {
    throw UnimplementedError();
  }
}
