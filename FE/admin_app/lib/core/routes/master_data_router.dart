import 'package:go_router/go_router.dart';

import '../../features/master_data/business_partner/presentations/bp_page.dart';
import '../../features/master_data/personnel/presentations/personnel_page.dart';
import '../../features/master_data/vehicle/presentation/vehicle_page.dart';

final masterDataRoutes = [
  GoRoute(
    name: PersonnelPage.routeName,
    path: PersonnelPage.routePath,
    builder: (context, state) => const PersonnelPage(),
  ),
  GoRoute(
    path: VehiclePage.routePath,
    name: VehiclePage.routeName,
    builder: (context, state) => const VehiclePage(),
  ),
  GoRoute(
    path: BusinessPartnerPage.routePath,
    name: BusinessPartnerPage.routeName,
    builder: (context, state) => const BusinessPartnerPage(),
  ),
];
