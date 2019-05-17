import 'package:flutter/material.dart';
import 'package:icps/app_screens/drawer/Login.dart';

import 'package:dio/dio.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UploadPresentation extends StatefulWidget {

  Data data;

  UploadPresentation(this.data);

  @override
  _UploadPresentationState createState() => _UploadPresentationState();
}

class _UploadPresentationState extends State<UploadPresentation> {

  // Single file path
//  String filePath;
//  String _extension;
//  FileType _pickingType;

  final formKey = new GlobalKey<FormState>();

  String progressString = '';

  final global = GlobalKey();

  String filePath;
  String fileName = '';


  final TextEditingController _pTitleFilter = new TextEditingController();
  final TextEditingController _pSubtitleFilter = new TextEditingController();
  final TextEditingController _pDescriptionFilter = new TextEditingController();


  String _pTitle = "";
  String _pSubtitle = "";
  String _pDescription = "";

  UploadPresentation()
  {
    _pTitleFilter.addListener(_pTitleListen);
    _pSubtitleFilter.addListener(_pSubtitleListen);
    _pDescriptionFilter.addListener(_pDescriptionListen);
  }

  void _pTitleListen() {
    if (_pTitleFilter.text.isEmpty) {
      _pTitle = "";
    } else {
      _pTitle = _pTitleFilter.text;
    }
  }

  void _pSubtitleListen() {
    if (_pSubtitleFilter.text.isEmpty) {
      _pSubtitle = "";
    } else {
      _pSubtitle = _pSubtitleFilter.text;
    }
  }

  void _pDescriptionListen() {
    if (_pDescriptionFilter.text.isEmpty) {
      _pDescription = "";
    } else {
      _pDescription = _pDescriptionFilter.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance =
    ScreenUtil(width: 750, height: 1334, allowFontScaling: true)
      ..init(context);
    return Scaffold(
      key: global,
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(152, 160, 87, 1),
        title: new Text("Upload Presentation"),
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
        ],
      ),
      body: new SingleChildScrollView(
        child: new Container(
          child: new Column(
            children: <Widget>[
              new Container(
                margin: new EdgeInsets.all(10.0),
                padding: new EdgeInsets.all(15.0),
                width: MediaQuery.of(context).size.width,
                height: 100.0,
                decoration: new BoxDecoration(
                  color: Color.fromRGBO(180, 188, 151, 1),
                  image: new DecorationImage(
                    image: new AssetImage(
                        'assets/images/logo/icpslogo.png'
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              new Container(
                padding: new EdgeInsets.all(10.0),
                child: new Text(
                  'Upload your presentation document - ICPS 2019',
                  style: new TextStyle(
                      color: Color.fromRGBO(25, 110, 42, 1),
                      fontSize: 20.0
                  ),
                ),
              ),
              new Container(
                child: new Form(
                  key: formKey,
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        margin: new EdgeInsets.all(10.0),
                        child: new TextFormField(
                          controller: _pTitleFilter,
                          decoration: new InputDecoration(
                              labelText: 'Presentation Title',
                              prefixIcon: Padding(
                                  padding: EdgeInsets.all(0.0),
                                  child: Icon(
                                    Icons.title,
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
                          validator: (value) => value.isEmpty ? 'Presentation Title can\'t be empty' : null,
                          onSaved: (value) => _pTitle = value,
                        ),
                      ),
                      new Container(
                        margin: new EdgeInsets.all(10.0),
                        child: new TextFormField(
                          controller: _pSubtitleFilter,
                          decoration: new InputDecoration(
                              labelText: 'Presentation Subtitle',
                              prefixIcon: Padding(
                                  padding: EdgeInsets.all(0.0),
                                  child: Icon(
                                    Icons.subtitles,
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
                          onSaved: (value) => _pSubtitle = value,
                        ),
                      ),
                      new Container(
                        margin: new EdgeInsets.all(10.0),
                        child: new TextFormField(
                          controller: _pDescriptionFilter,
                          decoration: new InputDecoration(
                              labelText: 'Presentation Description',
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
                          onSaved: (value) => _pDescription = value,
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
                          child: new Text('Upload Papers / Publications',
                            style: new TextStyle(
                                color: Colors.white,
                                fontSize: 16.0
                            ),
                          ),
                          onPressed: () {
                            uploadFileFromDio(context);
                          },
                        ),
                      ),
                    ],
                  )
                ),
              )
            ],
          ),
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

      _showDialogTwo(context);

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
      formData.add("p_title", _pTitle);
      formData.add("p_date", DateTime.now());
      formData.add("p_subtitle", _pSubtitle);
      formData.add("p_desc", _pDescription);

      if (pFile != null &&
          pFile.path != null &&
          pFile.path.isNotEmpty) {
        // Create a FormData
        String fileName = basename(pFile.path);
        print("File Name : $fileName");
        print("File Size : ${pFile.lengthSync()}");
        formData.add("file", new UploadFileInfo(pFile, fileName));
      }
      var response = await dio.post("http://icps19.com:6060/icps/icps/19/spr/",
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
            msg: "Upload successful",
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
      print((received / total * 100).toStringAsFixed(0) + "%");
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
              Text ('Uploading File',
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
