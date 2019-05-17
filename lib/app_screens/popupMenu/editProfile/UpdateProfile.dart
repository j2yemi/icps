import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icps/Constants.dart';
import 'package:icps/app_screens/Register.dart';
import 'package:icps/app_screens/drawer/Login.dart';

import 'package:icps/app_screens/popupMenu/Dashboard.dart';
import 'package:icps/app_screens/popupMenu/EditProfile.dart';
import 'package:icps/app_screens/popupMenu/Settings.dart';

import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdatePic extends StatefulWidget {

  Data data; Data user; String password;

  UpdatePic({this.data, this.user, this.password});

  @override
  _UpdatePicState createState() => _UpdatePicState();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
  signedInSpeaker
}

class _UpdatePicState extends State<UpdatePic> {

  AuthStatus _authStatus = AuthStatus.notSignedIn;

  final formKey = new GlobalKey<FormState>();

  String progressString = '';

  final global = GlobalKey();

  String filePath;
  String fileName = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.data = widget.data ?? Data();

    _authStatus = ((widget.data.surname == '')) ? AuthStatus.notSignedIn : (widget.data.speaker && widget.data.surname != '') ? AuthStatus.signedInSpeaker : AuthStatus.signedIn;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: global,
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(152, 160, 87, 1),
        title: new Text("Edit Profile"),
        leading: Builder(
          builder: (context) => IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop (context);
            },
          ),
        ),
        actions: <Widget>[
//          IconButton(icon: Icon(
//              Icons.search
//          ),
//            onPressed: () {
//
//            },
//          ),
//          PopupMenuButton<String>(
//            onSelected: choiceAction,
//            itemBuilder: (BuildContext context) {
//              return Constants.choices.map((String choice){
//                return PopupMenuItem<String>(
//                  value: choice,
//                  child: new Text(choice),
//                );
//              }).toList();
//            },
//          ),
        ],
      ),
      body: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new Container(
              child: new Form(
                key: formKey,
                child: new Column(
                  children: <Widget>[
                    new Container(
                        margin: new EdgeInsets.all(10.0),
                        height: 53.0,
                        decoration: new BoxDecoration(
                            border: new Border(
                              top: new BorderSide(
                                  width: 1.0,
                                  color: Colors.grey,
                                  style: BorderStyle.solid
                              ),
                              bottom: new BorderSide(
                                  width: 1.0,
                                  color: Colors.grey,
                                  style: BorderStyle.solid
                              ),
                              left: new BorderSide(
                                  width: 1.0,
                                  color: Colors.grey,
                                  style: BorderStyle.solid
                              ),
                              right: new BorderSide(
                                  width: 1.0,
                                  color: Colors.grey,
                                  style: BorderStyle.solid
                              ),
                            ),
                            borderRadius: new BorderRadius.circular(5.0)
                        ),
                        child: new Row(
//                  crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new GestureDetector(
                                onTap: () async {
                                  filePath = await FilePicker.getFilePath(type: FileType.ANY);
                                  File pFile = new File(filePath);
                                  setState(() {
                                    fileName = basename(pFile.path);
                                  });
                                  print(fileName);
                                },
                                child: new Container(
                                    width: ScreenUtil.getInstance().setWidth(190),
                                    height: 48.0,
                                    decoration: new BoxDecoration(
                                        color: Color.fromRGBO(53, 182, 134, 1),
                                        borderRadius: new BorderRadius.circular(5.0)
                                    ),
                                    child: new Center(
                                      child: new Text('Choose file...',
                                        style: new TextStyle(
                                            color: Colors.white
                                        ),
                                      ),
                                    )
                                )
                            ),
                            new Container(
                              padding: new EdgeInsets.only(left: 12.0),
                              child: new Text(fileName),
                            ),
                          ],
                        )
                    ),
                    new Container(
                      margin: new EdgeInsets.all(31.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: new BoxDecoration(
                          color: Color.fromRGBO(53, 182, 134, 1),
                          borderRadius: new BorderRadius.circular(5.0)
                      ),
                      child: new FlatButton(
                          child: new Text('Upload Profile Picture',
                            style: new TextStyle(
                                color: Colors.white,
                                fontSize: 16.0
                            ),
                          ),
                          onPressed: () {
//                                    _showDialog(context);
//                                    uploadFileFromDio(context);
                            updateProfilePic(context);
                          }
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool validateAndSave () {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  updateProfilePic(BuildContext context) async {
    if (validateAndSave()) {

      _showDialogTwo(context);

      var dio = new Dio();

      File photoFile = new File(filePath);
      dio.options.connectTimeout = 50000; //5s
      dio.options.receiveTimeout = 50000;
      //dio.options.headers = <Header Json>;
      FormData formData = new FormData();
      formData.add("userinfoid", widget.data.id);

      if (photoFile != null &&
          photoFile.path != null &&
          photoFile.path.isNotEmpty) {
        // Create a FormData
        String fileName = basename(photoFile.path);
        print("File Name : $fileName");
        print("File Size : ${photoFile.lengthSync()}");
        formData.add("file", new UploadFileInfo(photoFile, fileName));
      }
      var response = await dio.put("http://icps19.com:6060/icps/icps/19/upu/",
          data: formData,
          onReceiveProgress: showDownloadProgress,
          options: Options(
              method: 'POST',
              responseType: ResponseType.json // or ResponseType.JSON
          ));
      print("Response status: ${response.statusCode}");

      Navigator.pop(context, (response.statusCode == 200 || response.statusCode == 401));

      if (response.statusCode == 200){
        Fluttertoast.showToast(
            msg: "Update successful, please wait",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );

        Future.delayed (Duration(seconds: 3),
                () async {
              Fluttertoast.showToast(
                  msg: "Redirecting",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIos: 6,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  fontSize: 16.0
              );

              Future.delayed (Duration(seconds: 2),
                      () async {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => EditProfile(data: widget.data, password: widget.password,))
                    );
                    print('6 seconds');
                  }
              );
            }
        );
      }
      else{
        Fluttertoast.showToast(
            msg: "Oops, something went wrong, try again.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }

      print("Response data: ${response.data}");

    }
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      setState(() {
        progressString = (received / total * 100).toStringAsFixed(0) + "%";
      });
      print(progressString);
    }
  }

  void _showDialogTwo (BuildContext context)
  {
    var alertDialog = AlertDialog(
//      title: new Text('Downloading'),
      contentPadding: EdgeInsets.all(0.0),
      backgroundColor: Colors.transparent,
      content: Container(
        height: 120.0,
        width: 200.0,
        child: Card(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(
                height: 10.0,
              ),
              Text ('Uploading Profile Picture',
                style: new TextStyle (
                    color: Colors.white
                ),
              )
            ],
          ),
        ),
      ),
//      ),
//      actions: <Widget>[
//
//      ],
    );

    showDialog(
        context: global.currentContext,
        builder: (BuildContext context) {
//       if (progressString != '100%') {
          return alertDialog;

//       }
        },
        barrierDismissible: false
    );


  }
}

class UpdateName extends StatefulWidget {
  Data user; String password; Data data;

  TextEditingController surnameFilter;
  TextEditingController firstnameFilter;

  UpdateName({this.user, this.password, this.data, this.surnameFilter, this.firstnameFilter}) {
    this.surnameFilter = new TextEditingController(text: user.surname);
    this.firstnameFilter = new TextEditingController(text: user.firstname);
  }

  @override
  _UpdateNameState createState() => _UpdateNameState();
}

class _UpdateNameState extends State<UpdateName> {

  final formKey = new GlobalKey<FormState>();

//  String progressString = '';

  final global = GlobalKey();

  var _title = ['Alh.', 'Bar.', 'Dr.', 'Engr.', 'Fr.', 'Haj.', 'Mal.', 'Miss', 'Mr.', 'Mrs.', 'Pharm.', 'Prof.', 'Sis.'];


  String _surname = "";

  String _firstname = "";

  var _currentTitleSelected;

  UpdateName() {
    widget.surnameFilter.addListener(_surnameListen);
    widget.firstnameFilter.addListener(_firstnameListen);
  }

  void _surnameListen() {
    if (widget.surnameFilter.text.isEmpty) {
      _surname = "";
    } else {
      _surname = widget.surnameFilter.text;
    }
  }

  void _firstnameListen() {
    if (widget.firstnameFilter.text.isEmpty) {
      _firstname = "";
    } else {
      _firstname = widget.firstnameFilter.text;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.user = widget.user ?? Data();

    setState(() {
      _currentTitleSelected = widget.user.title;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: global,
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(152, 160, 87, 1),
        title: new Text("Edit Profile"),
        leading: Builder(
          builder: (context) => IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop (context);
            },
          ),
        ),
        actions: <Widget>[
//          IconButton(icon: Icon(
//              Icons.search
//          ),
//            onPressed: () {
//
//            },
//          ),
//          PopupMenuButton<String>(
//            onSelected: choiceAction,
//            itemBuilder: (BuildContext context) {
//              return Constants.choices.map((String choice){
//                return PopupMenuItem<String>(
//                  value: choice,
//                  child: new Text(choice),
//                );
//              }).toList();
//            },
//          ),
        ],
      ),
      body: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new Container(
              child: new Form(
                key: formKey,
                child: new Column(
                  children: <Widget>[
                    new Container(
                        child: new Column (
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget> [
//                              new Container(
//                                margin: new EdgeInsets.only(top: 15.0, left: 20.0),
//                                child: new Text('Title',
//                                  style: new TextStyle(
//                                      fontSize: 16.0
//                                  ),
//                                ),
//                              ),
                              new Container(
                                margin: new EdgeInsets.all(10.0),
                                width: MediaQuery.of(context).size.width,
                                child: new InputDecorator(
                                    decoration: InputDecoration(
                                        labelText: 'Title',
                                        prefixIcon: Padding(
                                            padding: EdgeInsets.all(0.0),
                                            child: Icon(
                                              Icons.title,
                                              color: Colors.grey,
                                            )
                                        )
                                    ),
//                                    alignedDropdown: true,
                                    child: DropdownButtonHideUnderline(
//                                        child: new Container(
//                                          decoration: ShapeDecoration(
//                                            shape: RoundedRectangleBorder(
//                                              side: BorderSide(
//                                                  width: 1.0,
//                                                  style: BorderStyle.solid
//                                              ),
//                                              borderRadius: BorderRadius.all(
//                                                  Radius.circular(5.0)
//                                              ),
//                                            ),
//                                          ),
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        isDense: true,
                                        hint: new Text('Title*'),
                                        items: _title.map((String dropDownStringItem) {
                                          return DropdownMenuItem<String> (
                                            value: dropDownStringItem,
                                            child: Text(dropDownStringItem),
                                          );
                                        }).toList(),
                                        onChanged: (String newValueSelected) {
                                          _onDropDownTitleSelected (newValueSelected);
                                        },
                                        value: _currentTitleSelected,
                                      ),
                                    )
                                ),
//                                  )
                              ),
                            ]
                        )
                    ),
                    new Container(
                      margin: new EdgeInsets.all(10.0),
                      child: new TextFormField(
                        controller: widget.surnameFilter,
                        decoration: new InputDecoration(
                            labelText: 'Surname*',
                            prefixIcon: Padding(
                                padding: EdgeInsets.all(0.0),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.grey,
                                )
                            )
//                          border: new OutlineInputBorder(
//                              borderSide: new BorderSide(
//                                  color: Color.fromRGBO(53, 182, 134, 1),
//                                  width: 1.0
//                              ),
//                              borderRadius: BorderRadius.circular(5.0)
//                          ),
                        ),
                        validator: (value) => value.isEmpty ? 'Surname can\'t be empty' : null,
                        onSaved: (value) => _surname = value,
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.all(10.0),
                      child: new TextFormField(
                        controller: widget.firstnameFilter,
                        decoration: new InputDecoration(
                            labelText: 'First Name*',
                            prefixIcon: Padding(
                                padding: EdgeInsets.all(0.0),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.grey,
                                )
                            )
//                          border: new OutlineInputBorder(
//                              borderSide: new BorderSide(
//                                  color: Color.fromRGBO(53, 182, 134, 1),
//                                  width: 1.0
//                              ),
//                              borderRadius: BorderRadius.circular(5.0)
//                          ),
                        ),
                        validator: (value) => value.isEmpty ? 'First Name can\'t be empty' : null,
                        onSaved: (value) => _firstname = value,
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.all(11.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: new BoxDecoration(
                          color: Color.fromRGBO(53, 182, 134, 1),
                          borderRadius: new BorderRadius.circular(5.0)
                      ),
                      child: new FlatButton(
                        child: new Text('Update Profile',
                          style: new TextStyle(
                              color: Colors.white,
                              fontSize: 16.0
                          ),
                        ),
                        onPressed: () {
                          validateAndSubmit(context);
                        },
                      ),
                    ),
                  ],
                )
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool validateAndSave () {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit(BuildContext context) async {

    String sendUrl ='http://icps19.com:6060/icps/i/icps/19/uru';

    if (validateAndSave()) {

      _showDialogTwo(context);

      Response response;
      Dio dio = new Dio();

      response = await dio.put(sendUrl, queryParameters: {
        "companysector": widget.user.companysector,
        "conference_id": widget.user.conferenceId,
        "country": widget.user.country,
        "email": widget.user.email,
        "facebook_id": widget.user.facebookId,
        "firstname": _firstname,
        "instagram_id": widget.user.instagramId,
        "loginstatus": widget.user.loginstatus,
        "moderator_yn": widget.user.moderatorYn,
        "organisation": widget.user.organisation,
        "participant_type": widget.user.participantType,
        "password": widget.password,
        "phone": widget.user.phone,
        "pic_id": widget.user.picId == null ? null : widget.user.picId,
        "short_profile": widget.user.shortProfile,
        "speaker_yn": widget.user.speaker,
        "surname": _surname,
        "title": _currentTitleSelected,
        "twitter_id": widget.user.twitterId,
        "userinfoid": widget.user.id,
        "username": widget.user.username,
        "website": widget.user.website,
        "work_position": widget.user.workPosition,
      },
          options: Options(
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              "accept": "application/json"
            },)
      );
      print(response.statusCode);

      Navigator.pop(context, (response.statusCode == 200 || response.statusCode == 401));

      if (response.statusCode == 401)
      {
        Fluttertoast.showToast(
            msg: "Oops, something went wrong, try again.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );
//            Toast.show("Oops, something went wrong, try again.", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      }
      else
      {
        Fluttertoast.showToast(
            msg: "Profile updated successfully, please wait",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );

        Future.delayed (Duration(seconds: 3),
                () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EditProfile(data: widget.data, password: widget.password,))
              );
            }
        );
      }
    }
  }

  void _onDropDownTitleSelected (String newValueSelected)
  {
    setState(() {
      this._currentTitleSelected = newValueSelected;
    });
  }

  void _showDialogTwo (BuildContext context)
  {
    var alertDialog = AlertDialog(
//      title: new Text('Downloading'),
      contentPadding: EdgeInsets.all(0.0),
      backgroundColor: Colors.transparent,
      content: Container(
        height: 120.0,
        width: 200.0,
        child: Card(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(
                height: 10.0,
              ),
              Text ('Updating',
                style: new TextStyle (
                    color: Colors.white
                ),
              )
            ],
          ),
        ),
      ),
//      ),
//      actions: <Widget>[
//
//      ],
    );

    showDialog(
        context: global.currentContext,
        builder: (BuildContext context) {
//       if (progressString != '100%') {
          return alertDialog;

//       }
        },
        barrierDismissible: false
    );


  }
}

class UpdateUsername extends StatefulWidget {

  Data user; String password; Data data;

  TextEditingController usernameFilter;

  UpdateUsername({this.user, this.password, this.data, this.usernameFilter}) {

    this.usernameFilter = new TextEditingController(text: user.username);

  }
  @override
  _UpdateUsernameState createState() => _UpdateUsernameState();
}

class _UpdateUsernameState extends State<UpdateUsername> {

  final formKey = new GlobalKey<FormState>();

//  String progressString = '';

  final global = GlobalKey();

  String _username = "";

  UpdateUsername() {
    widget.usernameFilter.addListener(_usernameListen);
  }

  void _usernameListen() {
    if (widget.usernameFilter.text.isEmpty) {
      _username = "";
    } else {
      _username = widget.usernameFilter.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: global,
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(152, 160, 87, 1),
        title: new Text("Edit Profile"),
        leading: Builder(
          builder: (context) => IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop (context);
            },
          ),
        ),
        actions: <Widget>[
//          IconButton(icon: Icon(
//              Icons.search
//          ),
//            onPressed: () {
//
//            },
//          ),
//          PopupMenuButton<String>(
//            onSelected: choiceAction,
//            itemBuilder: (BuildContext context) {
//              return Constants.choices.map((String choice){
//                return PopupMenuItem<String>(
//                  value: choice,
//                  child: new Text(choice),
//                );
//              }).toList();
//            },
//          ),
        ],
      ),
      body: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new Container(
              child: new Form(
                key: formKey,
                child: new Column(
                  children: <Widget>[
                    new Container(
                      margin: new EdgeInsets.all(10.0),
                      child: new TextFormField(
                        controller: widget.usernameFilter,
                        decoration: new InputDecoration(
                            labelText: 'Username',
                            prefixIcon: Padding(
                                padding: EdgeInsets.all(0.0),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.grey,
                                )
                            )
//                              border: new OutlineInputBorder(
//                                  borderSide: new BorderSide(
//                                      color: Color.fromRGBO(53, 182, 134, 1),
//                                      width: 1.0
//                                  ),
//                                  borderRadius: BorderRadius.circular(5.0)
//                              ),
                        ),
                        validator: (value) => value.isEmpty ? 'Username can\'t be empty' : null,
                        onSaved: (value) => _username = value,
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.all(11.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: new BoxDecoration(
                          color: Color.fromRGBO(53, 182, 134, 1),
                          borderRadius: new BorderRadius.circular(5.0)
                      ),
                      child: new FlatButton(
                        child: new Text('Update Profile',
                          style: new TextStyle(
                              color: Colors.white,
                              fontSize: 16.0
                          ),
                        ),
                        onPressed: () {
                          validateAndSubmit(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool validateAndSave () {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit(BuildContext context) async {

    String sendUrl ='http://icps19.com:6060/icps/i/icps/19/uru';

    if (validateAndSave()) {

      _showDialogTwo(context);

      Response response;
      Dio dio = new Dio();

      response = await dio.put(sendUrl, queryParameters: {
        "companysector": widget.user.companysector,
        "conference_id": widget.user.conferenceId,
        "country": widget.user.country,
        "email": widget.user.email,
        "facebook_id": widget.user.facebookId,
        "firstname": widget.user.firstname,
        "instagram_id": widget.user.instagramId,
        "loginstatus": widget.user.loginstatus,
        "moderator_yn": widget.user.moderatorYn,
        "organisation": widget.user.organisation,
        "participant_type": widget.user.participantType,
        "password": widget.password,
        "phone": widget.user.phone,
        "pic_id": widget.user.picId,
        "short_profile": widget.user.shortProfile,
        "speaker_yn": widget.user.speaker,
        "surname": widget.user.surname,
        "title": widget.user.title,
        "twitter_id": widget.user.twitterId,
        "userinfoid": widget.user.id,
        "username": _username,
        "website": widget.user.website,
        "work_position": widget.user.workPosition,
      },
          options: Options(
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              "accept": "application/json"
            },)
      );
      print(response.statusCode);

      Navigator.pop(context, (response.statusCode == 200 || response.statusCode == 401));

      if (response.statusCode == 401)
      {
        Fluttertoast.showToast(
            msg: "Oops, something went wrong, try again.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );
//            Toast.show("Oops, something went wrong, try again.", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      }
      else
      {
        Fluttertoast.showToast(
            msg: "Profile updated successfully, please wait",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );

        Future.delayed (Duration(seconds: 3),
                () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EditProfile(data: widget.data, password: widget.password,))
              );
            }
        );
      }
    }
  }

  void _showDialogTwo (BuildContext context)
  {
    var alertDialog = AlertDialog(
//      title: new Text('Downloading'),
      contentPadding: EdgeInsets.all(0.0),
      backgroundColor: Colors.transparent,
      content: Container(
        height: 120.0,
        width: 200.0,
        child: Card(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(
                height: 10.0,
              ),
              Text ('Updating',
                style: new TextStyle (
                    color: Colors.white
                ),
              )
            ],
          ),
        ),
      ),
//      ),
//      actions: <Widget>[
//
//      ],
    );

    showDialog(
        context: global.currentContext,
        builder: (BuildContext context) {
//       if (progressString != '100%') {
          return alertDialog;

//       }
        },
        barrierDismissible: false
    );


  }
}

class UpdatePhone extends StatefulWidget {

  Data user; String password; Data data;

  TextEditingController phoneFilter;

  UpdatePhone({this.user, this.password, this.data, this.phoneFilter}) {

    this.phoneFilter = new TextEditingController(text: user.phone);

  }
  @override
  _UpdatePhoneState createState() => _UpdatePhoneState();
}

class _UpdatePhoneState extends State<UpdatePhone> {

  final formKey = new GlobalKey<FormState>();

//  String progressString = '';

  final global = GlobalKey();

  String _phone = "";

  UpdatePhone() {
    widget.phoneFilter.addListener(_phoneListen);
  }

  void _phoneListen() {
    if (widget.phoneFilter.text.isEmpty) {
      _phone = "";
    } else {
      _phone = widget.phoneFilter.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: global,
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(152, 160, 87, 1),
        title: new Text("Edit Profile"),
        leading: Builder(
          builder: (context) => IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop (context);
            },
          ),
        ),
        actions: <Widget>[
//          IconButton(icon: Icon(
//              Icons.search
//          ),
//            onPressed: () {
//
//            },
//          ),
//          PopupMenuButton<String>(
//            onSelected: choiceAction,
//            itemBuilder: (BuildContext context) {
//              return Constants.choices.map((String choice){
//                return PopupMenuItem<String>(
//                  value: choice,
//                  child: new Text(choice),
//                );
//              }).toList();
//            },
//          ),
        ],
      ),
      body: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new Container(
              child: new Form(
                key: formKey,
                child: new Column(
                  children: <Widget>[
                    new Container(
                      margin: new EdgeInsets.all(10.0),
                      child: new TextFormField(
                        controller: widget.phoneFilter,
                        keyboardType: TextInputType.phone,
                        decoration: new InputDecoration(
                            labelText: 'Phone Number',
                            prefixIcon: Padding(
                                padding: EdgeInsets.all(0.0),
                                child: Icon(
                                  Icons.phone,
                                  color: Colors.grey,
                                )
                            )
//                              border: new OutlineInputBorder(
//                                  borderSide: new BorderSide(
//                                      color: Color.fromRGBO(53, 182, 134, 1),
//                                      width: 1.0
//                                  ),
//                                  borderRadius: BorderRadius.circular(5.0)
//                              ),
                        ),
                        validator: (value) => value.isEmpty ? 'Phone Number can\'t be empty' : null,
                        onSaved: (value) => _phone = value,
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.all(11.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: new BoxDecoration(
                          color: Color.fromRGBO(53, 182, 134, 1),
                          borderRadius: new BorderRadius.circular(5.0)
                      ),
                      child: new FlatButton(
                        child: new Text('Update Profile',
                          style: new TextStyle(
                              color: Colors.white,
                              fontSize: 16.0
                          ),
                        ),
                        onPressed: () {
                          validateAndSubmit(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool validateAndSave () {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit(BuildContext context) async {

    String sendUrl ='http://icps19.com:6060/icps/i/icps/19/uru';

    if (validateAndSave()) {

      _showDialogTwo(context);

      Response response;
      Dio dio = new Dio();

      response = await dio.put(sendUrl, queryParameters: {
        "companysector": widget.user.companysector,
        "conference_id": widget.user.conferenceId,
        "country": widget.user.country,
        "email": widget.user.email,
        "facebook_id": widget.user.facebookId,
        "firstname": widget.user.firstname,
        "instagram_id": widget.user.instagramId,
        "loginstatus": widget.user.loginstatus,
        "moderator_yn": widget.user.moderatorYn,
        "organisation": widget.user.organisation,
        "participant_type": widget.user.participantType,
        "password": widget.password,
        "phone": _phone,
        "pic_id": widget.user.picId,
        "short_profile": widget.user.shortProfile,
        "speaker_yn": widget.user.speaker,
        "surname": widget.user.surname,
        "title": widget.user.title,
        "twitter_id": widget.user.twitterId,
        "userinfoid": widget.user.id,
        "username": widget.user.username,
        "website": widget.user.website,
        "work_position": widget.user.workPosition,
      },
          options: Options(
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              "accept": "application/json"
            },)
      );
      print(response.statusCode);

      Navigator.pop(context, (response.statusCode == 200 || response.statusCode == 401));

      if (response.statusCode == 401)
      {
        Fluttertoast.showToast(
            msg: "Oops, something went wrong, try again.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );
//            Toast.show("Oops, something went wrong, try again.", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      }
      else
      {
        Fluttertoast.showToast(
            msg: "Profile updated successfully, please wait",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );

        Future.delayed (Duration(seconds: 3),
                () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EditProfile(data: widget.data, password: widget.password,))
              );
            }
        );
      }
    }
  }

  void _showDialogTwo (BuildContext context)
  {
    var alertDialog = AlertDialog(
//      title: new Text('Downloading'),
      contentPadding: EdgeInsets.all(0.0),
      backgroundColor: Colors.transparent,
      content: Container(
        height: 120.0,
        width: 200.0,
        child: Card(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(
                height: 10.0,
              ),
              Text ('Updating',
                style: new TextStyle (
                    color: Colors.white
                ),
              )
            ],
          ),
        ),
      ),
//      ),
//      actions: <Widget>[
//
//      ],
    );

    showDialog(
        context: global.currentContext,
        builder: (BuildContext context) {
//       if (progressString != '100%') {
          return alertDialog;

//       }
        },
        barrierDismissible: false
    );


  }
}

class UpdateOrganisation extends StatefulWidget {

  Data user; String password; Data data;

  TextEditingController organisationFilter;

  UpdateOrganisation({this.user, this.password, this.data, this.organisationFilter}) {

    this.organisationFilter = new TextEditingController(text: user.organisation);

  }
  @override
  _UpdateOrganisationState createState() => _UpdateOrganisationState();
}

class _UpdateOrganisationState extends State<UpdateOrganisation> {

  final formKey = new GlobalKey<FormState>();

//  String progressString = '';

  final global = GlobalKey();

  String _organisation = "";

  UpdateOrganisation() {
    widget.organisationFilter.addListener(_phoneListen);
  }

  void _phoneListen() {
    if (widget.organisationFilter.text.isEmpty) {
      _organisation = "";
    } else {
      _organisation = widget.organisationFilter.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: global,
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(152, 160, 87, 1),
        title: new Text("Edit Profile"),
        leading: Builder(
          builder: (context) => IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop (context);
            },
          ),
        ),
        actions: <Widget>[
//          IconButton(icon: Icon(
//              Icons.search
//          ),
//            onPressed: () {
//
//            },
//          ),
//          PopupMenuButton<String>(
//            onSelected: choiceAction,
//            itemBuilder: (BuildContext context) {
//              return Constants.choices.map((String choice){
//                return PopupMenuItem<String>(
//                  value: choice,
//                  child: new Text(choice),
//                );
//              }).toList();
//            },
//          ),
        ],
      ),
      body: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new Container(
              child: new Form(
                key: formKey,
                child: new Column(
                  children: <Widget>[
                    new Container(
                      margin: new EdgeInsets.all(10.0),
                      child: new TextFormField(
                        controller: widget.organisationFilter,
//                        keyboardType: TextInputType.phone,
                        decoration: new InputDecoration(
                            labelText: 'Organsisation',
                            prefixIcon: Padding(
                                padding: EdgeInsets.all(0.0),
                                child: Icon(
                                  Icons.phone,
                                  color: Colors.grey,
                                )
                            )
//                              border: new OutlineInputBorder(
//                                  borderSide: new BorderSide(
//                                      color: Color.fromRGBO(53, 182, 134, 1),
//                                      width: 1.0
//                                  ),
//                                  borderRadius: BorderRadius.circular(5.0)
//                              ),
                        ),
                        validator: (value) => value.isEmpty ? 'Organisation can\'t be empty' : null,
                        onSaved: (value) => _organisation = value,
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.all(11.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: new BoxDecoration(
                          color: Color.fromRGBO(53, 182, 134, 1),
                          borderRadius: new BorderRadius.circular(5.0)
                      ),
                      child: new FlatButton(
                        child: new Text('Update Profile',
                          style: new TextStyle(
                              color: Colors.white,
                              fontSize: 16.0
                          ),
                        ),
                        onPressed: () {
                          validateAndSubmit(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool validateAndSave () {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit(BuildContext context) async {

    String sendUrl ='http://icps19.com:6060/icps/i/icps/19/uru';

    if (validateAndSave()) {

      _showDialogTwo(context);

      Response response;
      Dio dio = new Dio();

      response = await dio.put(sendUrl, queryParameters: {
        "companysector": widget.user.companysector,
        "conference_id": widget.user.conferenceId,
        "country": widget.user.country,
        "email": widget.user.email,
        "facebook_id": widget.user.facebookId,
        "firstname": widget.user.firstname,
        "instagram_id": widget.user.instagramId,
        "loginstatus": widget.user.loginstatus,
        "moderator_yn": widget.user.moderatorYn,
        "organisation": _organisation,
        "participant_type": widget.user.participantType,
        "password": widget.password,
        "phone": widget.user.phone,
        "pic_id": widget.user.picId,
        "short_profile": widget.user.shortProfile,
        "speaker_yn": widget.user.speaker,
        "surname": widget.user.surname,
        "title": widget.user.title,
        "twitter_id": widget.user.twitterId,
        "userinfoid": widget.user.id,
        "username": widget.user.username,
        "website": widget.user.website,
        "work_position": widget.user.workPosition,
      },
          options: Options(
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              "accept": "application/json"
            },)
      );
      print(response.statusCode);

      Navigator.pop(context, (response.statusCode == 200 || response.statusCode == 401));

      if (response.statusCode == 401)
      {
        Fluttertoast.showToast(
            msg: "Oops, something went wrong, try again.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );
//            Toast.show("Oops, something went wrong, try again.", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      }
      else
      {
        Fluttertoast.showToast(
            msg: "Profile updated successfully, please wait",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );

        Future.delayed (Duration(seconds: 3),
                () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EditProfile(data: widget.data, password: widget.password,))
              );
            }
        );
      }
    }
  }

  void _showDialogTwo (BuildContext context)
  {
    var alertDialog = AlertDialog(
//      title: new Text('Downloading'),
      contentPadding: EdgeInsets.all(0.0),
      backgroundColor: Colors.transparent,
      content: Container(
        height: 120.0,
        width: 200.0,
        child: Card(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(
                height: 10.0,
              ),
              Text ('Updating',
                style: new TextStyle (
                    color: Colors.white
                ),
              )
            ],
          ),
        ),
      ),
//      ),
//      actions: <Widget>[
//
//      ],
    );

    showDialog(
        context: global.currentContext,
        builder: (BuildContext context) {
//       if (progressString != '100%') {
          return alertDialog;

//       }
        },
        barrierDismissible: false
    );


  }
}

class UpdateWorkPosition extends StatefulWidget {

  Data user; String password; Data data;

  TextEditingController workPositionFilter;

  UpdateWorkPosition({this.user, this.password, this.data, this.workPositionFilter}) {

    this.workPositionFilter = new TextEditingController(text: user.workPosition);

  }
  @override
  _UpdateWorkPositionState createState() => _UpdateWorkPositionState();
}

class _UpdateWorkPositionState extends State<UpdateWorkPosition> {

  final formKey = new GlobalKey<FormState>();

//  String progressString = '';

  final global = GlobalKey();

  String _workPosition = "";

  UpdateWorkPosition() {
    widget.workPositionFilter.addListener(_phoneListen);
  }

  void _phoneListen() {
    if (widget.workPositionFilter.text.isEmpty) {
      _workPosition = "";
    } else {
      _workPosition = widget.workPositionFilter.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: global,
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(152, 160, 87, 1),
        title: new Text("Edit Profile"),
        leading: Builder(
          builder: (context) => IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop (context);
            },
          ),
        ),
        actions: <Widget>[
//          IconButton(icon: Icon(
//              Icons.search
//          ),
//            onPressed: () {
//
//            },
//          ),
//          PopupMenuButton<String>(
//            onSelected: choiceAction,
//            itemBuilder: (BuildContext context) {
//              return Constants.choices.map((String choice){
//                return PopupMenuItem<String>(
//                  value: choice,
//                  child: new Text(choice),
//                );
//              }).toList();
//            },
//          ),
        ],
      ),
      body: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new Container(
              child: new Form(
                key: formKey,
                child: new Column(
                  children: <Widget>[
                    new Container(
                      margin: new EdgeInsets.all(10.0),
                      child: new TextFormField(
                        controller: widget.workPositionFilter,
//                        keyboardType: TextInputType.phone,
                        decoration: new InputDecoration(
                            labelText: 'Job title',
                            prefixIcon: Padding(
                                padding: EdgeInsets.all(0.0),
                                child: Icon(
                                  Icons.business_center,
                                  color: Colors.grey,
                                )
                            )
//                              border: new OutlineInputBorder(
//                                  borderSide: new BorderSide(
//                                      color: Color.fromRGBO(53, 182, 134, 1),
//                                      width: 1.0
//                                  ),
//                                  borderRadius: BorderRadius.circular(5.0)
//                              ),
                        ),
                        validator: (value) => value.isEmpty ? 'Job Title can\'t be empty' : null,
                        onSaved: (value) => _workPosition = value,
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.all(11.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: new BoxDecoration(
                          color: Color.fromRGBO(53, 182, 134, 1),
                          borderRadius: new BorderRadius.circular(5.0)
                      ),
                      child: new FlatButton(
                        child: new Text('Update Profile',
                          style: new TextStyle(
                              color: Colors.white,
                              fontSize: 16.0
                          ),
                        ),
                        onPressed: () {
                          validateAndSubmit(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool validateAndSave () {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit(BuildContext context) async {

    String sendUrl ='http://icps19.com:6060/icps/i/icps/19/uru';

    if (validateAndSave()) {

      _showDialogTwo(context);

      Response response;
      Dio dio = new Dio();

      response = await dio.put(sendUrl, queryParameters: {
        "companysector": widget.user.companysector,
        "conference_id": widget.user.conferenceId,
        "country": widget.user.country,
        "email": widget.user.email,
        "facebook_id": widget.user.facebookId,
        "firstname": widget.user.firstname,
        "instagram_id": widget.user.instagramId,
        "loginstatus": widget.user.loginstatus,
        "moderator_yn": widget.user.moderatorYn,
        "organisation": widget.user.organisation,
        "participant_type": widget.user.participantType,
        "password": widget.password,
        "phone": widget.user.phone,
        "pic_id": widget.user.picId,
        "short_profile": widget.user.shortProfile,
        "speaker_yn": widget.user.speaker,
        "surname": widget.user.surname,
        "title": widget.user.title,
        "twitter_id": widget.user.twitterId,
        "userinfoid": widget.user.id,
        "username": widget.user.username,
        "website": widget.user.website,
        "work_position": _workPosition,
      },
          options: Options(
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              "accept": "application/json"
            },)
      );
      print(response.statusCode);

      Navigator.pop(context, (response.statusCode == 200 || response.statusCode == 401));

      if (response.statusCode == 401)
      {
        Fluttertoast.showToast(
            msg: "Oops, something went wrong, try again.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );
//            Toast.show("Oops, something went wrong, try again.", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      }
      else
      {
        Fluttertoast.showToast(
            msg: "Profile updated successfully, please wait",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );

        Future.delayed (Duration(seconds: 3),
                () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EditProfile(data: widget.data, password: widget.password,))
              );
            }
        );
      }
    }
  }

  void _showDialogTwo (BuildContext context)
  {
    var alertDialog = AlertDialog(
//      title: new Text('Downloading'),
      contentPadding: EdgeInsets.all(0.0),
      backgroundColor: Colors.transparent,
      content: Container(
        height: 120.0,
        width: 200.0,
        child: Card(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(
                height: 10.0,
              ),
              Text ('Updating',
                style: new TextStyle (
                    color: Colors.white
                ),
              )
            ],
          ),
        ),
      ),
//      ),
//      actions: <Widget>[
//
//      ],
    );

    showDialog(
        context: global.currentContext,
        builder: (BuildContext context) {
//       if (progressString != '100%') {
          return alertDialog;

//       }
        },
        barrierDismissible: false
    );


  }
}

class UpdateCompanySector extends StatefulWidget {

  Data user; String password; Data data;

//  TextEditingController workPositionFilter;

  UpdateCompanySector({this.user, this.password, this.data});

  @override
  _UpdateCompanySectorState createState() => _UpdateCompanySectorState();
}

class _UpdateCompanySectorState extends State<UpdateCompanySector> {

  final formKey = new GlobalKey<FormState>();

//  String progressString = '';

  final global = GlobalKey();

  var _companySector = ['Finance', 'Agriculture', 'Oil and Gas', 'Services', 'Transport', 'Tourism', 'Mining', 'Energy', 'Data',
    'Electricity', 'Overseas remittances', 'Real Estate/Construction', 'Consumer Goods', 'Healthcare', 'Industrial Goods',
    'Information and Communications Technology ICT', 'Natural Resources', 'Utilities', 'Manufacturing Industry', 'Chemical Industry', 'Consumer Electronics',
    'Steel Production', 'Aerospace Industry', 'Brewing Industry', 'Textile Industry', 'Metal Working', 'Computer Industry', 'Defense Industry',
    'Education Industry', 'Entertainment Industry', 'Food Industry', 'Hospitality Industry', 'Mass media', 'Telecommunications Industry', 'Water Industry'];

  var _currentCompanySectorSelected = 'Finance';

//  String _workPosition = "";
//
//  UpdateWorkPosition() {
//    widget.workPositionFilter.addListener(_phoneListen);
//  }
//
//  void _phoneListen() {
//    if (widget.workPositionFilter.text.isEmpty) {
//      _workPosition = "";
//    } else {
//      _workPosition = widget.workPositionFilter.text;
//    }
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: global,
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(152, 160, 87, 1),
        title: new Text("Edit Profile"),
        leading: Builder(
          builder: (context) => IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop (context);
            },
          ),
        ),
        actions: <Widget>[
//          IconButton(icon: Icon(
//              Icons.search
//          ),
//            onPressed: () {
//
//            },
//          ),
//          PopupMenuButton<String>(
//            onSelected: choiceAction,
//            itemBuilder: (BuildContext context) {
//              return Constants.choices.map((String choice){
//                return PopupMenuItem<String>(
//                  value: choice,
//                  child: new Text(choice),
//                );
//              }).toList();
//            },
//          ),
        ],
      ),
      body: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new Container(
              child: new Form(
                key: formKey,
                child: new Column(
                  children: <Widget>[
                    new Container(
                        child: new Column (
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget> [
//                              new Container(
//                                margin: new EdgeInsets.only(top: 15.0, left: 20.0),
//                                child: new Text('What sector is your company in?',
//                                  style: new TextStyle(
//                                      fontSize: 16.0
//                                  ),
//                                ),
//                              ),
                              new Container(
                                margin: new EdgeInsets.all(10.0),
                                width: MediaQuery.of(context).size.width,
                                child: new InputDecorator(
                                    decoration: new InputDecoration(
                                        labelText: 'What sector is your company in?*',
                                        prefixIcon: Padding(
                                            padding: EdgeInsets.all(0.0),
                                            child: Icon(
                                              Icons.business_center,
                                              color: Colors.grey,
                                            )
                                        )
                                    ),
//                                    alignedDropdown: true,
                                    child: DropdownButtonHideUnderline(
//                                        child: new Container(
//                                          decoration: ShapeDecoration(
//                                            shape: RoundedRectangleBorder(
//                                              side: BorderSide(
//                                                  width: 1.0,
//                                                  style: BorderStyle.solid
//                                              ),
//                                              borderRadius: BorderRadius.all(
//                                                  Radius.circular(5.0)
//                                              ),
//                                            ),
//                                          ),
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        isDense: true,
                                        items: _companySector.map((String dropDownStringItem) {
                                          return DropdownMenuItem<String> (
                                            value: dropDownStringItem,
                                            child: Text(dropDownStringItem),
                                          );
                                        }).toList(),
                                        onChanged: (String newValueSelected) {
                                          _onDropDownCompanySectorSelected (newValueSelected);
                                        },
                                        value: _currentCompanySectorSelected,
                                      ),
                                    )
                                ),
//                                  )
                              ),
                            ]
                        )
                    ),
                    new Container(
                      margin: new EdgeInsets.all(11.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: new BoxDecoration(
                          color: Color.fromRGBO(53, 182, 134, 1),
                          borderRadius: new BorderRadius.circular(5.0)
                      ),
                      child: new FlatButton(
                        child: new Text('Update Profile',
                          style: new TextStyle(
                              color: Colors.white,
                              fontSize: 16.0
                          ),
                        ),
                        onPressed: () {
                          validateAndSubmit(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool validateAndSave () {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit(BuildContext context) async {

    String sendUrl ='http://icps19.com:6060/icps/i/icps/19/uru';

    if (validateAndSave()) {

      _showDialogTwo(context);

      Response response;
      Dio dio = new Dio();

      response = await dio.put(sendUrl, queryParameters: {
        "companysector": _currentCompanySectorSelected,
        "conference_id": widget.user.conferenceId,
        "country": widget.user.country,
        "email": widget.user.email,
        "facebook_id": widget.user.facebookId,
        "firstname": widget.user.firstname,
        "instagram_id": widget.user.instagramId,
        "loginstatus": widget.user.loginstatus,
        "moderator_yn": widget.user.moderatorYn,
        "organisation": widget.user.organisation,
        "participant_type": widget.user.participantType,
        "password": widget.password,
        "phone": widget.user.phone,
        "pic_id": widget.user.picId,
        "short_profile": widget.user.shortProfile,
        "speaker_yn": widget.user.speaker,
        "surname": widget.user.surname,
        "title": widget.user.title,
        "twitter_id": widget.user.twitterId,
        "userinfoid": widget.user.id,
        "username": widget.user.username,
        "website": widget.user.website,
        "work_position": widget.user.workPosition,
      },
          options: Options(
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              "accept": "application/json"
            },)
      );
      print(response.statusCode);

      Navigator.pop(context, (response.statusCode == 200 || response.statusCode == 401));

      if (response.statusCode == 401)
      {
        Fluttertoast.showToast(
            msg: "Oops, something went wrong, try again.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );
//            Toast.show("Oops, something went wrong, try again.", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      }
      else
      {
        Fluttertoast.showToast(
            msg: "Profile updated successfully, please wait",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );

        Future.delayed (Duration(seconds: 3),
                () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EditProfile(data: widget.data, password: widget.password,))
              );
            }
        );
      }
    }
  }

  void _onDropDownCompanySectorSelected (String newValueSelected)
  {
    setState(() {
      this._currentCompanySectorSelected = newValueSelected;
    });
  }

  void _showDialogTwo (BuildContext context)
  {
    var alertDialog = AlertDialog(
//      title: new Text('Downloading'),
      contentPadding: EdgeInsets.all(0.0),
      backgroundColor: Colors.transparent,
      content: Container(
        height: 120.0,
        width: 200.0,
        child: Card(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(
                height: 10.0,
              ),
              Text ('Updating',
                style: new TextStyle (
                    color: Colors.white
                ),
              )
            ],
          ),
        ),
      ),
//      ),
//      actions: <Widget>[
//
//      ],
    );

    showDialog(
        context: global.currentContext,
        builder: (BuildContext context) {
//       if (progressString != '100%') {
          return alertDialog;

//       }
        },
        barrierDismissible: false
    );


  }
}

class UpdateCountry extends StatefulWidget {

  Data user; String password; Data data;

//  TextEditingController workPositionFilter;

  UpdateCountry({this.user, this.password, this.data});

  @override
  _UpdateCountryState createState() => _UpdateCountryState();
}

class _UpdateCountryState extends State<UpdateCountry> {

  final formKey = new GlobalKey<FormState>();

//  String progressString = '';

  final global = GlobalKey();

  var _country = ["Afghanistan", "Albania", "Algeria", "American Samoa", "Andorra", "Angola", "Anguilla", "Antarctica",
    "Antigua and Barbuda", "Argentina", "Armenia", "Aruba", "Australia", "Austria", "Azerbaijan", "Bahamas", "Bahrain",
    "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin", "Bermuda", "Bhutan", "Bolivia", "Bosnia and Herzegowina",
    "Botswana", "Bouvet Island", "Brazil", "British Indian Ocean Territory", "Brunei Darussalam", "Bulgaria", "Burkina Faso",
    "Burundi", "Cambodia", "Cameroon", "Canada", "Cape Verde", "Cayman Islands", "Central African Republic", "Chad", "Chile",
    "China", "Christmas Island", "Cocos (Keeling) Islands", "Colombia", "Comoros", "Congo", "Congo, the Democratic Republic of the",
    "Cook Islands", "Costa Rica", "Cote d'Ivoire", "Croatia (Hrvatska)", "Cuba", "Cyprus", "Czech Republic", "Denmark", "Djibouti",
    "Dominica", "Dominican Republic", "East Timor", "Ecuador", "Egypt", "El Salvador", "Equatorial Guinea", "Eritrea", "Estonia",
    "Ethiopia", "Falkland Islands (Malvinas)", "Faroe Islands", "Fiji", "Finland", "France", "France Metropolitan", "French Guiana",
    "French Polynesia", "French Southern Territories", "Gabon", "Gambia", "Georgia", "Germany", "Ghana", "Gibraltar", "Greece",
    "Greenland", "Grenada", "Guadeloupe", "Guam", "Guatemala", "Guinea", "Guinea-Bissau", "Guyana", "Haiti", "Heard and Mc Donald Islands",
    "Holy See (Vatican City State)", "Honduras", "Hong Kong", "Hungary", "Iceland", "India", "Indonesia", "Iran (Islamic Republic of)",
    "Iraq", "Ireland", "Israel", "Italy", "Jamaica", "Japan", "Jordan", "Kazakhstan", "Kenya", "Kiribati", "Korea, Democratic People's Republic of",
    "Korea, Republic of", "Kuwait", "Kyrgyzstan", "Lao, People's Democratic Republic", "Latvia", "Lebanon", "Lesotho", "Liberia",
    "Libyan Arab Jamahiriya", "Liechtenstein", "Lithuania", "Luxembourg", "Macau", "Macedonia, The Former Yugoslav Republic of",
    "Madagascar", "Malawi", "Malaysia", "Maldives", "Mali", "Malta", "Marshall Islands", "Martinique", "Mauritania", "Mauritius",
    "Mayotte", "Mexico", "Micronesia, Federated States of", "Moldova, Republic of", "Monaco", "Mongolia", "Montserrat", "Morocco",
    "Mozambique", "Myanmar", "Namibia", "Nauru", "Nepal", "Netherlands", "Netherlands Antilles", "New Caledonia", "New Zealand",
    "Nicaragua", "Niger", "Nigeria", "Niue", "Norfolk Island", "Northern Mariana Islands", "Norway", "Oman", "Pakistan", "Palau",
    "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines", "Pitcairn", "Poland", "Portugal", "Puerto Rico", "Qatar",
    "Reunion", "Romania", "Russian Federation", "Rwanda", "Saint Kitts and Nevis", "Saint Lucia", "Saint Vincent and the Grenadines",
    "Samoa", "San Marino", "Sao Tome and Principe", "Saudi Arabia", "Senegal", "Seychelles", "Sierra Leone", "Singapore",
    "Slovakia (Slovak Republic)", "Slovenia", "Solomon Islands", "Somalia", "South Africa", "South Georgia and the South Sandwich Islands",
    "Spain", "Sri Lanka", "St. Helena", "St. Pierre and Miquelon", "Sudan", "Suriname", "Svalbard and Jan Mayen Islands", "Swaziland",
    "Sweden", "Switzerland", "Syrian Arab Republic", "Taiwan, Province of China", "Tajikistan", "Tanzania, United Republic of",
    "Thailand", "Togo", "Tokelau", "Tonga", "Trinidad and Tobago", "Tunisia", "Turkey", "Turkmenistan", "Turks and Caicos Islands",
    "Tuvalu", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom", "United States", "United States Minor Outlying Islands",
    "Uruguay", "Uzbekistan", "Vanuatu", "Venezuela", "Vietnam", "Virgin Islands (British)", "Virgin Islands (U.S.)", "Wallis and Futuna Islands",
    "Western Sahara", "Yemen", "Yugoslavia", "Zambia", "Zimbabwe"];

  var _currentCountrySelected = 'Nigeria';
//  String _workPosition = "";
//
//  UpdateWorkPosition() {
//    widget.workPositionFilter.addListener(_phoneListen);
//  }
//
//  void _phoneListen() {
//    if (widget.workPositionFilter.text.isEmpty) {
//      _workPosition = "";
//    } else {
//      _workPosition = widget.workPositionFilter.text;
//    }
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: global,
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(152, 160, 87, 1),
        title: new Text("Edit Profile"),
        leading: Builder(
          builder: (context) => IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop (context);
            },
          ),
        ),
        actions: <Widget>[
//          IconButton(icon: Icon(
//              Icons.search
//          ),
//            onPressed: () {
//
//            },
//          ),
//          PopupMenuButton<String>(
//            onSelected: choiceAction,
//            itemBuilder: (BuildContext context) {
//              return Constants.choices.map((String choice){
//                return PopupMenuItem<String>(
//                  value: choice,
//                  child: new Text(choice),
//                );
//              }).toList();
//            },
//          ),
        ],
      ),
      body: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new Container(
              child: new Form(
                key: formKey,
                child: new Column(
                  children: <Widget>[
                    new Container(
                        child: new Column (
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget> [
//                              new Container(
//                                margin: new EdgeInsets.only(top: 25.0, left: 20.0),
//                                child: new Text('Country',
//                                  style: new TextStyle(
//                                      fontSize: 16.0
//                                  ),
//                                ),
//                              ),
                              new Container(
                                  margin: new EdgeInsets.all(10.0),
                                  width: MediaQuery.of(context).size.width,
                                  child: new InputDecorator(
                                      decoration: new InputDecoration(
                                          labelText: 'Country*',
                                          prefixIcon: Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Icon(
                                                Icons.public,
                                                color: Colors.grey,
                                              )
                                          )
                                      ),
//                                    alignedDropdown: true,
                                      child: DropdownButtonHideUnderline(
//                                        child: new Container(
//                                          decoration: ShapeDecoration(
//                                            shape: RoundedRectangleBorder(
//                                              side: BorderSide(
//                                                  width: 1.0,
//                                                  style: BorderStyle.solid
//                                              ),
//                                              borderRadius: BorderRadius.all(
//                                                  Radius.circular(5.0)
//                                              ),
//                                            ),
//                                          ),
                                        child: DropdownButton<String>(
                                          isExpanded: true,
                                          isDense: true,
                                          items: _country.map((String dropDownStringItem) {
                                            return DropdownMenuItem<String> (
                                              value: dropDownStringItem,
                                              child: Text(dropDownStringItem),
                                            );
                                          }).toList(),
                                          onChanged: (String newValueSelected) {
                                            _onDropDownCountrySelected (newValueSelected);
                                          },
                                          value: _currentCountrySelected,
                                        ),
                                      )
//                                    ),
                                  )
                              ),
                            ]
                        )
                    ),
                    new Container(
                      margin: new EdgeInsets.all(11.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: new BoxDecoration(
                          color: Color.fromRGBO(53, 182, 134, 1),
                          borderRadius: new BorderRadius.circular(5.0)
                      ),
                      child: new FlatButton(
                        child: new Text('Update Profile',
                          style: new TextStyle(
                              color: Colors.white,
                              fontSize: 16.0
                          ),
                        ),
                        onPressed: () {
                          validateAndSubmit(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool validateAndSave () {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit(BuildContext context) async {

    String sendUrl ='http://icps19.com:6060/icps/i/icps/19/uru';

    if (validateAndSave()) {

      _showDialogTwo(context);

      Response response;
      Dio dio = new Dio();

      response = await dio.put(sendUrl, queryParameters: {
        "companysector": widget.user.companysector,
        "conference_id": widget.user.conferenceId,
        "country": _currentCountrySelected,
        "email": widget.user.email,
        "facebook_id": widget.user.facebookId,
        "firstname": widget.user.firstname,
        "instagram_id": widget.user.instagramId,
        "loginstatus": widget.user.loginstatus,
        "moderator_yn": widget.user.moderatorYn,
        "organisation": widget.user.organisation,
        "participant_type": widget.user.participantType,
        "password": widget.password,
        "phone": widget.user.phone,
        "pic_id": widget.user.picId,
        "short_profile": widget.user.shortProfile,
        "speaker_yn": widget.user.speaker,
        "surname": widget.user.surname,
        "title": widget.user.title,
        "twitter_id": widget.user.twitterId,
        "userinfoid": widget.user.id,
        "username": widget.user.username,
        "website": widget.user.website,
        "work_position": widget.user.workPosition,
      },
          options: Options(
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              "accept": "application/json"
            },)
      );
      print(response.statusCode);

      Navigator.pop(context, (response.statusCode == 200 || response.statusCode == 401));

      if (response.statusCode == 401)
      {
        Fluttertoast.showToast(
            msg: "Oops, something went wrong, try again.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );
//            Toast.show("Oops, something went wrong, try again.", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      }
      else
      {
        Fluttertoast.showToast(
            msg: "Profile updated successfully, please wait",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );

        Future.delayed (Duration(seconds: 3),
                () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EditProfile(data: widget.data, password: widget.password,))
              );
            }
        );
      }
    }
  }

  void _onDropDownCountrySelected (String newValueSelected)
  {
    setState(() {
      this._currentCountrySelected = newValueSelected;
    });
  }

  void _showDialogTwo (BuildContext context)
  {
    var alertDialog = AlertDialog(
//      title: new Text('Downloading'),
      contentPadding: EdgeInsets.all(0.0),
      backgroundColor: Colors.transparent,
      content: Container(
        height: 120.0,
        width: 200.0,
        child: Card(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(
                height: 10.0,
              ),
              Text ('Updating',
                style: new TextStyle (
                    color: Colors.white
                ),
              )
            ],
          ),
        ),
      ),
//      ),
//      actions: <Widget>[
//
//      ],
    );

    showDialog(
        context: global.currentContext,
        builder: (BuildContext context) {
//       if (progressString != '100%') {
          return alertDialog;

//       }
        },
        barrierDismissible: false
    );


  }
}

class UpdateFacebook extends StatefulWidget {

  Data user; String password; Data data;

  TextEditingController facebookFilter;

  UpdateFacebook({this.user, this.password, this.data, this.facebookFilter}) {

    this.facebookFilter = new TextEditingController(text: user.facebookId);

  }
  @override
  _UpdateFacebookState createState() => _UpdateFacebookState();
}

class _UpdateFacebookState extends State<UpdateFacebook> {

  final formKey = new GlobalKey<FormState>();

//  String progressString = '';

  final global = GlobalKey();

  String _facebookId = "";

  UpdateWorkPosition() {
    widget.facebookFilter.addListener(_facebookListen);
  }

  void _facebookListen() {
    if (widget.facebookFilter.text.isEmpty) {
      _facebookId = "";
    } else {
      _facebookId = widget.facebookFilter.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: global,
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(152, 160, 87, 1),
        title: new Text("Edit Profile"),
        leading: Builder(
          builder: (context) => IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop (context);
            },
          ),
        ),
        actions: <Widget>[
//          IconButton(icon: Icon(
//              Icons.search
//          ),
//            onPressed: () {
//
//            },
//          ),
//          PopupMenuButton<String>(
//            onSelected: choiceAction,
//            itemBuilder: (BuildContext context) {
//              return Constants.choices.map((String choice){
//                return PopupMenuItem<String>(
//                  value: choice,
//                  child: new Text(choice),
//                );
//              }).toList();
//            },
//          ),
        ],
      ),
      body: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new Container(
              child: new Form(
                key: formKey,
                child: new Column(
                  children: <Widget>[
                    new Container(
                      margin: new EdgeInsets.all(10.0),
                      child: new TextFormField(
                        controller: widget.facebookFilter,
//                        keyboardType: TextInputType.phone,
                        decoration: new InputDecoration(
                            labelText: 'Facebook',
                            prefixIcon: Padding(
                                padding: EdgeInsets.all(0.0),
                                child: Icon(
                                  FontAwesomeIcons.facebook,
                                  color: Colors.grey,
                                )
                            )
//                              border: new OutlineInputBorder(
//                                  borderSide: new BorderSide(
//                                      color: Color.fromRGBO(53, 182, 134, 1),
//                                      width: 1.0
//                                  ),
//                                  borderRadius: BorderRadius.circular(5.0)
//                              ),
                        ),
                        validator: (value) => value.isEmpty ? 'Facebook can\'t be empty' : null,
                        onSaved: (value) => _facebookId = value,
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.all(11.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: new BoxDecoration(
                          color: Color.fromRGBO(53, 182, 134, 1),
                          borderRadius: new BorderRadius.circular(5.0)
                      ),
                      child: new FlatButton(
                        child: new Text('Update Profile',
                          style: new TextStyle(
                              color: Colors.white,
                              fontSize: 16.0
                          ),
                        ),
                        onPressed: () {
                          validateAndSubmit(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool validateAndSave () {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit(BuildContext context) async {

    String sendUrl ='http://icps19.com:6060/icps/i/icps/19/uru';

    if (validateAndSave()) {

      _showDialogTwo(context);

      Response response;
      Dio dio = new Dio();

      response = await dio.put(sendUrl, queryParameters: {
        "companysector": widget.user.companysector,
        "conference_id": widget.user.conferenceId,
        "country": widget.user.country,
        "email": widget.user.email,
        "facebook_id": _facebookId,
        "firstname": widget.user.firstname,
        "instagram_id": widget.user.instagramId,
        "loginstatus": widget.user.loginstatus,
        "moderator_yn": widget.user.moderatorYn,
        "organisation": widget.user.organisation,
        "participant_type": widget.user.participantType,
        "password": widget.password,
        "phone": widget.user.phone,
        "pic_id": widget.user.picId,
        "short_profile": widget.user.shortProfile,
        "speaker_yn": widget.user.speaker,
        "surname": widget.user.surname,
        "title": widget.user.title,
        "twitter_id": widget.user.twitterId,
        "userinfoid": widget.user.id,
        "username": widget.user.username,
        "website": widget.user.website,
        "work_position": widget.user.workPosition,
      },
          options: Options(
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              "accept": "application/json"
            },)
      );
      print(response.statusCode);

      Navigator.pop(context, (response.statusCode == 200 || response.statusCode == 401));

      if (response.statusCode == 401)
      {
        Fluttertoast.showToast(
            msg: "Oops, something went wrong, try again.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );
//            Toast.show("Oops, something went wrong, try again.", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      }
      else
      {
        Fluttertoast.showToast(
            msg: "Profile updated successfully, please wait",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );

        Future.delayed (Duration(seconds: 3),
                () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EditProfile(data: widget.data, password: widget.password,))
              );
            }
        );
      }
    }
  }

  void _showDialogTwo (BuildContext context)
  {
    var alertDialog = AlertDialog(
//      title: new Text('Downloading'),
      contentPadding: EdgeInsets.all(0.0),
      backgroundColor: Colors.transparent,
      content: Container(
        height: 120.0,
        width: 200.0,
        child: Card(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(
                height: 10.0,
              ),
              Text ('Updating',
                style: new TextStyle (
                    color: Colors.white
                ),
              )
            ],
          ),
        ),
      ),
//      ),
//      actions: <Widget>[
//
//      ],
    );

    showDialog(
        context: global.currentContext,
        builder: (BuildContext context) {
//       if (progressString != '100%') {
          return alertDialog;

//       }
        },
        barrierDismissible: false
    );


  }
}

class UpdateTwitter extends StatefulWidget {

  Data user; String password; Data data;

  TextEditingController twitterFilter;

  UpdateTwitter({this.user, this.password, this.data, this.twitterFilter}) {

    this.twitterFilter = new TextEditingController(text: user.twitterId);

  }
  @override
  _UpdateTwitterState createState() => _UpdateTwitterState();
}

class _UpdateTwitterState extends State<UpdateTwitter> {

  final formKey = new GlobalKey<FormState>();

//  String progressString = '';

  final global = GlobalKey();

  String _twitterId = "";

  UpdateWorkPosition() {
    widget.twitterFilter.addListener(_twitterListen);
  }

  void _twitterListen() {
    if (widget.twitterFilter.text.isEmpty) {
      _twitterId = "";
    } else {
      _twitterId = widget.twitterFilter.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: global,
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(152, 160, 87, 1),
        title: new Text("Edit Profile"),
        leading: Builder(
          builder: (context) => IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop (context);
            },
          ),
        ),
        actions: <Widget>[
//          IconButton(icon: Icon(
//              Icons.search
//          ),
//            onPressed: () {
//
//            },
//          ),
//          PopupMenuButton<String>(
//            onSelected: choiceAction,
//            itemBuilder: (BuildContext context) {
//              return Constants.choices.map((String choice){
//                return PopupMenuItem<String>(
//                  value: choice,
//                  child: new Text(choice),
//                );
//              }).toList();
//            },
//          ),
        ],
      ),
      body: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new Container(
              child: new Form(
                key: formKey,
                child: new Column(
                  children: <Widget>[
                    new Container(
                      margin: new EdgeInsets.all(10.0),
                      child: new TextFormField(
                        controller: widget.twitterFilter,
//                        keyboardType: TextInputType.phone,
                        decoration: new InputDecoration(
                            labelText: 'Twitter',
                            prefixIcon: Padding(
                                padding: EdgeInsets.all(0.0),
                                child: Icon(
                                  FontAwesomeIcons.twitter,
                                  color: Colors.grey,
                                )
                            )
//                              border: new OutlineInputBorder(
//                                  borderSide: new BorderSide(
//                                      color: Color.fromRGBO(53, 182, 134, 1),
//                                      width: 1.0
//                                  ),
//                                  borderRadius: BorderRadius.circular(5.0)
//                              ),
                        ),
                        validator: (value) => value.isEmpty ? 'Twitter can\'t be empty' : null,
                        onSaved: (value) => _twitterId = value,
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.all(11.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: new BoxDecoration(
                          color: Color.fromRGBO(53, 182, 134, 1),
                          borderRadius: new BorderRadius.circular(5.0)
                      ),
                      child: new FlatButton(
                        child: new Text('Update Profile',
                          style: new TextStyle(
                              color: Colors.white,
                              fontSize: 16.0
                          ),
                        ),
                        onPressed: () {
                          validateAndSubmit(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool validateAndSave () {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit(BuildContext context) async {

    String sendUrl ='http://icps19.com:6060/icps/i/icps/19/uru';

    if (validateAndSave()) {

      _showDialogTwo(context);

      Response response;
      Dio dio = new Dio();

      response = await dio.put(sendUrl, queryParameters: {
        "companysector": widget.user.companysector,
        "conference_id": widget.user.conferenceId,
        "country": widget.user.country,
        "email": widget.user.email,
        "facebook_id": widget.user.facebookId,
        "firstname": widget.user.firstname,
        "instagram_id": widget.user.instagramId,
        "loginstatus": widget.user.loginstatus,
        "moderator_yn": widget.user.moderatorYn,
        "organisation": widget.user.organisation,
        "participant_type": widget.user.participantType,
        "password": widget.password,
        "phone": widget.user.phone,
        "pic_id": widget.user.picId,
        "short_profile": widget.user.shortProfile,
        "speaker_yn": widget.user.speaker,
        "surname": widget.user.surname,
        "title": widget.user.title,
        "twitter_id": _twitterId,
        "userinfoid": widget.user.id,
        "username": widget.user.username,
        "website": widget.user.website,
        "work_position": widget.user.workPosition,
      },
          options: Options(
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              "accept": "application/json"
            },)
      );
      print(response.statusCode);

      Navigator.pop(context, (response.statusCode == 200 || response.statusCode == 401));

      if (response.statusCode == 401)
      {
        Fluttertoast.showToast(
            msg: "Oops, something went wrong, try again.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );
//            Toast.show("Oops, something went wrong, try again.", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      }
      else
      {
        Fluttertoast.showToast(
            msg: "Profile updated successfully, please wait",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );

        Future.delayed (Duration(seconds: 3),
                () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EditProfile(data: widget.data, password: widget.password,))
              );
            }
        );
      }
    }
  }

  void _showDialogTwo (BuildContext context)
  {
    var alertDialog = AlertDialog(
//      title: new Text('Downloading'),
      contentPadding: EdgeInsets.all(0.0),
      backgroundColor: Colors.transparent,
      content: Container(
        height: 120.0,
        width: 200.0,
        child: Card(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(
                height: 10.0,
              ),
              Text ('Updating',
                style: new TextStyle (
                    color: Colors.white
                ),
              )
            ],
          ),
        ),
      ),
//      ),
//      actions: <Widget>[
//
//      ],
    );

    showDialog(
        context: global.currentContext,
        builder: (BuildContext context) {
//       if (progressString != '100%') {
          return alertDialog;

//       }
        },
        barrierDismissible: false
    );


  }
}

class UpdateWebsite extends StatefulWidget {

  Data user; String password; Data data;

  TextEditingController websiteFilter;

  UpdateWebsite({this.user, this.password, this.data, this.websiteFilter}) {

    this.websiteFilter = new TextEditingController(text: user.website);

  }
  @override
  _UpdateWebsiteState createState() => _UpdateWebsiteState();
}

class _UpdateWebsiteState extends State<UpdateWebsite> {

  final formKey = new GlobalKey<FormState>();

//  String progressString = '';

  final global = GlobalKey();

  String _website = "";

  UpdateWorkPosition() {
    widget.websiteFilter.addListener(_websiteListen);
  }

  void _websiteListen() {
    if (widget.websiteFilter.text.isEmpty) {
      _website = "";
    } else {
      _website = widget.websiteFilter.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: global,
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(152, 160, 87, 1),
        title: new Text("Edit Profile"),
        leading: Builder(
          builder: (context) => IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop (context);
            },
          ),
        ),
        actions: <Widget>[
//          IconButton(icon: Icon(
//              Icons.search
//          ),
//            onPressed: () {
//
//            },
//          ),
//          PopupMenuButton<String>(
//            onSelected: choiceAction,
//            itemBuilder: (BuildContext context) {
//              return Constants.choices.map((String choice){
//                return PopupMenuItem<String>(
//                  value: choice,
//                  child: new Text(choice),
//                );
//              }).toList();
//            },
//          ),
        ],
      ),
      body: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new Container(
              child: new Form(
                key: formKey,
                child: new Column(
                  children: <Widget>[
                    new Container(
                      margin: new EdgeInsets.all(10.0),
                      child: new TextFormField(
                        controller: widget.websiteFilter,
//                        keyboardType: TextInputType.phone,
                        decoration: new InputDecoration(
                            labelText: 'Website',
                            prefixIcon: Padding(
                                padding: EdgeInsets.all(0.0),
                                child: Icon(
                                  Icons.web,
                                  color: Colors.grey,
                                )
                            )
//                              border: new OutlineInputBorder(
//                                  borderSide: new BorderSide(
//                                      color: Color.fromRGBO(53, 182, 134, 1),
//                                      width: 1.0
//                                  ),
//                                  borderRadius: BorderRadius.circular(5.0)
//                              ),
                        ),
                        validator: (value) => value.isEmpty ? 'Website can\'t be empty' : null,
                        onSaved: (value) => _website = value,
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.all(11.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: new BoxDecoration(
                          color: Color.fromRGBO(53, 182, 134, 1),
                          borderRadius: new BorderRadius.circular(5.0)
                      ),
                      child: new FlatButton(
                        child: new Text('Update Profile',
                          style: new TextStyle(
                              color: Colors.white,
                              fontSize: 16.0
                          ),
                        ),
                        onPressed: () {
                          validateAndSubmit(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool validateAndSave () {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit(BuildContext context) async {

    String sendUrl ='http://icps19.com:6060/icps/i/icps/19/uru';

    if (validateAndSave()) {

      _showDialogTwo(context);

      Response response;
      Dio dio = new Dio();

      response = await dio.put(sendUrl, queryParameters: {
        "companysector": widget.user.companysector,
        "conference_id": widget.user.conferenceId,
        "country": widget.user.country,
        "email": widget.user.email,
        "facebook_id": widget.user.facebookId,
        "firstname": widget.user.firstname,
        "instagram_id": widget.user.instagramId,
        "loginstatus": widget.user.loginstatus,
        "moderator_yn": widget.user.moderatorYn,
        "organisation": widget.user.organisation,
        "participant_type": widget.user.participantType,
        "password": widget.password,
        "phone": widget.user.phone,
        "pic_id": widget.user.picId,
        "short_profile": widget.user.shortProfile,
        "speaker_yn": widget.user.speaker,
        "surname": widget.user.surname,
        "title": widget.user.title,
        "twitter_id": widget.user.twitterId,
        "userinfoid": widget.user.id,
        "username": widget.user.username,
        "website": _website,
        "work_position": widget.user.workPosition,
      },
          options: Options(
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              "accept": "application/json"
            },)
      );
      print(response.statusCode);

      Navigator.pop(context, (response.statusCode == 200 || response.statusCode == 401));

      if (response.statusCode == 401)
      {
        Fluttertoast.showToast(
            msg: "Oops, something went wrong, try again.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );
//            Toast.show("Oops, something went wrong, try again.", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      }
      else
      {
        Fluttertoast.showToast(
            msg: "Profile updated successfully, please wait",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );

        Future.delayed (Duration(seconds: 3),
                () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EditProfile(data: widget.data, password: widget.password,))
              );
            }
        );
      }
    }
  }

  void _showDialogTwo (BuildContext context)
  {
    var alertDialog = AlertDialog(
//      title: new Text('Downloading'),
      contentPadding: EdgeInsets.all(0.0),
      backgroundColor: Colors.transparent,
      content: Container(
        height: 120.0,
        width: 200.0,
        child: Card(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(
                height: 10.0,
              ),
              Text ('Updating',
                style: new TextStyle (
                    color: Colors.white
                ),
              )
            ],
          ),
        ),
      ),
//      ),
//      actions: <Widget>[
//
//      ],
    );

    showDialog(
        context: global.currentContext,
        builder: (BuildContext context) {
//       if (progressString != '100%') {
          return alertDialog;

//       }
        },
        barrierDismissible: false
    );


  }
}

class UpdateShortProfile extends StatefulWidget {

  Data user; String password; Data data;

  TextEditingController shortProfileFilter;

  UpdateShortProfile({this.user, this.password, this.data, this.shortProfileFilter}) {

    this.shortProfileFilter = new TextEditingController(text: user.shortProfile);

  }
  @override
  _UpdateShortProfileState createState() => _UpdateShortProfileState();
}

class _UpdateShortProfileState extends State<UpdateShortProfile> {

  final formKey = new GlobalKey<FormState>();

//  String progressString = '';

  final global = GlobalKey();

  String _shortProfile = "";

  UpdateWorkPosition() {
    widget.shortProfileFilter.addListener(_shortProfileListen);
  }

  void _shortProfileListen() {
    if (widget.shortProfileFilter.text.isEmpty) {
      _shortProfile = "";
    } else {
      _shortProfile = widget.shortProfileFilter.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: global,
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(152, 160, 87, 1),
        title: new Text("Edit Profile"),
        leading: Builder(
          builder: (context) => IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop (context);
            },
          ),
        ),
        actions: <Widget>[
//          IconButton(icon: Icon(
//              Icons.search
//          ),
//            onPressed: () {
//
//            },
//          ),
//          PopupMenuButton<String>(
//            onSelected: choiceAction,
//            itemBuilder: (BuildContext context) {
//              return Constants.choices.map((String choice){
//                return PopupMenuItem<String>(
//                  value: choice,
//                  child: new Text(choice),
//                );
//              }).toList();
//            },
//          ),
        ],
      ),
      body: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new Container(
              child: new Form(
                key: formKey,
                child: new Column(
                  children: <Widget>[
                    new Container(
                      margin: new EdgeInsets.all(10.0),
                      child: new TextFormField(
                        controller: widget.shortProfileFilter,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: new InputDecoration(
                            labelText: 'Brief Profile',
                            prefixIcon: Padding(
                                padding: EdgeInsets.all(0.0),
                                child: Icon(
                                  Icons.description,
                                  color: Colors.grey,
                                )
                            )
//                              border: new OutlineInputBorder(
//                                  borderSide: new BorderSide(
//                                      color: Color.fromRGBO(53, 182, 134, 1),
//                                      width: 1.0
//                                  ),
//                                  borderRadius: BorderRadius.circular(5.0)
//                              ),
                        ),
                        validator: (value) => value.isEmpty ? 'Brief Profile can\'t be empty' : null,
                        onSaved: (value) => _shortProfile = value,
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.all(11.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: new BoxDecoration(
                          color: Color.fromRGBO(53, 182, 134, 1),
                          borderRadius: new BorderRadius.circular(5.0)
                      ),
                      child: new FlatButton(
                        child: new Text('Update Profile',
                          style: new TextStyle(
                              color: Colors.white,
                              fontSize: 16.0
                          ),
                        ),
                        onPressed: () {
                          validateAndSubmit(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool validateAndSave () {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit(BuildContext context) async {

    String sendUrl ='http://icps19.com:6060/icps/i/icps/19/uru';

    if (validateAndSave()) {

      _showDialogTwo(context);

      Response response;
      Dio dio = new Dio();

      response = await dio.put(sendUrl, queryParameters: {
        "companysector": widget.user.companysector,
        "conference_id": widget.user.conferenceId,
        "country": widget.user.country,
        "email": widget.user.email,
        "facebook_id": widget.user.facebookId,
        "firstname": widget.user.firstname,
        "instagram_id": widget.user.instagramId,
        "loginstatus": widget.user.loginstatus,
        "moderator_yn": widget.user.moderatorYn,
        "organisation": widget.user.organisation,
        "participant_type": widget.user.participantType,
        "password": widget.password,
        "phone": widget.user.phone,
        "pic_id": widget.user.picId,
        "short_profile": _shortProfile,
        "speaker_yn": widget.user.speaker,
        "surname": widget.user.surname,
        "title": widget.user.title,
        "twitter_id": widget.user.twitterId,
        "userinfoid": widget.user.id,
        "username": widget.user.username,
        "website": widget.user.website,
        "work_position": widget.user.workPosition,
      },
          options: Options(
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              "accept": "application/json"
            },)
      );
      print(response.statusCode);

      Navigator.pop(context, (response.statusCode == 200 || response.statusCode == 401));

      if (response.statusCode == 401)
      {
        Fluttertoast.showToast(
            msg: "Oops, something went wrong, try again.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );
//            Toast.show("Oops, something went wrong, try again.", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      }
      else
      {
        Fluttertoast.showToast(
            msg: "Profile updated successfully, please wait",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );

        Future.delayed (Duration(seconds: 3),
                () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EditProfile(data: widget.data, password: widget.password,))
              );
            }
        );
      }
    }
  }

  void _showDialogTwo (BuildContext context)
  {
    var alertDialog = AlertDialog(
//      title: new Text('Downloading'),
      contentPadding: EdgeInsets.all(0.0),
      backgroundColor: Colors.transparent,
      content: Container(
        height: 120.0,
        width: 200.0,
        child: Card(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(
                height: 10.0,
              ),
              Text ('Updating',
                style: new TextStyle (
                    color: Colors.white
                ),
              )
            ],
          ),
        ),
      ),
//      ),
//      actions: <Widget>[
//
//      ],
    );

    showDialog(
        context: global.currentContext,
        builder: (BuildContext context) {
//       if (progressString != '100%') {
          return alertDialog;

//       }
        },
        barrierDismissible: false
    );


  }
}