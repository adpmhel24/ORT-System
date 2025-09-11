import 'package:admin_app/features/master_data/vehicle/domain/usecases/get_all_vehicle.dart';
import 'package:admin_app/features/master_data/vehicle/domain/usecases/post_vehicle.dart';

import '../../../shared/global_variable.dart';
import 'data/datasources/vehicle_api_service.dart';
import 'data/repo_impl/vehicle_repo_impl.dart';
import 'domain/repositories/vehicle_repo.dart';
import 'presentation/bloc/vehicle_bloc.dart';

Future<void> vehicleDI() async {
  getIt.registerSingleton<VehicleApiService>(VehicleApiService(getIt()));

  getIt.registerSingleton<VehicleRepository>(
      VehicleRepositoryImpl(apiService: getIt(), networkInfo: getIt()));

  //UseCases
  getIt.registerSingleton<PostVehicleUC>(PostVehicleUC(getIt()));
  getIt.registerSingleton<GetAllVehicleUC>(GetAllVehicleUC(getIt()));

  // Blocs
  getIt.registerFactory<VehicleBloc>(
    () => VehicleBloc(
      postVehicle: getIt(),
      getAllVehicle: getIt(),
    ),
  );
}
