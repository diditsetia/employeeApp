import 'package:shared_preferences/shared_preferences.dart';

Future<void> setToken(String token) async {
  final _p = await SharedPreferences.getInstance();
  await _p.setString('token', token);
}

Future<String> getToken() async {
  final _p = await SharedPreferences.getInstance();
  return _p.getString('token') ?? '';
}