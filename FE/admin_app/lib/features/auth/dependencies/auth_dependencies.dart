import 'package:dio/dio.dart';

import '../../../shared/global_variable.dart';
import '../data/datasources/auth_user_api_service.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/usecases/login_user.dart';
import '../presentations/bloc/auth_bloc.dart';

Future<void> authDepInit(Dio dio) async {
  getIt.registerLazySingleton<AuthUserApiService>(
    () => AuthUserApiService(getIt()),
  );

  // Repositories
  getIt.registerLazySingleton<AuthUserRepository>(
    () => AuthUserRepositoryImpl(
      apiService: getIt(),
      networkInfo: getIt(),
    ),
  );

  // Use Cases
  getIt.registerLazySingleton(() => LoginUseCase(getIt()));

  // BLoCs
  getIt.registerFactory(
    () => AuthBloc(
      loginUseCase: getIt(),
      tokenProvider: getIt(),
    ),
  );
}
