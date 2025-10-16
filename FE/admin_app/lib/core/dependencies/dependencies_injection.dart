import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../features/master_data/business_partner/bp_di.dart';
import '../../features/master_data/employee_position/empl_position_di.dart';
import '../../features/master_data/vehicle/vehicle_di.dart';
import '../../features/operations/job_order/jo_di.dart';
import '../constants/uri_constants.dart';
import '../network/network_info.dart';
import '../../features/auth/dependencies/auth_dependencies.dart';
import '../../features/auth/dependencies/auth_interceptor.dart';
import '../../features/master_data/personnel/personnel_di.dart';
import '../../services/interceptors.dart';
import '../../shared/global_variable.dart';
import '../../shared/token_provider.dart';

Future<void> init() async {
  // Token provider
  final tokenProvider = SharedPrefsTokenProvider();
  getIt.registerSingleton<AuthTokenProvider>(tokenProvider);
  // Core
  final dio = Dio();
  dio.options.baseUrl = (kDebugMode) ? devBaseUrl : prodBaseUrl;
  dio.interceptors.add(Logging());
  dio.interceptors.add(AuthInterceptor(tokenProvider));
  // Dio

  getIt.registerSingleton<Dio>(dio);
  getIt.registerLazySingleton(() => Connectivity());
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));

  await authDepInit(getIt());
  await personnelDI();
  await vehicleDI();
  await bpDI();
  await jobOrderDi();
  await emplPositionDI();
}
