part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class LoggingIn extends AuthEvent {
  final String username;
  final String password;

  const LoggingIn({required this.username, required this.password});

  @override
  List<Object?> get props => [username, password];
}

class AuthLogout extends AuthEvent {
  const AuthLogout();

  @override
  List<Object?> get props => [];
}
