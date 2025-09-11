part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthInitState extends AuthState {}

class AuthLoadingState extends AuthState {}

class Authenticated extends AuthState {
  final AuthResponseModel user;

  const Authenticated(this.user);
  @override
  List<Object?> get props => [user];
}

class UnAuthenticated extends AuthState {}

class AuthErrorState extends AuthState {
  final String message;
  const AuthErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
