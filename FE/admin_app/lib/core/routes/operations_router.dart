import 'package:go_router/go_router.dart';

import '../../features/operations/job_order/presentations/job_order_page.dart';

final operationRoutes = [
  GoRoute(
    name: JobOrderPage.routeName,
    path: JobOrderPage.routePath,
    builder: (context, state) => const JobOrderPage(),
  ),
];
