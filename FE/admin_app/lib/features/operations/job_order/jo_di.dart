import 'package:admin_app/features/operations/job_order/data/datasources/job_order_api_service.dart';
import 'package:admin_app/features/operations/job_order/data/repositories/job_order_repo_impl.dart';
import 'package:admin_app/features/operations/job_order/domain/repositories/job_order_repo.dart';
import 'package:admin_app/features/operations/job_order/domain/usecases/create_job_order.dart';
import 'package:admin_app/features/operations/job_order/domain/usecases/get_all_job_orders.dart';
import 'package:admin_app/features/operations/job_order/domain/usecases/get_job_order_by_id.dart';

import '../../../shared/global_variable.dart';
import 'presentations/bloc/job_order_bloc.dart';

Future<void> jobOrderDi() async {
  getIt.registerSingleton<JobOrderApiService>(JobOrderApiService(getIt()));

  getIt.registerSingleton<JobOrderRepository>(
      JobOrderRepositoryImpl(apiService: getIt(), networkInfo: getIt()));

  //UseCases
  getIt.registerSingleton<CreateJobOrder>(CreateJobOrder(getIt()));
  getIt.registerSingleton<GetAllJobOrders>(GetAllJobOrders(getIt()));
  getIt.registerSingleton<GetJobOrderById>(GetJobOrderById(getIt()));

  // Blocs
  getIt.registerFactory<JobOrderBloc>(
    () => JobOrderBloc(
      createJobOrder: getIt(),
      getAllJobOrders: getIt(),
      getJobOrderById: getIt(),
    ),
  );
}
