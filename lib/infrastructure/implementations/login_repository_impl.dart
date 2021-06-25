import 'dart:convert';

import 'package:employeeapp/infrastructure/prefs.dart';
import 'package:employeeapp/infrastructure/repositories/login_repository.dart';
import 'package:employeeapp/model/error.dart';
import 'package:employeeapp/model/success.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class LoginRepositoryImpl extends LoginRepository {
  final Dio dio = Dio();
  @override
  Future login(String email, String password) async {
    final resp = await http.post(
      Uri.parse('https://reqres.in/api/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (resp.statusCode == 400) {
      final data = json.decode(resp.body);
      final resultdata = ErrorMess.fromJson(data);
      String mssError = resultdata.error;
      return mssError;
    }

    if (resp.statusCode == 200) {
      final data = json.decode(resp.body);
      final resultdata = SuccessMss.fromJson(data);
      String tkn = resultdata.token;
      await setToken(tkn);
      String mss = 'success';
      return mss;
    }
  }

  @override
  Future checklogin() async {
    final token = await getToken();
    return token;
  }
}
