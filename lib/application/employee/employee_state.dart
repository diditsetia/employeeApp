part of 'employee_bloc.dart';

abstract class EmployeeState extends Equatable {
  const EmployeeState();
}

class EmployeeInitial extends EmployeeState {
  @override
  List<Object> get props => [];
}

class EmployeeLoading extends EmployeeState {
  @override
  List<Object> get props => [];
}

class EmployeeSuccess extends EmployeeState {
  final List data;

  EmployeeSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class DetailEmployeeSuccess extends EmployeeState {
  final data;

  DetailEmployeeSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class CreateEmployeeSuccess extends EmployeeState {
  final data;

  CreateEmployeeSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class EmployeeError extends EmployeeState {
  final String reason;

  EmployeeError(this.reason);
  @override
  List<Object> get props => [reason];
}
