import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:employeeapp/infrastructure/repositories/login_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  LoginRepository get _repository => GetIt.I<LoginRepository>();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is SignIn) {
      try {
        yield LoginLoading();
        final result = await _repository.login(
          event.email,
          event.password,
        );

        yield (LoginSuccess(result));
      } catch (e) {
        yield LoginError(e.toString());
      }
    }

    if (event is CheckLogin) {
      try {
        yield LoginLoading();
        final result = await _repository.checklogin();

        yield (LoginSuccess(result));
      } catch (e) {
        yield LoginError(e);
      }
    }
  }
}
