import 'package:admin_app/features/master_data/personnel/presentations/personnel_page.dart';
import 'package:admin_app/features/operations/job_order/presentations/job_order_page.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';

import '../master_data/business_partner/presentations/bp_page.dart';
import '../master_data/vehicle/presentation/vehicle_page.dart';

class MainMenuItems {
  final GoRouterState stateRouter;
  final GoRouter router;

  MainMenuItems({
    required this.stateRouter,
    required this.router,
  });

  List<NavigationPaneItem> mainMenuItems() {
    return [
      PaneItem(
        key: const Key('/home'),
        icon: const Icon(FluentIcons.home),
        title: const Text('Home'),
        body: const SizedBox.shrink(),
        onTap: () {
          router.goNamed('home');
        },
      ),
      PaneItemExpander(
        key: const Key("/operations"),
        icon: const Icon(FluentIcons.service_activity),
        title: const Text("Operations"),
        onTap: null,
        body: const SizedBox.shrink(),
        items: [
          PaneItem(
            key: const Key(JobOrderPage.routePath),
            icon: const Icon(FluentIcons.reservation_orders),
            title: const Text('Job Order'),
            body: const SizedBox.shrink(),
            onTap: () {
              if (stateRouter.matchedLocation != JobOrderPage.routePath) {
                router.goNamed(JobOrderPage.routeName);
              }
            },
          ),
          PaneItem(
            key: const Key('/job_assignment'),
            icon: const Icon(FluentIcons.assign_policy),
            title: const Text('Job Assignment'),
            body: const SizedBox.shrink(),
            onTap: () {},
          ),
        ],
      ),
      PaneItemExpander(
        key: const Key("/master_data"),
        icon: const Icon(FluentIcons.database),
        title: const Text("Master Data"),
        onTap: null,
        body: const SizedBox.shrink(),
        items: [
          PaneItem(
            key: const Key(BusinessPartnerPage.routePath),
            icon: const Icon(FluentIcons.accounts),
            title: const Text('Business Partner'),
            body: const SizedBox.shrink(),
            onTap: () {
              if (stateRouter.matchedLocation !=
                  BusinessPartnerPage.routePath) {
                router.goNamed(BusinessPartnerPage.routeName);
              }
            },
          ),
          PaneItem(
            key: const Key(VehiclePage.routePath),
            icon: const Icon(FluentIcons.delivery_truck),
            title: const Text('Vehicle'),
            body: const SizedBox.shrink(),
            onTap: () {
              if (stateRouter.matchedLocation != VehiclePage.routePath) {
                router.goNamed(VehiclePage.routeName);
              }
            },
          ),
          PaneItem(
            key: const Key(PersonnelPage.routePath),
            icon: const Icon(FluentIcons.user_clapper),
            title: const Text('Personnel'),
            body: const SizedBox.shrink(),
            onTap: () {
              if (stateRouter.matchedLocation != PersonnelPage.routePath) {
                router.goNamed(PersonnelPage.routeName);
              }
            },
          ),
        ],
      ),
    ];
  }
}
