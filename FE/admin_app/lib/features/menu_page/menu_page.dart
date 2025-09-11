import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:window_manager/window_manager.dart';

import '../../core/routes/app_router.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/responsive.dart';
import 'main_menu_items.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({
    super.key,
    required this.child,
    required this.shellContext,
    required this.state,
  });

  final Widget child;
  final BuildContext? shellContext;
  final GoRouterState state;
  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> with WindowListener {
  final viewKey = GlobalKey(debugLabel: 'Navigation View Key');
  int currentIndex = 0;

  late MainMenuItems menuItems;
  @override
  void initState() {
    menuItems = MainMenuItems(
      stateRouter: widget.state,
      router: context.read<AppRouter>().router,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      key: viewKey,
      pane: NavigationPane(
        selected: currentIndex,
        displayMode: Responsive.isDesktop(context)
            ? PaneDisplayMode.top
            : PaneDisplayMode.compact,
        size: const NavigationPaneSize(
          openMinWidth: 300,
          openMaxWidth: 300,
        ),
        onChanged: (index) => setState(() => currentIndex = index),
        indicator: const StickyNavigationIndicator(),
        items: menuItems.mainMenuItems(),
      ),
      paneBodyBuilder: (item, child) {
        return widget.child;
      },
    );
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  void onWindowClose() async {
    bool isPreventClose = await windowManager.isPreventClose();
    if (isPreventClose && mounted) {
      showDialog(
        context: context,
        builder: (_) {
          return ContentDialog(
            title: const Text('Confirm close'),
            content: const Text('Are you sure you want to close this window?'),
            actions: [
              CustomFilledButton(
                child: const Text('Yes'),
                onPressed: () {
                  Navigator.pop(context);
                  windowManager.destroy();
                },
              ),
              CustomButton(
                child: const Text('No'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }
}
