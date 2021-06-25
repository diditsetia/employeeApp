import 'dart:io';

import 'package:employeeapp/application/employee/employee_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class CreateEmployeeScreen extends StatefulWidget {
  @override
  _CreateEmployeeScreenState createState() => _CreateEmployeeScreenState();
}

class _CreateEmployeeScreenState extends State<CreateEmployeeScreen> {
  File _pickedImage;
  PickedFile imageFile;
  FocusNode _focusFname = new FocusNode();
  FocusNode _focusLname = new FocusNode();
  FocusNode _focusWork = new FocusNode();
  FocusNode _focusTelephone = new FocusNode();
  FocusNode _focusEmail = new FocusNode();
  FocusNode _focusSite = new FocusNode();

  TextEditingController fristName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController work = TextEditingController();
  TextEditingController telephone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController site = TextEditingController();

  bool activeTextFildFname = false;
  bool activeTextFildLname = false;
  bool activeTextFildWork = false;
  bool activeTextFildTelephone = false;
  bool activeTextFildEmail = false;
  bool activeTextFildSite = false;

  bool loading = false;
  bool isVideo = false;

  final _employeeBloc = EmployeeBloc();

  @override
  void initState() {
    super.initState();
    _focusFname.addListener(_onFocusChange);
    _focusLname.addListener(_onFocusChange);
    _focusWork.addListener(_onFocusChange);
    _focusTelephone.addListener(_onFocusChange);
    _focusEmail.addListener(_onFocusChange);
    _focusSite.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onFocusChange() {
    if (_focusFname.hasFocus == true) {
      setState(() {
        activeTextFildFname = true;
      });
    } else {
      setState(() {
        activeTextFildFname = false;
      });
    }

    if (_focusLname.hasFocus == true) {
      setState(() {
        activeTextFildLname = true;
      });
    } else {
      setState(() {
        activeTextFildLname = false;
      });
    }

    if (_focusWork.hasFocus == true) {
      setState(() {
        activeTextFildWork = true;
      });
    } else {
      setState(() {
        activeTextFildWork = false;
      });
    }

    if (_focusTelephone.hasFocus == true) {
      setState(() {
        activeTextFildTelephone = true;
      });
    } else {
      setState(() {
        activeTextFildTelephone = false;
      });
    }

    if (_focusEmail.hasFocus == true) {
      setState(() {
        activeTextFildEmail = true;
      });
    } else {
      setState(() {
        activeTextFildEmail = false;
      });
    }

    if (_focusSite.hasFocus == true) {
      setState(() {
        activeTextFildSite = true;
      });
    } else {
      setState(() {
        activeTextFildSite = false;
      });
    }
  }

  _createEmployee() {
    _employeeBloc.add(CreateEmployee(
      _pickedImage == null ? '' : _pickedImage.path.toString(),
      fristName.text,
      lastName.text,
      work.text,
      telephone.text,
      email.text,
      site.text,
    ));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarCreate(
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

              if (state is CreateEmployeeSuccess) {
                setState(() {
                  loading = false;
                });
                if (state.data == 'success') {
                  _successModalBottomSheet(context);
                } else {
                  _errorModalBottomSheet(context);
                }
              }
            },
          ),
        ],
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      _settingModalBottomSheet(context);
                    },
                    child: _pickedImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.file(
                              _pickedImage,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              color: Color(0xFF3F51B5),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(100.0),
                                topRight: Radius.circular(100.0),
                                bottomLeft: Radius.circular(100.0),
                                bottomRight: Radius.circular(100.0),
                              ),
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                  ),
                                ]),
                          ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: 80,
                    child: Column(
                      children: [
                        TextField(
                          controller: fristName,
                          focusNode: _focusFname,
                          cursorColor: Colors.black,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Frist Name',
                            labelStyle: TextStyle(
                              color: activeTextFildFname == true
                                  ? Color(0xFF3F51B5)
                                  : Colors.grey,
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(
                                  top: 15), // add padding to adjust icon
                              child: Icon(
                                Icons.account_circle_outlined,
                                color: activeTextFildFname == true
                                    ? Color(0xFF3F51B5)
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 50, right: 20),
                          color: activeTextFildFname == true
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
                          controller: lastName,
                          focusNode: _focusLname,
                          cursorColor: Colors.black,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Last Name',
                            labelStyle: TextStyle(
                              color: activeTextFildLname == true
                                  ? Color(0xFF3F51B5)
                                  : Colors.grey,
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(
                                  top: 15), // add padding to adjust icon
                              child: Icon(
                                Icons.account_circle_outlined,
                                color: activeTextFildLname == true
                                    ? Color(0xFF3F51B5)
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 50, right: 20),
                          color: activeTextFildLname == true
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
                          controller: work,
                          focusNode: _focusWork,
                          cursorColor: Colors.black,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Work',
                            labelStyle: TextStyle(
                              color: activeTextFildWork == true
                                  ? Color(0xFF3F51B5)
                                  : Colors.grey,
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(
                                  top: 15), // add padding to adjust icon
                              child: Icon(
                                Icons.work,
                                color: activeTextFildWork == true
                                    ? Color(0xFF3F51B5)
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 50, right: 20),
                          color: activeTextFildWork == true
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
                          controller: telephone,
                          focusNode: _focusTelephone,
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.black,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Telephone',
                            labelStyle: TextStyle(
                              color: activeTextFildTelephone == true
                                  ? Color(0xFF3F51B5)
                                  : Colors.grey,
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(
                                  top: 15), // add padding to adjust icon
                              child: Icon(
                                Icons.phone,
                                color: activeTextFildTelephone == true
                                    ? Color(0xFF3F51B5)
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 50, right: 20),
                          color: activeTextFildTelephone == true
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
                          controller: site,
                          focusNode: _focusSite,
                          cursorColor: Colors.black,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Site and Web',
                            labelStyle: TextStyle(
                              color: activeTextFildSite == true
                                  ? Color(0xFF3F51B5)
                                  : Colors.grey,
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(
                                  top: 15), // add padding to adjust icon
                              child: Icon(
                                Icons.web,
                                color: activeTextFildSite == true
                                    ? Color(0xFF3F51B5)
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 50, right: 20),
                          color: activeTextFildSite == true
                              ? Color(0xFF3F51B5)
                              : Colors.grey,
                          height: 2,
                          width: MediaQuery.of(context).size.width,
                        )
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
                      onPressed: _createEmployee,
                      child: loading == false
                          ? Text('Submit',
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
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future _imgFromGallery() async {
    PickedFile pickedImage = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50);
    if (pickedImage == null) {
      Navigator.pop(context);
    } else {
      setState(() => _pickedImage = File(pickedImage.path));
      Navigator.pop(context);
    }
  }

  Future _imgFromCamera() async {
    PickedFile pickedImage = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 50);

    if (pickedImage == null) {
      Navigator.pop(context);
    } else {
      setState(() {
        setState(() => _pickedImage = File(pickedImage.path));
      });
      Navigator.pop(context);
    }
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    title: new Text('Gallery'), onTap: () => _imgFromGallery()),
                new ListTile(
                  title: new Text('Camera'),
                  onTap: () => _imgFromCamera(),
                ),
              ],
            ),
          );
        });
  }

  void _successModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    title: new Text('Success'),
                    onTap: () {
                      Navigator.of(context).pop();
                    }),
              ],
            ),
          );
        });
  }

  void _errorModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    title: new Text('Error'),
                    onTap: () {
                      Navigator.of(context).pop();
                    }),
              ],
            ),
          );
        });
  }
}

class CustomAppBarCreate extends StatelessWidget
    implements PreferredSizeWidget {
  final double height;

  const CustomAppBarCreate({
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
                        Icons.close,
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
