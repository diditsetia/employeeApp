import 'package:employeeapp/application/login/login_bloc.dart';
import 'package:employeeapp/screen/list_employee_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FocusNode _focusEmail = new FocusNode();
  FocusNode _focusPassword = new FocusNode();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool activeTextFildEmail = false;
  bool activeTextFildPassword = false;
  bool loading = false;
  bool errorVisibility = false;
  String texterror = '';

  final _loginBloc = LoginBloc();

  @override
  void initState() {
    super.initState();
    _focusEmail.addListener(_onFocusChange);
    _focusPassword.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _loginBloc.close();

    super.dispose();
  }

  void _onFocusChange() {
    if (_focusEmail.hasFocus == true) {
      setState(() {
        activeTextFildEmail = true;
      });
    } else {
      setState(() {
        activeTextFildEmail = false;
      });
    }

    if (_focusPassword.hasFocus == true) {
      setState(() {
        activeTextFildPassword = true;
      });
    } else {
      setState(() {
        activeTextFildPassword = false;
      });
    }
  }

  _submitLogin() {
    _loginBloc.add(SignIn(email.text, password.text));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: BlocListener(
          cubit: _loginBloc,
          listener: (context, state) {
            if (state is LoginLoading) {
              setState(() {
                loading = true;
              });
            }
            if (state is LoginError) {
              setState(() {
                loading = false;
              });
            }
            if (state is LoginSuccess) {
              setState(() {
                loading = false;
              });
              String token = state.token;
              if (token != 'success') {
                setState(() {
                  errorVisibility = true;
                  texterror = token;
                });
              } else {
                setState(() {
                  errorVisibility = false;
                  texterror = '';
                });
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ListEmployeeScreen()));
              }
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'LOGIN EMPLOYEE',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 50),
                    Container(
                      height: 80,
                      child: Column(
                        children: [
                          TextField(
                            controller: email,
                            focusNode: _focusEmail,
                            cursorColor: Colors.black,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                color: activeTextFildEmail == true
                                    ? Color(0xFF3F51B5)
                                    : Colors.grey,
                              ),
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(
                                    top: 15), // add padding to adjust icon
                                child: Icon(
                                  Icons.email,
                                  color: activeTextFildEmail == true
                                      ? Color(0xFF3F51B5)
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 50, right: 20),
                            color: activeTextFildEmail == true
                                ? Color(0xFF3F51B5)
                                : Colors.grey,
                            height: 2,
                            width: MediaQuery.of(context).size.width,
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 80,
                      child: Column(
                        children: [
                          TextField(
                            controller: password,
                            focusNode: _focusPassword,
                            cursorColor: Colors.black,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                color: activeTextFildPassword == true
                                    ? Color(0xFF3F51B5)
                                    : Colors.grey,
                              ),
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(
                                    top: 15), // add padding to adjust icon
                                child: Icon(
                                  Icons.lock,
                                  color: activeTextFildPassword == true
                                      ? Color(0xFF3F51B5)
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 50, right: 20),
                            color: activeTextFildPassword == true
                                ? Color(0xFF3F51B5)
                                : Colors.grey,
                            height: 2,
                            width: MediaQuery.of(context).size.width,
                          )
                        ],
                      ),
                    ),
                    Visibility(
                      visible: errorVisibility,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              left: 45,
                              right: 20,
                            ),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '*${texterror}',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 40, bottom: 20, left: 15, right: 15),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color(0xFF3F51B5),
                      ),
                      child: FlatButton(
                        onPressed: _submitLogin,
                        child: loading == false
                            ? Text('Login',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ))
                            : SizedBox(
                                child: CircularProgressIndicator(),
                                height: 20.0,
                                width: 20.0,
                              ),
                      ),
                    )
                  ],
                )),
          ),
        ));
  }
}
