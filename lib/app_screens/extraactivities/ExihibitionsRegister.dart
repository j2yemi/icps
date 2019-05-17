import 'package:flutter/material.dart';
import 'package:icps/Constants.dart';
import 'package:icps/app_screens/Register.dart';
import 'package:icps/app_screens/drawer/Login.dart';

import 'package:icps/app_screens/popupMenu/Dashboard.dart';
import 'package:icps/app_screens/popupMenu/EditProfile.dart';
import 'package:icps/app_screens/popupMenu/Settings.dart';

import 'package:dio/dio.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExhibitionsRegister extends StatefulWidget {

  Data data;

  ExhibitionsRegister({this.data});

  @override
  _ExhibitionsRegisterState createState() => _ExhibitionsRegisterState();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
  signedInSpeaker
}

class _ExhibitionsRegisterState extends State<ExhibitionsRegister> {

  AuthStatus _authStatus = AuthStatus.notSignedIn;

  final formKey = new GlobalKey<FormState>();

  String progressString = '';

  final global = GlobalKey();

  String filePath;
  String fileName = '';

  final TextEditingController _titleFilter = new TextEditingController();
  final TextEditingController _emailFilter = new TextEditingController();
  final TextEditingController _websiteFilter = new TextEditingController();
  final TextEditingController _descriptionFilter = new TextEditingController();

  String _title = "";
  String _email = "";
  String _website = "";
  String _description = "";

  ExhibitionsRegister()
  {
    _titleFilter.addListener(_titleListen);;
    _emailFilter.addListener(_emailListen);
    _websiteFilter.addListener(_websiteListen);
    _descriptionFilter.addListener(_descriptionListen);
  }

  void _titleListen() {
    if (_titleFilter.text.isEmpty) {
      _title = "";
    } else {
      _title = _titleFilter.text;
    }
  }

  void _emailListen() {
    if (_emailFilter.text.isEmpty) {
      _email = "";
    } else {
      _email = _emailFilter.text;
    }
  }

  void _websiteListen() {
    if (_websiteFilter.text.isEmpty) {
      _website = "";
    } else {
      _website = _websiteFilter.text;
    }
  }

  void _descriptionListen() {
    if (_descriptionFilter.text.isEmpty) {
      _description = "";
    } else {
      _description = _descriptionFilter.text;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.data = widget.data ?? Data();

    _authStatus = ((widget.data.surname == '')) ? AuthStatus.notSignedIn : (widget.data.speaker && widget.data.surname != '') ? AuthStatus.signedInSpeaker : AuthStatus.signedIn;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      key: global,
      appBar: new AppBar (
        backgroundColor: Color.fromRGBO (152, 160, 87, 1),
        title: new Text ("Register for Exhibitions"),
        actions: <Widget> [
//          IconButton (icon: Icon (
//              Icons.search
//          ),
//            onPressed: () {
//              Navigator.pop (context);
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
        child: Column(
          children: <Widget>[
            new Container(
                padding: new EdgeInsets.only(top: 13.0),
                child: new Center(
                  child: Column(
                    children: <Widget>[
                      new Form(
                        key: formKey,
                        child: new Column(
                          children: <Widget>[
                            new Container(
                              margin: new EdgeInsets.all(10.0),
                              child: new TextFormField(
                                controller: _titleFilter,
                                decoration: new InputDecoration(
                                    labelText: 'Organisation Name',
                                    prefixIcon: Padding(
                                        padding: EdgeInsets.all(0.0),
                                        child: Icon(
                                          Icons.business_center,
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
                                validator: (value) => value.isEmpty ? 'Organisation Name can\'t be empty' : null,
                                onSaved: (value) => _title = value,
                              ),
                            ),
//                            new Container(
//                                child: new Column (
//                                    crossAxisAlignment: CrossAxisAlignment.start,
//                                    children: <Widget> [
////                              new Container(
////                                margin: new EdgeInsets.only(top: 15.0, left: 20.0),
////                                child: new Text('Title',
////                                  style: new TextStyle(
////                                      fontSize: 16.0
////                                  ),
////                                ),
////                              ),
//                                      new Container(
//                                        margin: new EdgeInsets.all(10.0),
//                                        width: MediaQuery.of(context).size.width,
//                                        child: new InputDecorator(
//                                            decoration: InputDecoration(
//                                                labelText: 'Choose Category',
//                                                prefixIcon: Padding(
//                                                    padding: EdgeInsets.all(0.0),
//                                                    child: Icon(
//                                                      Icons.star,
//                                                      color: Colors.grey,
//                                                    )
//                                                )
//                                            ),
////                                    alignedDropdown: true,
//                                            child: DropdownButtonHideUnderline(
////                                        child: new Container(
////                                          decoration: ShapeDecoration(
////                                            shape: RoundedRectangleBorder(
////                                              side: BorderSide(
////                                                  width: 1.0,
////                                                  style: BorderStyle.solid
////                                              ),
////                                              borderRadius: BorderRadius.all(
////                                                  Radius.circular(5.0)
////                                              ),
////                                            ),
////                                          ),
//                                              child: DropdownButton<String>(
//                                                isExpanded: true,
//                                                isDense: true,
//                                                hint: new Text('Choose Category*'),
//                                                items: _category.map((String dropDownStringItem) {
//                                                  return DropdownMenuItem<String> (
//                                                    value: dropDownStringItem,
//                                                    child: Text(dropDownStringItem),
//                                                  );
//                                                }).toList(),
//                                                onChanged: (String newValueSelected) {
//                                                  _onDropDownCategorySelected (newValueSelected);
//                                                },
//                                                value: _currentCategorySelected,
//                                              ),
//                                            )
//                                        ),
////                                  )
//                                      ),
//                                    ]
//                                )
//                            ),
                            new Container(
                              margin: new EdgeInsets.all(10.0),
                              child: new TextFormField(
                                controller: _emailFilter,
                                decoration: new InputDecoration(
                                    labelText: 'Contact Email',
                                    prefixIcon: Padding(
                                        padding: EdgeInsets.all(0.0),
                                        child: Icon(
                                          Icons.email,
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
                                validator: (value) => value.isEmpty ? 'Contact Email can\'t be empty' : null,
                                onSaved: (value) => _email = value,
                              ),
                            ),
                            new Container(
                              margin: new EdgeInsets.all(10.0),
                              child: new TextFormField(
                                controller: _websiteFilter,
                                decoration: new InputDecoration(
                                    labelText: 'Website',
                                    prefixIcon: Padding(
                                        padding: EdgeInsets.all(0.0),
                                        child: Icon(
                                          Icons.web,
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
                                validator: (value) => value.isEmpty ? 'Website can\'t be empty' : null,
                                onSaved: (value) => _website = value,
                              ),
                            ),
                            new Container(
                              margin: new EdgeInsets.all(10.0),
                              child: new TextFormField(
                                maxLines: null,
                                keyboardType: TextInputType.multiline,
                                controller: _descriptionFilter,
                                decoration: new InputDecoration(
                                    labelText: 'Short Description',
                                    prefixIcon: Padding(
                                        padding: EdgeInsets.all(0.0),
                                        child: Icon(
                                          Icons.description,
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
//                  validator: (value) => value.isEmpty ? 'Presentation Title can\'t be empty' : null,

                                validator: (value) => value.isEmpty ? 'Short Description can\'t be empty' : null,
                                onSaved: (value) => _description = value,
                              ),
                            ),
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
                                  child: new Text('Add Exhibition',
                                    style: new TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0
                                    ),
                                  ),
                                  onPressed: () {
//                                    _showDialog(context);
//                                    uploadFileFromDio(context);
                                    addExhibition(context);
                                  }
                              ),
                            ),
                          ],
                        ),
                      ),
//                      new Container(
//                        child: new Icon(
//                            Icons.card_membership,
//                            size: 73.0,
//                            color: Colors.grey
//                        ),
//                      ),
//                      new Container(
//                        child: new Text('Register for Exhibitions',
//                          style: new TextStyle(
//                              color: Colors.grey,
//                              fontSize: 20.0
//                          ),
//                        ),
//                      ),
//                      new Container(
//                        padding: new EdgeInsets.only(top: 13.0, left: 64.0, right: 64.0),
//                        child: new Text('Log in to join the exhibition list.',
//                          style: new TextStyle(
//                              color: Colors.grey,
//                              fontSize: 18.0
//                          ),
//                        ),
//                      ),
//                      new Container(
//                        margin: new EdgeInsets.only(top: 23.0),
//                        color: Color.fromRGBO(152, 160, 87, 1),
//                        child: new FlatButton(
//                            onPressed: null,
//                            child: new Text('JOIN EXHIBITIONS LIST',
//                              style: new TextStyle(
//                                  color: Colors.white
//                              ),
//                            )
//                        ),
//                      )
                    ],
                  ),
                )
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

  addExhibition(BuildContext context) async {
    if (validateAndSave()) {

      _showDialogTwo(context);

      var dio = new Dio();
//    File photoFile = new File('/Users/damilola/Sync/suit2.jpg');

      File pFile = new File(filePath);

      dio.options.connectTimeout = 50000; //5s
      dio.options.receiveTimeout = 50000;
      //dio.options.headers = <Header Json>;
      FormData formData = new FormData();
      formData.add("userinfoid", widget.data.id);
      formData.add("description", _description);
      formData.add("title", _title);
      formData.add("website", _website);
      formData.add("email", _email);

      if (pFile != null &&
          pFile.path != null &&
          pFile.path.isNotEmpty) {
        // Create a FormData
        String fileName = basename(pFile.path);
        print("File Name : $fileName");
        print("File Size : ${pFile.lengthSync()}");
        formData.add("file", new UploadFileInfo(pFile, fileName));
      }
      var response = await dio.post("http://icps19.com:6060/icps/icps/19/exh/",
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
            msg: "Registration successful",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
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


//  void choiceAction (String choice)
//  {
//    if (choice == Constants.Dashboard){
//      Navigator.push(context,
//          MaterialPageRoute(builder: (context) => Dashboard())
//      );
//    }
//    else if (choice == Constants.EditProfile){
//      if (_authStatus == AuthStatus.notSignedIn)
//      {
//        _showDialog(context);
//      }
//      else
//      {
//        Navigator.push(context,
//            MaterialPageRoute(builder: (context) => EditProfile())
//        );
//      }
//    }
//    else if (choice == Constants.Settings){
//      Navigator.push(context,
//          MaterialPageRoute(builder: (context) => Settings())
//      );
//    }
//  }

  void _showDialog (BuildContext context)
  {
    var alertDialog = AlertDialog(
      title: new Text('Login'),
      content: new Text('You are not Logged in'),
      actions: <Widget>[
        new FlatButton(
          child: new Text('Login'),
          onPressed: () {
            Navigator.push (context, MaterialPageRoute(builder: (context) => Login()));
          },
        ),
        new FlatButton(
          child: new Text('Register'),
          onPressed: () {
            Navigator.push (context, MaterialPageRoute(builder: (context) => Register()));
          },
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
//       if (progressString != '100%') {
        return alertDialog;

//       }
      },
//        barrierDismissible: false
    );
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
              Text ('Registering for Exhibition',
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
