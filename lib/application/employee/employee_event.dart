part of 'employee_bloc.dart';

abstract class EmployeeEvent extends Equatable {
  const EmployeeEvent();
}

class GetEmployee extends EmployeeEvent {
  @override
  List<Object> get props => [];
}

class GetDetailEmployee extends EmployeeEvent {
  String id;
  GetDetailEmployee(this.id);
  @override
  List<Object> get props => [id];
}

class CreateEmployee extends EmployeeEvent {
  final file;
  String fristname;
  String lastname;
  String work;
  String telephone;
  String email;
  String site;

  CreateEmployee(
    this.file,
    this.fristname,
    this.lastname,
    this.work,
    this.telephone,
    this.email,
    this.site,
  );
  @override
  List<Object> get props =>
      [file, fristname, lastname, work, telephone, email, site];
}
