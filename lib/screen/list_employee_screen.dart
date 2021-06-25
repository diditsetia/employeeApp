import 'package:cached_network_image/cached_network_image.dart';
import 'package:employeeapp/application/employee/employee_bloc.dart';
import 'package:employeeapp/infrastructure/prefs.dart';
import 'package:employeeapp/screen/create_employee_screen.dart';
import 'package:employeeapp/screen/detail_employee_screen.dart';
import 'package:employeeapp/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListEmployeeScreen extends StatefulWidget {
  @override
  _ListEmployeeScreenState createState() => _ListEmployeeScreenState();
}

class _ListEmployeeScreenState extends State<ListEmployeeScreen> {
  final _employeeBloc = EmployeeBloc();
  bool loading = false;
  List data = [];
  @override
  void initState() {
    _employeeBloc.add(GetEmployee());
    super.initState();
  }

  @override
  void dispose() {
    _employeeBloc.close();

    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        height: 60,
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener(
            cubit: _employeeBloc,
            listener: (context, state) {
              if (state is EmployeeLoading) {
                setState(() {
                  loading = true;
                });
              }

              if (state is EmployeeSuccess) {
                List dataEmpl = state.data;

                setState(() {
                  data = dataEmpl;
                  loading = false;
                });
              }
            },
          ),
        ],
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      final dataUsers = data[index];

                      return Container(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DetailEmployeeScreen(
                                              id: dataUsers.id,
                                            )));
                              },
                              child: Container(
                                color: Colors.white,
                                width: MediaQuery.of(context).size.width,
                                height: 80,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: Color(0xFF3F51B5),
                                              ),
                                              child: Image.network(
                                                '${dataUsers.avatar}',
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${dataUsers.firstName} ${dataUsers.lastName}',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Text(
                                                  '${dataUsers.email}',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    height: 1.5,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }))),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF3F51B5),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateEmployeeScreen(),
              ));
        },
        tooltip: 'Create Employee',
        child: Icon(Icons.add),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const CustomAppBar({
    Key key,
    @required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF3F51B5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        Container(
          color: Colors.transparent,
          width: MediaQuery.of(context).size.width,
          height: 60,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'List Employee',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          String tkn = '';
                          await setToken(tkn);
                          Navigator.popUntil(context, (route) => route.isFirst);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
          ),
        )
      ]),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
