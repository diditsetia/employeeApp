part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class SignIn extends LoginEvent {
  final String email;
  final String password;

  SignIn(this.email, this.password);
  @override
  List<Object> get props => [email, password];
}

class CheckLogin extends LoginEvent {
  @override
  List<Object> get props => [];
}
