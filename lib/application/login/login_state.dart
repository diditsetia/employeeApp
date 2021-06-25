part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoading extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginSuccess extends LoginState {
  // final Application application;
  final String token;

  LoginSuccess(this.token);

  @override
  List<Object> get props => [token];
}

class CheckLoginSuccess extends LoginState {
  // final Application application;
  final String token;

  CheckLoginSuccess(this.token);

  @override
  List<Object> get props => [token];
}

class LoginError extends LoginState {
  final String reason;

  LoginError(this.reason);
  @override
  List<Object> get props => [reason];
}
