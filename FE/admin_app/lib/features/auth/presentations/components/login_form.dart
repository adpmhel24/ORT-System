import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../shared/custom_text_form_box.dart';
import '../bloc/auth_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoadingState) {
          context.loaderOverlay.show();
        } else if (state is Authenticated) {
          context.loaderOverlay.hide();
        } else if (state is AuthErrorState) {
          context.loaderOverlay.hide();
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Account Login",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            CustomTextFormBox(
              controller: _emailController,
              label: "Email",
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (_) =>
                  _emailController.text.isEmpty ? "Required field." : null,
            ),
            const SizedBox(height: 16),
            CustomTextFormBox(
              label: "Password",
              controller: _passwordController,
              obscureText: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (_) =>
                  _passwordController.text.isEmpty ? "Required field." : null,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FluentLoginButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<AuthBloc>().add(
                          LoggingIn(
                            username: _emailController.text.trim(),
                            password: _passwordController.text,
                          ),
                        );
                  }
                },
              ),
            ),
            // const SizedBox(height: 16),
            // Button(
            //   onPressed: () {},
            //   child: const Text("Forgot Username / Password?"),
            // ),
          ],
        ),
      ),
    );
  }
}

const blueColor = Color(0xFF3B6FE2);

class FluentLoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  const FluentLoginButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.isDisabled) return Colors.grey;
          if (states.isHovered) return blueColor.withValues(alpha: 0.85);
          return blueColor;
        }),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
      onPressed: onPressed,
      child: const Text('SIGN IN'),
    );
  }
}
