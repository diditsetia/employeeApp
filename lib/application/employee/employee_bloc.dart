import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:employeeapp/infrastructure/repositories/employee_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc() : super(EmployeeInitial());

  EmployeeRepository get _repository => GetIt.I<EmployeeRepository>();

  @override
  Stream<EmployeeState> mapEventToState(
    EmployeeEvent event,
  ) async* {
    if (event is GetEmployee) {
      try {
        yield EmployeeLoading();
        final result = await _repository.getEmployee();

        yield (EmployeeSuccess(result));
      } catch (e) {
        yield EmployeeError(e.toString());
      }
    }

    if (event is GetDetailEmployee) {
      try {
        yield EmployeeLoading();
        final result = await _repository.detailEmployee(event.id);

        yield (DetailEmployeeSuccess(result));
      } catch (e) {
        yield EmployeeError(e.toString());
      }
    }

    if (event is CreateEmployee) {
      try {
        yield EmployeeLoading();
        final result = await _repository.createEmployee(
          event.file,
          event.fristname,
          event.lastname,
          event.work,
          event.telephone,
          event.email,
          event.site,
        );

        yield (CreateEmployeeSuccess(result));
      } catch (e) {
        yield EmployeeError(e.toString());
      }
    }
  }
}
