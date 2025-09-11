import 'dart:async';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentations/bloc/auth_bloc.dart';
import '../../features/auth/presentations/screens/login_screen.dart';
import '../../features/home/home_page.dart';
import '../../features/menu_page/menu_page.dart';
import '../../features/unknown/presentation/unknown_page.dart';

import 'master_data_router.dart';
import 'operations_router.dart';
import 'route_names.dart';

class AppRouter {
  static BuildContext? context;

  AppRouter(BuildContext cntx) {
    AppRouter.context ??= cntx;
  }
  // static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static BuildContext get _context => context!;
  static final GoRouter _router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: RouteNames.login,
        builder: (context, state) => const LoginPage(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return MenuPage(
            shellContext: _shellNavigatorKey.currentContext,
            state: state,
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: RouteNames.home,
            name: "home",
            builder: (context, state) => const HomePage(),
          ),
          ...masterDataRoutes,
          ...operationRoutes
        ],
      ),
    ],
    errorBuilder: (context, state) => const UnknownPage(),
    refreshListenable:
        GoRouterRefreshBloc<AuthBloc, AuthState>(_context.read<AuthBloc>()),
    redirect: (context, state) {
      final authBloc = context.read<AuthBloc>();
      final isLoggedIn = authBloc.state is Authenticated;
      final onloginPage = state.matchedLocation == RouteNames.login;

      if (!isLoggedIn && !onloginPage) {
        return RouteNames.login;
      }
      if (isLoggedIn && onloginPage) {
        return RouteNames.home;
      }
      return null;
    },
  );
  GoRouter get router => _router;
}

class GoRouterRefreshBloc<BLOC extends BlocBase<STATE>, STATE>
    extends ChangeNotifier {
  GoRouterRefreshBloc(BLOC bloc) {
    _blocStream = bloc.stream.listen(
      (STATE _) => notifyListeners(),
    );
  }

  late final StreamSubscription<STATE> _blocStream;

  @override
  void dispose() {
    _blocStream.cancel();
    super.dispose();
  }
}
