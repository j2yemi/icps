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

class PartnerRegister extends StatefulWidget {

  Data data;

  PartnerRegister({this.data});

  @override
  _PartnerRegisterState createState() => _PartnerRegisterState();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
  signedInSpeaker
}

class _PartnerRegisterState extends State<PartnerRegister> {

  AuthStatus _authStatus = AuthStatus.notSignedIn;

  final formKey = new GlobalKey<FormState>();

  String progressString = '';

  final global = GlobalKey();

  String filePath;
  String fileName = '';

  final TextEditingController _nameFilter = new TextEditingController();
  final TextEditingController _contactFilter = new TextEditingController();
  final TextEditingController _emailFilter = new TextEditingController();
  final TextEditingController _websiteFilter = new TextEditingController();
  final TextEditingController _briefProfileFilter = new TextEditingController();
  final TextEditingController _textFilter = new TextEditingController();

  String _name = "";
  String _contact = "";
  String _email = "";
  String _website = "";
  String _briefProfile = "";
  String _text = "";
  var _currentCategorySelected = 'Platinum';

  var _category = ['Platinum', 'Diamond', 'Gold', 'Silver'];

  PartnerRegister()
  {
    _nameFilter.addListener(_nameListen);
    _contactFilter.addListener(_contactListen);
    _emailFilter.addListener(_emailListen);
    _websiteFilter.addListener(_websiteListen);
    _briefProfileFilter.addListener(_briefProfileListen);
    _textFilter.addListener(_textListen);
  }

  void _nameListen() {
    if (_nameFilter.text.isEmpty) {
      _name = "";
    } else {
      _name = _nameFilter.text;
    }
  }

  void _contactListen() {
    if (_contactFilter.text.isEmpty) {
      _contact = "";
    } else {
      _contact = _contactFilter.text;
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

  void _briefProfileListen() {
    if (_briefProfileFilter.text.isEmpty) {
      _briefProfile = "";
    } else {
      _briefProfile = _briefProfileFilter.text;
    }
  }

  void _textListen() {
    if (_textFilter.text.isEmpty) {
      _text = "";
    } else {
      _text = _textFilter.text;
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
    ScreenUtil.instance =
    ScreenUtil(width: 750, height: 1334, allowFontScaling: true)
      ..init(context);
    return Scaffold(
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
      body: SingleChildScrollView(
        child: new Column(
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
                                controller: _nameFilter,
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
                                onSaved: (value) => _name = value,
                              ),
                            ),
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
                                                labelText: 'Choose Category',
                                                prefixIcon: Padding(
                                                    padding: EdgeInsets.all(0.0),
                                                    child: Icon(
                                                      Icons.star,
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
                                                hint: new Text('Choose Category*'),
                                                items: _category.map((String dropDownStringItem) {
                                                  return DropdownMenuItem<String> (
                                                    value: dropDownStringItem,
                                                    child: Text(dropDownStringItem),
                                                  );
                                                }).toList(),
                                                onChanged: (String newValueSelected) {
                                                  _onDropDownCategorySelected (newValueSelected);
                                                },
                                                value: _currentCategorySelected,
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
                                controller: _contactFilter,
                                decoration: new InputDecoration(
                                    labelText: 'Contact Address',
                                    prefixIcon: Padding(
                                        padding: EdgeInsets.all(0.0),
                                        child: Icon(
                                          Icons.business,
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

                                validator: (value) => value.isEmpty ? 'Contact Address can\'t be empty' : null,
                                onSaved: (value) => _contact = value,
                              ),
                            ),
                            new Container(
                              margin: new EdgeInsets.all(10.0),
                              child: new TextFormField(
                                maxLines: null,
                                keyboardType: TextInputType.multiline,
                                controller: _briefProfileFilter,
                                decoration: new InputDecoration(
                                    labelText: 'Brief Profile',
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

                                validator: (value) => value.isEmpty ? 'Brief Profile can\'t be empty' : null,
                                onSaved: (value) => _briefProfile = value,
                              ),
                            ),
                            new Container(
                              margin: new EdgeInsets.all(10.0),
                              child: new TextFormField(
                                maxLines: null,
                                keyboardType: TextInputType.multiline,
                                controller: _textFilter,
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

//                                validator: (value) => value.isEmpty ? 'Text can\'t be empty' : null,
                                onSaved: (value) => _text = value,
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
                                  child: new Text('Add Partner',
                                    style: new TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0
                                    ),
                                  ),
                                  onPressed: () {
//                                    _showDialog(context);
//                                    uploadFileFromDio(context);
                                    addPartners(context);
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

  addPartners(BuildContext context) async {
    if (validateAndSave()) {

      _showDialogTwo(context);

      var dio = new Dio();
//    File photoFile = new File('/Users/damilola/Sync/suit2.jpg');

      File pFile = new File(filePath);

      dio.options.connectTimeout = 50000; //5s
      dio.options.receiveTimeout = 50000;
      //dio.options.headers = <Header Json>;
      FormData formData = new FormData();
      formData.add("partnercategory", _currentCategorySelected);
      formData.add("userinfoid", widget.data.id);
      formData.add("name", _name);
      formData.add("contact", _contact);
      formData.add("brief_profile", _briefProfile);
      formData.add("text", _text);
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
      var response = await dio.post("http://icps19.com:6060/icps/icps/19/pat/",
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

  void _onDropDownCategorySelected (String newValueSelected)
  {
    setState(() {
      this._currentCategorySelected = newValueSelected;
    });
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
              Text ('Registering for Partnership',
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
