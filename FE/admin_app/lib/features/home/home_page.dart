import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth/presentations/bloc/auth_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: const PageHeader(
        title: Text("Home Page"),
      ),
      content: SizedBox.expand(
        child: FilledButton(
          child: const Text("Logout"),
          onPressed: () {
            context.read<AuthBloc>().add(const AuthLogout());
          },
        ),
      ),
    );
  }
}
