import 'dart:convert';

import 'package:employeeapp/infrastructure/repositories/employee_repository.dart';
import 'package:employeeapp/model/detailemployee.dart';
import 'package:employeeapp/model/employee.dart';
import 'package:http/http.dart' as http;

class EmployeeRepositoryImpl extends EmployeeRepository {
  @override
  Future getEmployee() async {
    final String apiUrl = "https://reqres.in/api/users?per_page=20";
    final result = await http.get(apiUrl);

    if (result.statusCode == 200) {
      final data = json.decode(result.body);
      final resultdata = Employee.fromJson(data);
      final dataEmployee = resultdata.data;
      return dataEmployee;
    } else {
      List data = [];
      return data;
    }
  }

  @override
  Future detailEmployee(String id) async {
    final String apiUrl = "https://reqres.in/api/users/${id}";
    final result = await http.get(apiUrl);
    if (result.statusCode == 200) {
      final data = json.decode(result.body);
      final resultdata = DetailEmployee.fromJson(data);
      final dataDetailEmployee = resultdata.data;

      return dataDetailEmployee;
    } else {
      return null;
    }
  }

  @override
  Future createEmployee(file, String fristname, String lastname, String work,
      String telephone, String email, String site) async {
    final resp = await http.post(
      Uri.parse('https://reqres.in/api/users'),
      headers: {"Content-type": "application/json"},
      body: jsonEncode(<String, dynamic>{
        'file': file,
        'fristname': fristname,
        'lastname': lastname,
        'work': work,
        'telephone': telephone,
        'email': email,
        'site': site,
      }),
    );

    if (resp.statusCode == 201) {
      final data = json.decode(resp.body);
      return 'success';
    } else {
      return null;
    }
  }
}
