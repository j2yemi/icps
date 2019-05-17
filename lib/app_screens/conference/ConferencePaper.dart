import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:icps/app_screens/Conference.dart';
import 'package:icps/DownloadFilesJson.dart';
import 'package:icps/Constants.dart';
import 'package:icps/app_screens/Register.dart';
import 'package:icps/app_screens/drawer/Login.dart';

import 'package:icps/app_screens/popupMenu/Dashboard.dart';
import 'package:icps/app_screens/popupMenu/EditProfile.dart';
import 'package:icps/app_screens/popupMenu/Settings.dart';

import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';
//import 'package:path_provider/path_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:simple_permissions/simple_permissions.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:open_file/open_file.dart';

class ConferencePaper extends StatefulWidget {
  Data data; String password;

  ConferencePaper({this.data, this.password});

  @override
  _ConferencePaperState createState() => _ConferencePaperState ();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
  signedInSpeaker
}

class _ConferencePaperState extends State<ConferencePaper> {

  AuthStatus _authStatus = AuthStatus.notSignedIn;

  String progressString = '';

//  GlobalKey _scaffold = Global Key();
  final global = GlobalKey();

  String url = 'http://icps19.com:6060/icps/resources/conferencepresentations/profilepics/';

  Future <List<SpeakerPresentation>> _getPresentation() async
  {
    String getUrl = 'http://icps19.com:6060/icps/i/icps/19/spp';

//    Response response;
//    Dio dio = new Dio();
//
//    response = await dio.get(getUrl);

    var data = await http.get(getUrl);

    var jsonData = data.body;
    print(jsonData);

//    var conferenceAgendaJson = ConferenceAgenda.fromJson(response.data);

//    DateTime date = DateTime (conferenceAgendaJson.conferenceDate);

//    print(date);

    List <SpeakerPresentation> speakerPresentation = speakerPresentationFromJson(jsonData);

    List <SpeakerPresentation> presentation = [];

//    ConferenceAgenda conferenceAgendaVar;

    try
    {
//      Response response;
//      Dio dio = new Dio();
//
//      response = await dio.get(getUrl);
//      if (conferenceAgenda.isEmpty) {
      for (SpeakerPresentation ss in speakerPresentation) {
//        DateTime date = DateTime.fromMillisecondsSinceEpoch(
//            ss.conferenceDate);

//        String formatedDate = DateFormat('EEEE, MMM d, ''yyyy').format(date);
//        String day = DateFormat('d').format(date);

        //        conferenceAgendaVar = conferenceAgendaVar ?? ConferenceAgenda(
        //          anchor: 0,
        //          conferenceDate: 0,
        //          description: '',
        //          id: 0,
        //          subtitle: '',
        //          timeEnd: '',
        //          timeStart: '',
        //          title: '',
        //        );

//        print('Day: $day');
//        if (day == '4') {
          SpeakerPresentation speakerPresentation = SpeakerPresentation(
              id: ss.id,
              pDate: ss.pDate,
              pDesc: ss.pDesc,
              pFileId: ss.pFileId,
              pFileName: ss.pFileName,
              pSubtitle: ss.pSubtitle,
              pTitle: ss.pTitle,
              userinfoid: ss.userinfoid,
              usersInfo: ss.usersInfo);

          presentation.add(speakerPresentation);
//        }
//        //        tuesAgenda.add(conferenceAgendaVar);
      }
//      }
    }
    catch (e) {
      print('Error: $e');
    }
    print(presentation.length);

    presentation..sort((a, b) => b.id.compareTo(a.id));

    return presentation;
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
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(152, 160, 87, 1),
        title: new Text("Papers/Publications"),
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
          PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return Constants.choices.map((String choice){
                return PopupMenuItem<String>(
                  value: choice,
                  child: new Text(choice),
                );
              }).toList();
            },
          ),
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
                  'Conference Papers - ICPS 2019',
                  style: new TextStyle(
                      color: Color.fromRGBO(25, 110, 42, 1),
                      fontSize: 20.0
                  ),
                ),
              ),
                new Container(
                  margin: new EdgeInsets.only(top: 23.0),
                  child: FutureBuilder
                  (
                    future: _getPresentation(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {

                      if (snapshot.data == null) {
                        return new Container(
                          padding: new EdgeInsets.only(top: 55.0),
                          child: new Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      else if (snapshot.data.length == 0) {
                        return new Center(
                            child: new Container(
                              padding: new EdgeInsets.only(top: 35.0),
                              child: new Text('No Conference Paper here yet',
                                style: new TextStyle(
                                  fontSize: ScreenUtil(
                                      allowFontScaling: true)
                                      .setSp(31),
                                ),
                              ),
                            )
                        );
                      }
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
//                            return ListTile (
//                              leading: Text(snapshot.data[index].usersInfo.title + ' ' +
//                                  snapshot.data[index].usersInfo.surname + ' ' + snapshot.data[index].usersInfo.firstname),
//                              title: Text (snapshot.data[index].pTitle),
//                              subtitle: Text(snapshot.data[index].pSubtitle),
                            return GestureDetector(
                              child: new Container(
                                margin: new EdgeInsets.only(left: 43.0, bottom: 23.0, right: 43.0),
                                decoration: new BoxDecoration(
                                  border: new Border(
                                    bottom: new BorderSide(
                                      width: 1.0,
                                      color: Colors.grey,
                                    )
                                  )
                                ),
                                child: new Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Container(
                                      padding: new EdgeInsets.only(right: 20.0),
                                      child: snapshot.data[index].usersInfo.picId == null
                                          ? new CircleAvatar(
                                        child: new Text('${snapshot.data[index].usersInfo.surname.substring(0, 1)}'
                                            '${snapshot.data[index].usersInfo.firstname.substring(0, 1)}'
                                        ),
                                      )
                                          : CircleAvatar(
                                        backgroundImage: NetworkImage(url + snapshot.data[index].usersInfo.picId),
                                        backgroundColor: Colors.transparent,
                                      ),
                                    ),
                                    new Container(
                                      width: ScreenUtil.getInstance().setWidth(398),
                                      child: new Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          new Container (
                                            child: new Text (snapshot.data[index].usersInfo.title + ' ' +
                                              snapshot.data[index].usersInfo.firstname + ' ' + snapshot.data[index].usersInfo.surname,
                                              style: new TextStyle (
                                                fontSize: ScreenUtil(allowFontScaling: true)
                                                    .setSp(36),
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                          new Container(
                                            width: ScreenUtil.getInstance().setWidth(410),
                                            margin: new EdgeInsets.only(top: 6.0, bottom: 6.0),
                                            child: new Text(snapshot.data[index].pTitle,
                                              style: new TextStyle (
                                                  fontSize: ScreenUtil(allowFontScaling: true)
                                                      .setSp(31),
                                              ),
                                            ),
                                          ),
                                          new Container(
                                            width: ScreenUtil.getInstance().setWidth(410),
                                            child: new Text (snapshot.data[index].pSubtitle),
                                          ),
//                                          new Divider (color: Colors.blue,)
                                          new SizedBox(
                                            height: 20.0,
                                          )
                                        ],
                                      ),
                                    ),
                                    new Container(
                                      margin: new EdgeInsets.only(right: 13.0),
                                      child:  new Icon(Icons.file_download,
                                        size: 34.0,
                                        color: Color.fromRGBO(180, 188, 151, 1),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () async {

                                _showDialog(context);

//                                Navigator.pop(context, progressString == '100%');

                                var dio = new Dio();
                                dio.interceptors.add(LogInterceptor());
                                // This is big file(about 200M)
                                var url = 'http://icps19.com:6060/icps/resources/conferencepresentations/' + snapshot.data[index].pFileId;
//                                var dir = await getExternalStorageDirectory();
                                var dir = await DownloadsPathProvider.downloadsDirectory;

                                await PermissionHandler().requestPermissions([PermissionGroup.storage]);

                                await download1(dio, url, dir.path + '/' + snapshot.data[index].pFileName);

                                Navigator.pop(context, progressString == '100%');

                                Future.delayed (Duration(seconds: 2),
                                        () async {
                                      Fluttertoast.showToast(
                                          msg: "Opening " + snapshot.data[index].pFileName + " from" + dir.path + "/" + snapshot.data[index].pFileName,
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIos: 6,
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                          fontSize: 16.0
                                      );

                                      Future.delayed (Duration(seconds: 2),
                                      () async {
                                          OpenFile.open(dir.path + '/' +
                                              snapshot.data[index].pFileName);
                                        }
                                      );
                                    }
                                );

//                                await dio.download(url, snapshot.data[index].pFileId);

//                                String url = 'http://icps19.com:6060/icps/i/icps/19/spp/';
//                                String filename = snapshot.data[index].pFileName;
//                                http.Client client = new http.Client();
//                                var req = await client.get(Uri.parse(url));
//                                var bytes = req.bodyBytes;
//                                String dir = (await getApplicationDocumentsDirectory()).path;
//                                File file = new File('$dir/$filename');
//                                await file.writeAsBytes(bytes);
//                                return file;
                              },
                            );
                          }
                      );
                    }
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  Future download1(Dio dio, String url, savePath) async {
    try {
      await dio.download(
        url,
        savePath,
        onReceiveProgress: showDownloadProgress,
      );

//      if (progressString == '100%')
//      {
//        Navigator.pop(context);
//      }

    } catch (e) {
      print(e);
    }
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      setState(() {
        progressString = (received / total * 100).toStringAsFixed(0) + "%";
      });
//      progressString = progressString;
      print((received / total * 100).toStringAsFixed(0) + "%");
    }
  }

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
                Text ('Downloading File',
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

  void choiceAction (String choice)
  {
    if (choice == Constants.Dashboard){
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Dashboard(data: widget.data, password: widget.password))
      );
    }
    else if (choice == Constants.EditProfile){
      if (_authStatus == AuthStatus.notSignedIn)
      {
        _showDialogTwo(context);
      }
      else
      {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => EditProfile(data: widget.data, password: widget.password,))
        );
      }
    }
    else if (choice == Constants.Settings){
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Settings(data: widget.data, password: widget.password,))
      );
    }
  }

  void _showDialogTwo (BuildContext context)
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
}
