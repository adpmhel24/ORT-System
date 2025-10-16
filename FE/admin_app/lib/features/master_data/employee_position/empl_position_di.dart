import '../../../shared/global_variable.dart';
import 'data/datasources/empl_position_api_service.dart';
import 'data/repository_impl/empl_position_repo_impl.dart';
import 'domain/repositories/employee_position_entity.dart';
import 'domain/usecases/get_all_empl_position.dart';
import 'domain/usecases/post_empl_position.dart';
import 'presentations/bloc/empl_position_bloc.dart';

Future<void> emplPositionDI() async {
  getIt.registerSingleton<EmplPositionApiService>(
      EmplPositionApiService(getIt()));

  getIt.registerSingleton<EmployeePositionRepository>(
      EmployeePositionRepositoryImpl(
          apiService: getIt(), networkInfo: getIt()));

  //UseCases
  getIt.registerSingleton<PostEmplPosition>(PostEmplPosition(getIt()));
  getIt.registerSingleton<GetAllEmplPositions>(GetAllEmplPositions(getIt()));

  // Blocs
  getIt.registerFactory<EmplPositionBloc>(
    () => EmplPositionBloc(
      postEmplPosition: getIt(),
      getAllEmplPosition: getIt(),
    ),
  );
}
