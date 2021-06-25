import 'package:employeeapp/screen/root_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'infrastructure/implementations/employee_repository_impl.dart';
import 'infrastructure/implementations/login_repository_impl.dart';
import 'infrastructure/repositories/employee_repository.dart';
import 'infrastructure/repositories/login_repository.dart';

void main() {
  setupServiceLocator();
  runApp(RootScreen());
}

void setupServiceLocator() {
  GetIt.I.registerFactory<LoginRepository>(() => LoginRepositoryImpl());
  GetIt.I.registerFactory<EmployeeRepository>(() => EmployeeRepositoryImpl());
}
