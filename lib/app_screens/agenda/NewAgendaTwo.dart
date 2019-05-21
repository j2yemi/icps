import 'package:flutter/material.dart';
import 'package:icps/agendaJson.dart';
import 'package:icps/app_screens/ActivityFeed.dart';
import 'package:icps/Constants.dart';
import 'package:icps/app_screens/Register.dart';
import 'package:icps/app_screens/drawer/Login.dart';

import 'package:icps/app_screens/popupMenu/Dashboard.dart';
import 'package:icps/app_screens/popupMenu/EditProfile.dart';
import 'package:icps/app_screens/popupMenu/Settings.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:flutter_rating/flutter_rating.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';
//import 'dart:convert';
import 'package:http/http.dart' as http;
//import 'package:dio/dio.dart';
//import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';

void main() async{
  runApp(
      MaterialApp (
          home: NewAgendaTwo(),
          theme: ThemeData(
            fontFamily: 'Montserrat',
          )
      )
  );
}

class NewAgendaTwo extends StatefulWidget {
  Data data; String password;

  NewAgendaTwo({this.data, this.password});

  @override
  _NewAgendaTwoState createState() => _NewAgendaTwoState ();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
  signedInSpeaker
}

class _NewAgendaTwoState extends State<NewAgendaTwo> {

  ScrollController _controller = new ScrollController();

  ScrollController controller;

  AuthStatus _authStatus = AuthStatus.notSignedIn;

  String url = 'http://icps19.com:6060/icps/resources/conferencepresentations/profilepics/';

  Future <List<ConferenceAgenda>> _getWednesdayAgenda() async
  {
    String getUrl = 'http://icps19.com:6060/icps/i/icps/19/cfa';

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

    List <ConferenceAgenda> conferenceAgenda = conferenceAgendaFromJson(jsonData);

    List <ConferenceAgenda> wedAgenda = [];

//    ConferenceAgenda conferenceAgendaVar;

    try
    {
//      Response response;
//      Dio dio = new Dio();
//
//      response = await dio.get(getUrl);
//      if (conferenceAgenda.isEmpty) {
        for (ConferenceAgenda ss in conferenceAgenda) {

          ss.conferenceDate = '${ss.conferenceDate.substring(0, 10)} ${ss.conferenceDate.substring(11, 19)}';

          print(ss.conferenceDate);

          DateTime dated = DateTime.parse(ss.conferenceDate);

//          String formatedDate = DateFormat('EEEE, MMM d, ''yyyy').format(dated);
          String day = DateFormat('d').format(dated);

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

          print('Day: $day');
          if (day == '4') {
            ConferenceAgenda conferenceAgenda = ConferenceAgenda(
                anchor: ss.anchor,
                conferenceDate: ss.conferenceDate,
                description: ss.description,
                dresscode: ss.dresscode,
                id: ss.id,
                moderator: ss.moderator,
                paneldiscussants: ss.paneldiscussants,
                subtitle: ss.subtitle,
                timeEnd: ss.timeEnd,
                timeStart: ss.timeStart,
                title: ss.title,
                usersInfo: ss.usersInfo);

            wedAgenda.add(conferenceAgenda);
          }
          //        tuesAgenda.add(conferenceAgendaVar);
        }
//      }
    }
    catch (e) {
      print('Error: $e');
    }
    print(wedAgenda.length);
    return wedAgenda;
  }

  @override
  void initState() {
    super.initState();

    widget.data = widget.data ?? Data();

    _authStatus = ((widget.data.surname == '')) ? AuthStatus.notSignedIn : (widget.data.speaker && widget.data.surname != '') ? AuthStatus.signedInSpeaker : AuthStatus.signedIn;

//    _controller = _controller..addListener(_scrollListener);
  }

//  @override
//  void dispose() {
//    controller.removeListener(_scrollListener);
//    super.dispose();
//  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance =
    ScreenUtil(width: 750, height: 1334, allowFontScaling: true)
      ..init(context);
    return SingleChildScrollView(
        child: new Column(
            children: <Widget>[
              new Container(
                  child: new Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Container(
                          padding: new EdgeInsets.only(left: 25.0, top: 5.0, bottom: 5.0),
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          color: Color.fromRGBO(152, 160, 87, 1),
                          child: new Text('Wednesday, 4th September 2019',
                            style: new TextStyle(
                                color: Colors.white,
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        FutureBuilder
                          (
                            future: _getWednesdayAgenda(),
                            builder: (BuildContext context, AsyncSnapshot snapshot) {
//    String getUrl = 'http://icps19.com:6060/icps/i/icps/19/cfa';

                              if (snapshot.data == null)
                              {
                                return new Container(
                                  padding: new EdgeInsets.only(top: 225.0),
                                  child: new Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                              else if (snapshot.data.length == 0) {
                                return new Center(
                                    child: new Container(
                                      padding: new EdgeInsets.only(top: 35.0),
                                      child: new Text('No Agenda here yet',
                                        style: new TextStyle(
                                          fontSize: ScreenUtil(
                                              allowFontScaling: true)
                                              .setSp(31),
                                        ),
                                      ),
                                    )
                                );
                              }

//    try
//    {
//      Response response;
//      Dio dio = new Dio();
//
//      response = await dio.get(getUrl);
//
//      var conferenceAgenda = ConferenceAgenda.fromJson(response.data);
//
//      DateTime date = conferenceAgenda.conferenceDate;
//
//      String day = formatDate (date, [d]);
//
//      print ('Day: $day');
//
//      if (day == 'Tuesday')
//      {
//        conferenceAgenda(agenda)
//        {
//        return new Container(
//          padding: new EdgeInsets.only(bottom: 10.0),
//          decoration: new BoxDecoration(
//              border: new Border(
//                  bottom: new BorderSide(
//                    width: 1.0,
//                    style: BorderStyle.solid,
//                    color: Color.fromRGBO(192, 192, 192, 1),
//                  )
//              )
//          ),
//          child: new Column (
//            children: <Widget>[
//              new Container(
//                child: new Column (
//                  children: <Widget>[
//                    new Container(
//                      padding: new EdgeInsets.only(top: 10.0, left: 23.0),
//                      child: new Row(
//                        children: <Widget>[
//                          new Container(
//                            child: new Icon(Icons.mic,
//                              size: 34.0,
//                              color: Color.fromRGBO(180, 188, 151, 1),
//                            ),
//                          ),
//                          new Container(
//                            margin: new EdgeInsets.only(left: 59.0),
//                            width: ScreenUtil.getInstance().setWidth(500),
//                            child: new Text(snapshot.data.title,
//                              style: new TextStyle(
//                                  fontSize: ScreenUtil(allowFontScaling: true)
//                                      .setSp(38),
//                                  fontWeight: FontWeight.bold
//                              ),
//                            ),
//                          )
//                        ],
//                      ),
//                    ),
//                    new Container(
//                      padding: new EdgeInsets.only(left: 16.0, top: 10.0),
//                      child: new Row(
//                        children: <Widget>[
//                          new Container(
//                              width: ScreenUtil.getInstance().setWidth(183),
//                              child: new Column(
//                                crossAxisAlignment: CrossAxisAlignment.end,
//                                children: <Widget>[
//                                  new Text(snapshot.data.timeStart + ' - ' + snapshot.data.timeEnd,
//                                    style: new TextStyle(
//                                        fontSize: ScreenUtil(
//                                            allowFontScaling: true).setSp(29)
//                                    ),
//                                  ),
////                                          new Text('5 Sep')
//                                ],
//                              )
//                          ),
//                          new Container(
//                            width: ScreenUtil.getInstance().setWidth(380),
//                            padding: new EdgeInsets.only(left: 0.0),
//                            child: new Column(
//                              crossAxisAlignment: CrossAxisAlignment.start,
//                              children: <Widget>[
//                                new Text(snapshot.data.description,
//                                  style: new TextStyle(
//                                      fontSize: ScreenUtil(
//                                          allowFontScaling: true).setSp(31)
//                                  ),
//                                ),
////                                          new Text('Exhibit Hall C')
//                              ],
//                            ),
//                          ),
//                          new Container(
//                            margin: new EdgeInsets.only(left: 54.0),
//                            width: 7.0,
//                            height: 7.0,
//                            decoration: new BoxDecoration(
//                                color: Color.fromRGBO(117, 98, 40, 1),
//                                borderRadius: new BorderRadius.circular(70.0)
//                            ),
//                          )
//                        ],
//                      ),
//                    ),
////                              new Container(
////                                padding: new EdgeInsets.only(left: 16.0, top: 10.0),
////                                child: new Row(
////                                  children: <Widget>[
////                                    new Container(
////                                      child: new Column(
////                                        crossAxisAlignment: CrossAxisAlignment.end,
////                                        children: <Widget>[
////                                          new Text('11:00AM',
////                                            style: new TextStyle(
////                                                fontSize: 16.0
////                                            ),
////                                          ),
////                                          new Text('5 Sep')
////                                        ],
////                                      ),
////                                    )
////                                  ],
////                                ),
////                              )
//
//                  ],
//                ),
//              )
//            ],
//          ),
//        );
                              return ListView.builder(
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
//          physics: const AlwaysScrollableScrollPhysics(),
                                  controller: _controller,
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (BuildContext context, int index)
                                  {
                                    return new Container(
                                      padding: new EdgeInsets.only(bottom: 10.0),
                                      decoration: new BoxDecoration(
                                          border: new Border(
                                              bottom: new BorderSide(
                                                width: 1.0,
                                                style: BorderStyle.solid,
                                                color: Color.fromRGBO(192, 192, 192, 1),
                                              )
                                          )
                                      ),
                                      child: new GestureDetector(
                                        onTap: () {
                                          Navigator.push (context,
                                              MaterialPageRoute(builder: (context) => AgendaDetails(conferenceAgenda: snapshot.data[index], data: widget.data, password: widget.password))
                                          );
                                        },
                                        child: new Column (
                                          children: <Widget>[
                                            new Container(
                                              padding: new EdgeInsets.only(top: 10.0, left: 23.0),
                                              child: new Row(
                                                children: <Widget>[
                                                  new Container(
                                                    child: new Icon(Icons.mic,
                                                      size: 34.0,
                                                      color: Color.fromRGBO(180, 188, 151, 1),
                                                    ),
                                                  ),
                                                  new Container(
                                                    margin: new EdgeInsets.only(left: 59.0),
                                                    width: ScreenUtil.getInstance().setWidth(500),
                                                    child: new Text(snapshot.data[index].title,
                                                      style: new TextStyle(
                                                          fontSize: ScreenUtil(allowFontScaling: true)
                                                              .setSp(38),
                                                          fontWeight: FontWeight.bold
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            new Container(
                                              padding: new EdgeInsets.only(left: 16.0, top: 10.0),
                                              child: new Row(
                                                children: <Widget>[
                                                  new Container(
                                                      width: ScreenUtil.getInstance().setWidth(183),
                                                      child: new Column(
                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: <Widget>[
                                                          new Text(snapshot.data[index].timeStart + ' - ' + snapshot.data[index].timeEnd,
                                                            style: new TextStyle(
                                                                fontSize: ScreenUtil(
                                                                    allowFontScaling: true).setSp(29)
                                                            ),
                                                          ),
//                                          new Text('5 Sep')
                                                        ],
                                                      )
                                                  ),
                                                  new Container(
                                                    width: ScreenUtil.getInstance().setWidth(380),
                                                    padding: new EdgeInsets.only(left: 0.0),
                                                    child: new Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        new Text(snapshot.data[index].description,
                                                          style: new TextStyle(
                                                              fontSize: ScreenUtil(
                                                                  allowFontScaling: true).setSp(31)
                                                          ),
                                                        ),
//                                          new Text('Exhibit Hall C')
                                                      ],
                                                    ),
                                                  ),
//                                                      new Container(
//                                                        margin: new EdgeInsets.only(left: 54.0),
//                                                        width: 7.0,
//                                                        height: 7.0,
//                                                        decoration: new BoxDecoration(
//                                                            color: Color.fromRGBO(117, 98, 40, 1),
//                                                            borderRadius: new BorderRadius.circular(70.0)
//                                                        ),
//                                                      )
                                                  new Container(
                                                    margin: new EdgeInsets.only(left: 24.0),
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
                                                ],
                                              ),
                                            ),
//                              new Container(
//                                padding: new EdgeInsets.only(left: 16.0, top: 10.0),
//                                child: new Row(
//                                  children: <Widget>[
//                                    new Container(
//                                      child: new Column(
//                                        crossAxisAlignment: CrossAxisAlignment.end,
//                                        children: <Widget>[
//                                          new Text('11:00AM',
//                                            style: new TextStyle(
//                                                fontSize: 16.0
//                                            ),
//                                          ),
//                                          new Text('5 Sep')
//                                        ],
//                                      ),
//                                    )
//                                  ],
//                                ),
//                              )

                                          ],
                                        ),
                                      )
                                    );
                                  }

                              );
                            }
                        )
                      ]
                  )
              )
            ]
        )
    );
  }

  void _scrollListener() {
    print(controller.position.extentAfter);
    if (controller.position.extentAfter < 500) {
      setState(() {
        _getWednesdayAgenda();
      });
    }
  }
}
//
//                  ]
//              )
//          ),
//        ],
//      ),
//    );
//  }


//  FutureBuilder _TuesdayAgenda ()
//  (
//    future: _getTuesdayAgenda,
////    String getUrl = 'http://icps19.com:6060/icps/i/icps/19/cfa';
//
////    try
////    {
////      Response response;
////      Dio dio = new Dio();
////
////      response = await dio.get(getUrl);
////
////      var conferenceAgenda = ConferenceAgenda.fromJson(response.data);
////
////      DateTime date = conferenceAgenda.conferenceDate;
////
////      String day = formatDate (date, [d]);
////
////      print ('Day: $day');
////
////      if (day == 'Tuesday')
////      {
////        conferenceAgenda(agenda)
////        {
//          return new Container(
//            padding: new EdgeInsets.only(bottom: 10.0),
//            decoration: new BoxDecoration(
//                border: new Border(
//                    bottom: new BorderSide(
//                      width: 1.0,
//                      style: BorderStyle.solid,
//                      color: Color.fromRGBO(192, 192, 192, 1),
//                    )
//                )
//            ),
//            child: new Column (
//              children: <Widget>[
//                new Container(
//                  child: new Column (
//                    children: <Widget>[
//                      new Container(
//                        padding: new EdgeInsets.only(top: 10.0, left: 23.0),
//                        child: new Row(
//                          children: <Widget>[
//                            new Container(
//                              child: new Icon(Icons.mic,
//                                size: 34.0,
//                                color: Color.fromRGBO(180, 188, 151, 1),
//                              ),
//                            ),
//                            new Container(
//                              margin: new EdgeInsets.only(left: 59.0),
//                              width: ScreenUtil.getInstance().setWidth(500),
//                              child: new Text('Arrival & Registration',
//                                style: new TextStyle(
//                                    fontSize: ScreenUtil(allowFontScaling: true).setSp(38),
//                                    fontWeight: FontWeight.bold
//                                ),
//                              ),
//                            )
//                          ],
//                        ),
//                      ),
//                      new Container(
//                        padding: new EdgeInsets.only(left: 16.0, top: 10.0),
//                        child: new Row(
//                          children: <Widget>[
//                            new Container(
//                                width: ScreenUtil.getInstance().setWidth(183),
//                                child: new Column(
//                                  crossAxisAlignment: CrossAxisAlignment.end,
//                                  children: <Widget>[
//                                    new Text('7:00 AM - 9:00 AM',
//                                      style: new TextStyle(
//                                          fontSize: ScreenUtil(allowFontScaling: true).setSp(29)
//                                      ),
//                                    ),
////                                          new Text('5 Sep')
//                                  ],
//                                )
//                            ),
//                            new Container(
//                              width: ScreenUtil.getInstance().setWidth(380),
//                              padding: new EdgeInsets.only(left: 0.0),
//                              child: new Column(
//                                crossAxisAlignment: CrossAxisAlignment.start,
//                                children: <Widget>[
//                                  new Text('Arrival & Registration',
//                                    style: new TextStyle(
//                                        fontSize: ScreenUtil(allowFontScaling: true).setSp(31)
//                                    ),
//                                  ),
////                                          new Text('Exhibit Hall C')
//                                ],
//                              ),
//                            ),
//                            new Container(
//                              margin: new EdgeInsets.only(left: 54.0),
//                              width: 7.0,
//                              height: 7.0,
//                              decoration: new BoxDecoration(
//                                  color: Color.fromRGBO(117, 98, 40, 1),
//                                  borderRadius: new BorderRadius.circular(70.0)
//                              ),
//                            )
//                          ],
//                        ),
//                      ),
////                              new Container(
////                                padding: new EdgeInsets.only(left: 16.0, top: 10.0),
////                                child: new Row(
////                                  children: <Widget>[
////                                    new Container(
////                                      child: new Column(
////                                        crossAxisAlignment: CrossAxisAlignment.end,
////                                        children: <Widget>[
////                                          new Text('11:00AM',
////                                            style: new TextStyle(
////                                                fontSize: 16.0
////                                            ),
////                                          ),
////                                          new Text('5 Sep')
////                                        ],
////                                      ),
////                                    )
////                                  ],
////                                ),
////                              )
//                    ],
//                  ),
//                )
//              ],
//            ),
//          );
//        }
//      }
//  )
//    catch(e)
//    {
//      print('Error: $e');
//    }
//  }
//}

class AgendaDetails extends StatefulWidget {
  final ConferenceAgenda conferenceAgenda; Data data; String password;

  AgendaDetails({this.conferenceAgenda, this.data, this.password});

  @override
  _AgendaDetailsState createState() => _AgendaDetailsState();
}

class _AgendaDetailsState extends State<AgendaDetails> {

  double rating = 4.1;
  int starCount = 5;

  AuthStatus _authStatus = AuthStatus.notSignedIn;

//  final TextEditingController _feedbackFilter = new TextEditingController();

//  String _feedback = "";

//  ArrivalState() {
//    _feedbackFilter.addListener(_feedbackListen);
//  }

//  void _feedbackListen() {
//    if (_feedbackFilter.text.isEmpty) {
//      _feedback = "";
//    } else {
//      _feedback = _feedbackFilter.text;
//    }
//  }

  @override
  void initState() {
    super.initState();

    widget.data = widget.data ?? Data();

    _authStatus = ((widget.data.surname == '')) ? AuthStatus.notSignedIn : (widget.data.speaker && widget.data.surname != '') ? AuthStatus.signedInSpeaker : AuthStatus.signedIn;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Color.fromRGBO(152, 160, 87, 1),
          title: new Text(widget.conferenceAgenda.title),
          leading: Builder(
            builder: (context) => IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop (context);
              },
            ),
          ),
          actions: <Widget>[
//            IconButton(icon: Icon(
//                Icons.search
//              ),
//              onPressed: () {
//
//              },
//            ),
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
//            margin: new EdgeInsets.all(5.0),
//            padding: EdgeInsets.all(16.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
//                  padding: new EdgeInsets.all(23.0),
                  child: new Column(
                    children: <Widget>[
                      new Center (
                        child: new Container(
                          padding: new EdgeInsets.only(top: 30.0, bottom: 30.0),
                          width: MediaQuery.of(context).size.width,
                          decoration: new BoxDecoration(
                              border: new Border(
                                  bottom: new BorderSide(
                                    width: 1.0,
                                    style: BorderStyle.solid,
                                    color: Color.fromRGBO(192, 192, 192, 1),
                                  )
                              )
                          ),
                          child: new Row(
                            children: <Widget>[
                              new Container(
                                  padding: new EdgeInsets.only(left: 35.0, right: 65.0),
                                  child: new Text('Anchor',
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: ScreenUtil(allowFontScaling: true).setSp(28)
                                    ),
                                  )
                              ),
                              new Container(
                                width: ScreenUtil.getInstance().setWidth(450),
                                child: new Text(widget.conferenceAgenda.usersInfo.title + ' ' +
                                    widget.conferenceAgenda.usersInfo.surname + ' ' + widget.conferenceAgenda.usersInfo.firstname,
                                  style: new TextStyle(
                                    fontSize: ScreenUtil(allowFontScaling: true).setSp(36),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      new Center (
                        child: new Container(
                          padding: new EdgeInsets.only(top: 30.0, bottom: 30.0),
                          width: MediaQuery.of(context).size.width,
                          decoration: new BoxDecoration(
                              border: new Border(
                                  bottom: new BorderSide(
                                    width: 1.0,
                                    style: BorderStyle.solid,
                                    color: Color.fromRGBO(192, 192, 192, 1),
                                  )
                              )
                          ),
                          child: new Row(
                            children: <Widget>[
                              new Container(
                                  padding: new EdgeInsets.only(left: 35.0, right: 33.0),
                                  child: new Text('Occupation',
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: ScreenUtil(allowFontScaling: true).setSp(28)
                                    ),
                                  )
                              ),
                              new Container(
                                width: ScreenUtil.getInstance().setWidth(450),
                                child: new Text('${widget.conferenceAgenda.usersInfo.workPosition}, ${widget.conferenceAgenda.usersInfo.organisation}',
                                  style: new TextStyle(
                                    fontSize: ScreenUtil(allowFontScaling: true).setSp(36),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      new Center (
                        child: new Container(
                          padding: new EdgeInsets.only(top: 30.0, bottom: 30.0),
                          width: MediaQuery.of(context).size.width,
                          decoration: new BoxDecoration(
                              border: new Border(
                                  bottom: new BorderSide(
                                    width: 1.0,
                                    style: BorderStyle.solid,
                                    color: Color.fromRGBO(192, 192, 192, 1),
                                  )
                              )
                          ),
                          child: new Row(
                            children: <Widget>[
                              new Container(
                                  padding: new EdgeInsets.only(left: 35.0, right: 83.0),
                                  child: new Text('Hall',
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: ScreenUtil(allowFontScaling: true).setSp(28)
                                    ),
                                  )
                              ),
                              new Container(
                                width: ScreenUtil.getInstance().setWidth(450),
                                child: new Text('Congress Hall',
                                  style: new TextStyle(
                                    fontSize: ScreenUtil(allowFontScaling: true).setSp(36),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      new Center (
                        child: new Container(
                          padding: new EdgeInsets.only(top: 30.0, bottom: 30.0),
                          width: MediaQuery.of(context).size.width,
                          decoration: new BoxDecoration(
                              border: new Border(
                                  bottom: new BorderSide(
                                    width: 1.0,
                                    style: BorderStyle.solid,
                                    color: Color.fromRGBO(192, 192, 192, 1),
                                  )
                              )
                          ),
                          child: new Row(
                            children: <Widget>[
                              new Container(
                                  padding: new EdgeInsets.only(left: 35.0, right: 41.0),
                                  child: new Text('Moderator',
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: ScreenUtil(allowFontScaling: true).setSp(28)
                                    ),
                                  )
                              ),
                              new Container(
                                width: ScreenUtil.getInstance().setWidth(450),
                                child: new Text('${widget.conferenceAgenda.moderator}',
                                  style: new TextStyle(
                                    fontSize: ScreenUtil(allowFontScaling: true).setSp(36),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      new Center (
                        child: new Container(
                          padding: new EdgeInsets.only(top: 30.0, bottom: 30.0),
                          width: MediaQuery.of(context).size.width,
                          decoration: new BoxDecoration(
                              border: new Border(
                                  bottom: new BorderSide(
                                    width: 1.0,
                                    style: BorderStyle.solid,
                                    color: Color.fromRGBO(192, 192, 192, 1),
                                  )
                              )
                          ),
                          child: new Row(
                            children: <Widget>[
                              new Container(
                                  padding: new EdgeInsets.only(left: 35.0, right: 74.0),
                                  child: new Text('Panel',
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: ScreenUtil(allowFontScaling: true).setSp(28)
                                    ),
                                  )
                              ),
                              new Container(
                                width: ScreenUtil.getInstance().setWidth(180),
                                child: new Text('${widget.conferenceAgenda.paneldiscussants.substring(1, widget.conferenceAgenda.paneldiscussants.indexOf(']'))}',
                                  style: new TextStyle(
                                    fontSize: ScreenUtil(allowFontScaling: true).setSp(36),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
//                    new Center (
//                      child: new Container(
//                        padding: new EdgeInsets.only(top: 30.0, bottom: 30.0),
//                        width: MediaQuery.of(context).size.width,
//                        decoration: new BoxDecoration(
//                            border: new Border(
//                                bottom: new BorderSide(
//                                  width: 1.0,
//                                  style: BorderStyle.solid,
//                                  color: Color.fromRGBO(192, 192, 192, 1),
//                                )
//                            )
//                        ),
//                        child: new Row(
//                          children: <Widget>[
//                            new Container(
//                                padding: new EdgeInsets.only(left: 35.0, right: 75.0),
//                                child: new Icon(Icons.star)
//                            ),
//                            new StarRating(
//                              size: 20.0,
//                              rating: rating,
//                              color: Colors.orange,
//                              borderColor: Colors.grey,
//                              starCount: starCount,
//                              onRatingChanged: (rating) => setState(
//                                    () {
//                                  this.rating = rating;
//                                },
//                              ),
//                            ),
//                          ],
//                        ),
//                      ),
//                    ),
//                    new Center (
//                      child: new Container(
//                        padding: new EdgeInsets.only(top: 0.0, bottom: 0.0),
//                        width: MediaQuery.of(context).size.width,
//                        decoration: new BoxDecoration(
//                            border: new Border(
//                                bottom: new BorderSide(
//                                  width: 1.0,
//                                  style: BorderStyle.solid,
//                                  color: Color.fromRGBO(192, 192, 192, 1),
//                                )
//                            )
//                        ),
//                        child: new Row(
//                          children: <Widget>[
//                            new Flexible(
//                              child: new Container(
//                                margin: new EdgeInsets.all(20.0),
//                                child: new TextFormField(
//                                  controller: _feedbackFilter,
//                                  decoration: new InputDecoration(
//                                      labelText: 'Feedback',
//                                      prefixIcon: Padding(
//                                          padding: EdgeInsets.all(0.0),
//                                          child: Icon(
//                                            Icons.feedback,
//                                            color: Colors.grey,
//                                          )
//                                      )
//                                    //                              border: new OutlineInputBorder(
//                                    //                                  borderSide: new BorderSide(
//                                    //                                      color: Color.fromRGBO(53, 182, 134, 1),
//                                    //                                      width: 1.0
//                                    //                                  ),
//                                    //                                  borderRadius: BorderRadius.circular(5.0)
//                                    //                              ),
//                                  ),
//                                  //                                  validator: (value) => value.isEmpty ? 'Username can\'t be empty' : null,
//                                  onSaved: (value) => _feedback = value,
//                                ),
//                              ),
//                            )
//                          ],
//                        ),
//                      ),
//                    ),
                      new Center (
                        child: new Container(
                          padding: new EdgeInsets.only(top: 0.0, bottom: 0.0),
                          width: MediaQuery.of(context).size.width,
                          decoration: new BoxDecoration(
                            border: new Border(
                                bottom: new BorderSide(
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                  color: Color.fromRGBO(192, 192, 192, 1),
                                )
                            ),
                          ),
                          child: new Row(
                            children: <Widget>[
//                              new Flexible(
                              new Container(
                                decoration: new BoxDecoration(
                                    color: Color.fromRGBO(53, 182, 134, 1),
                                    borderRadius: new BorderRadius.circular(5.0)
                                ),
                                margin: new EdgeInsets.all(20.0),
                                child: new FlatButton(
                                  child: new Text('Contribute',
                                    style: new TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => ActivityFeed(data: widget.data, password: widget.password,))
                                    );
                                  },
                                ),
                              ),
//                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
//                _buildButtons(),
              ],
            ),
          ),
        )
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
        _showDialog(context);
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
          MaterialPageRoute(builder: (context) => Settings(data: widget.data, password: widget.password))
      );
    }
  }

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
}

