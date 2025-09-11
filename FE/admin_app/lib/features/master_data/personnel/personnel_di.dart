import '../../../shared/global_variable.dart';
import 'data/datasources/personnel_api_service.dart';
import 'data/repo_impl/personnel_repository_impl.dart';
import 'domain/repositories/personnel_repo.dart';
import 'domain/usecases/create_personnel.dart';
import 'domain/usecases/get_all_personnel.dart';
import 'presentations/bloc/personnel_bloc.dart';

Future<void> personnelDI() async {
  getIt.registerSingleton<PersonnelApiService>(PersonnelApiService(getIt()));

  getIt.registerSingleton<PersonnelRepository>(
      PersonnelRepositoryImpl(apiService: getIt(), networkInfo: getIt()));

  //UseCases
  getIt.registerSingleton<CreatePersonnelUC>(CreatePersonnelUC(getIt()));
  getIt.registerSingleton<GetAllPersonnelUC>(GetAllPersonnelUC(getIt()));

  // Blocs
  getIt.registerFactory<PersonnelBloc>(
    () => PersonnelBloc(
      createPersonnel: getIt(),
      getAllPersonnel: getIt(),
    ),
  );
}
