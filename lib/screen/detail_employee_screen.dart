import 'package:employeeapp/application/employee/employee_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailEmployeeScreen extends StatefulWidget {
  final int id;
  const DetailEmployeeScreen({Key key, this.id}) : super(key: key);
  @override
  _DetailEmployeeScreenState createState() => _DetailEmployeeScreenState();
}

class _DetailEmployeeScreenState extends State<DetailEmployeeScreen> {
  final _employeeBloc = EmployeeBloc();
  bool loading = false;
  String fName = '';
  String lName = '';
  String email;
  String urlImg = '';
  @override
  void initState() {
    String idEmpl = widget.id.toString();
    _employeeBloc.add(GetDetailEmployee(idEmpl));

    super.initState();
  }

  @override
  void dispose() {
    _employeeBloc.close();

    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarDetail(
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

              if (state is DetailEmployeeSuccess) {
                final dataDetail = state.data;

                setState(() {
                  loading = false;
                  fName = dataDetail.firstName;
                  lName = dataDetail.lastName;
                  email = dataDetail.email;
                  urlImg = dataDetail.avatar;
                });
              }
            },
          ),
        ],
        child: loading == true
            ? Center(
                child: Container(
                  child: SizedBox(
                    child: CircularProgressIndicator(),
                    height: 40.0,
                    width: 40.0,
                  ),
                ),
              )
            : Column(
                children: [
                  Container(
                    color: Color(0xFF3F51B5),
                    height: MediaQuery.of(context).size.height / 2.8,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 40,
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // SizedBox.fromSize(
                            //   size: Size.fromRadius(80),
                            //   child: FittedBox(
                            //     child: Icon(
                            //       Icons.account_circle,
                            //       color: Colors.white,
                            //     ),
                            //   ),
                            // ),
                            Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                color: Color(0xFF3F51B5),
                                // borderRadius: BorderRadius.only(
                                //   topLeft:
                                //       Radius.circular(25.0),
                                //   topRight:
                                //       Radius.circular(25.0),
                                //   bottomLeft:
                                //       Radius.circular(25.0),
                                //   bottomRight:
                                //       Radius.circular(25.0),
                                // ),
                              ),
                              child: Image.network(
                                '${urlImg}',
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              '${fName} ${lName}',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Container(
                          height: 80,
                          width: MediaQuery.of(context).size.width,
                          child: Card(
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.phone,
                                            color: Colors.grey,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '999999',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              Text('Telephone',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                  )),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Icon(
                                        Icons.message,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Container(
                          height: 80,
                          width: MediaQuery.of(context).size.width,
                          child: Card(
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.email,
                                            color: Colors.grey,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${email}',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              Text('E-mail',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                  )),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Container(
                          height: 80,
                          width: MediaQuery.of(context).size.width,
                          child: Card(
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.share,
                                            color: Colors.grey,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${fName}',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              Text('Compartihal',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                  )),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
}

class CustomAppBarDetail extends StatelessWidget
    implements PreferredSizeWidget {
  final double height;

  const CustomAppBarDetail({
    Key key,
    @required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF3F51B5),
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
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
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
