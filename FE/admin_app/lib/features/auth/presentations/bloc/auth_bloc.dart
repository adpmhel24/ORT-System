import 'package:admin_app/core/usecases/usecase.dart';
import 'package:admin_app/features/auth/data/models/auth_response_model.dart';
import 'package:admin_app/features/auth/domain/usecases/login_user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/map_failure_to_message.dart';
import '../../../../shared/token_provider.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  LoginUseCase loginUseCase;
  final AuthTokenProvider tokenProvider;
  AuthBloc({required this.loginUseCase, required this.tokenProvider})
      : super(AuthInitState()) {
    on<LoggingIn>(_onLoggingIn);
    on<AuthLogout>(_onLogout);
  }

  void _onLoggingIn(LoggingIn event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    final successOrFail = await loginUseCase(PostParams(
        body: {"email": event.username, "password": event.password}));

    emit(
      successOrFail.fold(
        (failure) => AuthErrorState(mapFailureToMessage(failure)),
        (authResponse) {
          tokenProvider.setToken(authResponse.accessToken);
          return Authenticated(authResponse);
        },
      ),
    );
  }

  void _onLogout(AuthLogout event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    await tokenProvider.clearToken();

    emit(
      UnAuthenticated(),
    );
  }
}
