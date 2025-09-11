import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:system_theme/system_theme.dart';
import 'package:window_manager/window_manager.dart';

import 'core/dependencies/dependencies_injection.dart';
import 'core/routes/app_router.dart';
import 'features/auth/presentations/bloc/auth_bloc.dart';
import 'shared/global_variable.dart';

/// Checks if the current environment is a desktop environment.
bool get isDesktop {
  if (kIsWeb) return false;
  return [
    TargetPlatform.windows,
    TargetPlatform.linux,
    TargetPlatform.macOS,
  ].contains(defaultTargetPlatform);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();

  if (!kIsWeb &&
      [
        TargetPlatform.windows,
        TargetPlatform.android,
      ].contains(defaultTargetPlatform)) {
    SystemTheme.accentColor.load();
  }
  if (isDesktop) {
    await WindowManager.instance.ensureInitialized();
    windowManager.waitUntilReadyToShow().then((_) async {
      await windowManager.setTitleBarStyle(
        TitleBarStyle.normal,
      );

      // await windowManager.setSize(const Size(755, 545));
      await windowManager.setSize(await windowManager.getSize());
      await windowManager.setMinimumSize(const Size(850, 600));
      await windowManager.center();
      await windowManager.show();
      await windowManager.setPreventClose(true);
      await windowManager.setSkipTaskbar(false);
    });
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: GlobalLoaderOverlay(
        overlayWidgetBuilder: (_) {
          return const Center(
            child: SpinKitWave(
              color: Colors.white,
            ),
          );
        },
        child: RepositoryProvider(
          lazy: false,
          create: (context) => AppRouter(context),
          child: Builder(builder: (context) {
            return FluentApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: context.read<AppRouter>().router,
              darkTheme: FluentThemeData(
                fontFamily: 'Open Sans',
                visualDensity: VisualDensity.standard,
                focusTheme: FocusThemeData(
                  glowFactor: is10footScreen(context) ? 2.0 : 0.0,
                ),
              ),
              theme: FluentThemeData(
                fontFamily: 'Open Sans',
                visualDensity: VisualDensity.standard,
                scaffoldBackgroundColor:
                    const Color.fromARGB(255, 195, 184, 184),
                focusTheme: FocusThemeData(
                  glowFactor: is10footScreen(context) ? 2.0 : 0.0,
                ),
              ),
              builder: (context, child) => ResponsiveBreakpoints.builder(
                child: child!,
                breakpoints: [
                  const Breakpoint(start: 0, end: 450, name: MOBILE),
                  const Breakpoint(start: 451, end: 800, name: TABLET),
                  const Breakpoint(start: 900, end: 1920, name: DESKTOP),
                  const Breakpoint(
                      start: 1921, end: double.infinity, name: '4K'),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
