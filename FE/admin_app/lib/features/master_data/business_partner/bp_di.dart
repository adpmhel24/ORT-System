import 'package:admin_app/features/master_data/business_partner/data/datasources/bp_api_service.dart';
import 'package:admin_app/features/master_data/business_partner/data/repo_impl/bp_repo_impl.dart';
import 'package:admin_app/features/master_data/business_partner/domain/repositories/bp_repo.dart';
import 'package:admin_app/features/master_data/business_partner/domain/usecases/get_all_bp.dart';
import 'package:admin_app/features/master_data/business_partner/presentations/bloc/bp_bloc.dart';

import '../../../shared/global_variable.dart';
import 'domain/usecases/post_bp.dart';

Future<void> bpDI() async {
  getIt.registerSingleton<BPApiService>(BPApiService(getIt()));

  getIt.registerSingleton<BusinessPartnerRepository>(
      BusinessPartnerRepoImpl(apiService: getIt(), networkInfo: getIt()));

  //UseCases
  getIt.registerSingleton<PostBpUC>(PostBpUC(getIt()));
  getIt.registerSingleton<GetAllBpUC>(GetAllBpUC(getIt()));

  // Blocs
  getIt.registerFactory<BpBloc>(
    () => BpBloc(
      postBp: getIt(),
      getAllBp: getIt(),
    ),
  );
}
