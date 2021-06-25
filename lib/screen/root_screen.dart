import 'package:employeeapp/application/login/login_bloc.dart';
import 'package:employeeapp/screen/list_employee_screen.dart';
import 'package:employeeapp/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RootScreen extends StatefulWidget {
  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  final _loginBloc = LoginBloc();

  @override
  void initState() {
    _loginBloc.add(CheckLogin());
    super.initState();
  }

  @override
  void dispose() {
    _loginBloc.close();

    super.dispose();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Employee',
      home: BlocBuilder(
        cubit: _loginBloc,
        builder: (context, state) {
          if (state is LoginSuccess) {
            if (state.token.isEmpty) {
              return LoginScreen();
            } else {
              return ListEmployeeScreen();
            }
          }
          if (state is LoginError) return LoginScreen();
          return Container();
        },
      ),
    );
  }
}
