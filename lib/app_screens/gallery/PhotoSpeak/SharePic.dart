import 'package:flutter/material.dart';
import 'package:icps/Constants.dart';
import 'package:icps/app_screens/Register.dart';
import 'package:icps/app_screens/drawer/Login.dart';

import 'package:icps/app_screens/popupMenu/Dashboard.dart';
import 'package:icps/app_screens/popupMenu/EditProfile.dart';
import 'package:icps/app_screens/popupMenu/Settings.dart';

import 'package:dio/dio.dart';
import 'package:icps/app_screens/gallery/PhotoSpeak.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:multi_image_picker/multi_image_picker.dart';
//import 'package:image_picker/image_picker.dart';

class SharePic extends StatefulWidget {

  Data data;

  SharePic({this.data});

  @override
  _SharePicState createState() => _SharePicState();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
  signedInSpeaker
}

class _SharePicState extends State<SharePic> {

  AuthStatus _authStatus = AuthStatus.notSignedIn;

  String filePath;
  String fileName = '';


  final TextEditingController _descriptionFilter = new TextEditingController();

  final formKey = new GlobalKey<FormState>();

  String progressString = '';

  File _image;

  String _description = "";

  final global = GlobalKey();

  SharePic() {
    _descriptionFilter.addListener(_descriptionListen);
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
        title: new Text("Share Pic"),
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
              margin: new EdgeInsets.only(top: 20.0, bottom: 20.0, left: 15.0, right: 15.0),
              child: new Form (
                key: formKey,
                child: new Column(
                  children: <Widget>[
                    new Container(
                      margin: new EdgeInsets.only(bottom: 15.0),
                      child: new TextFormField(
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
//                      textInputAction: TextInputAction.done,
//                      focusNode: _messageFocus,
                        controller: _descriptionFilter,
                        decoration: new InputDecoration(
                            labelText: 'Description',
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
                        validator: (value) => value.isEmpty ? 'Description can\'t be empty' : null,
                        onSaved: (value) => _description = value,
//                        autovalidate: _validate,
//                      onFieldSubmitted: (term){
//                        _messageFocus.unfocus();
//                        validateAndSubmit();
//                      },
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
                                  filePath = await FilePicker.getFilePath(type: FileType.IMAGE);
                                  File pFile = new File(filePath);
                                  setState(() {
                                    fileName = basename(pFile.path);
                                  });
//                                  print(fileName);
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
                          child: new Text('Upload Photo',
                            style: new TextStyle(
                                color: Colors.white,
                                fontSize: 16.0
                            ),
                          ),
                          onPressed: () {
                            _showDialog(context);
                            uploadFileFromDio(context);
                          }
                      ),
                    ),
                  ],
                ),
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

  uploadFileFromDio(BuildContext context) async {
    if (validateAndSave()) {
      var dio = new Dio();
//    File pFile = new File(file);
//    filePath = await FilePicker.getFilePath(type: FileType.ANY); // will let you pick one file path, from all extensions
      File pFile = new File(filePath);
      // dio.options.baseUrl = 'http://icps19.com:6060/icps/resources/conferencepresentations/';
      dio.options.connectTimeout = 50000; //5s
      dio.options.receiveTimeout = 50000;
      //dio.options.headers = <Header Json>;
      FormData formData = new FormData();
      formData.add("userinfoid", widget.data.id);
      formData.add("text", _description);

      if (pFile != null &&
          pFile.path != null &&
          pFile.path.isNotEmpty) {
        // Create a FormData
        String fileName = basename(pFile.path);
        print("File Name : $fileName");
        print("File Size : ${pFile.lengthSync()}");
        formData.add("file", new UploadFileInfo(pFile, fileName));
      }
      var response = await dio.post("http://icps19.com:6060/icps/icps/19/shm/",
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
            msg: "Upload Complete",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PhotoSpeak())
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
//        _showDialogTwo(context);
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
//
//  void _showDialogTwo (BuildContext context)
//  {
//    var alertDialog = AlertDialog(
//      title: new Text('Login'),
//      content: new Text('You are not Logged in'),
//      actions: <Widget>[
//        new FlatButton(
//          child: new Text('Login'),
//          onPressed: () {
//            Navigator.push (context, MaterialPageRoute(builder: (context) => Login()));
//          },
//        ),
//        new FlatButton(
//          child: new Text('Register'),
//          onPressed: () {
//            Navigator.push (context, MaterialPageRoute(builder: (context) => Register()));
//          },
//        ),
//      ],
//    );
//
//    showDialog(
//      context: context,
//      builder: (BuildContext context) {
////       if (progressString != '100%') {
//        return alertDialog;
//
////       }
//      },
////        barrierDismissible: false
//    );
//  }

  void _showDialog (BuildContext context)
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
              Text ('Uploading Photo',
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
