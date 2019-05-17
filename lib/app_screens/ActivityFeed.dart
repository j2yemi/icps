import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icps/ActivityFeedJson.dart';
// import 'package:icps/app_screens/HomePage.dart';
import 'package:icps/AttendeeJson.dart';
import 'package:icps/Constants.dart';
import 'package:icps/app_screens/Register.dart';
import 'package:icps/app_screens/drawer/Login.dart';

import 'package:icps/app_screens/popupMenu/Dashboard.dart';
import 'package:icps/app_screens/popupMenu/EditProfile.dart';
import 'package:icps/app_screens/popupMenu/Settings.dart';

import 'dart:async';
import 'dart:math' as math;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MaterialApp (
    home: ActivityFeed(),
    theme: ThemeData(
        fontFamily: 'Montserrat'
    ),
  )
  );
}

class ActivityFeed extends StatefulWidget {

  Data data; String password;

  ActivityFeed({this.data, this.password});

  @override
  _ActivityFeedState createState() => _ActivityFeedState ();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
  signedInSpeaker
}

class _ActivityFeedState extends State<ActivityFeed> {

  AuthStatus _authStatus = AuthStatus.notSignedIn;

  ScrollController controller;

  final formKey = new GlobalKey<FormState>();

  final global = GlobalKey();

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  final TextEditingController _questionFilter = new TextEditingController();

  String _question = '';

  ActivityFeed() {
    _questionFilter.addListener(_questionListen);
  }

  void _questionListen() {
    if (_questionFilter.text.isEmpty) {
      _question = "";
    } else {
      _question = _questionFilter.text;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.data = widget.data ?? Data();
    _authStatus = ((widget.data.surname == '')) ? AuthStatus.notSignedIn : (widget.data.speaker && widget.data.surname != '') ? AuthStatus.signedInSpeaker : AuthStatus.signedIn;

    controller = new ScrollController()..addListener(_scrollListener);

    refreshList();
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show();
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _getQuestions();
    });

    return null;
  }

  Future <List<QuestionVote>> _getQuestions() async {

    String getUrl = 'http://icps19.com:6060/icps/icps/19/vsl';

    var messagesData = await http.get(getUrl);

    var jsonData = messagesData.body;
    print(jsonData);
    print('get');
    List <QuestionVote> questionsList = questionVoteFromJson(jsonData);
    print('get2');
    List <QuestionVote> question = [];


    try
    {
      for (QuestionVote ss in questionsList)
      {
        //String timeFormat = DateFormat('HH, mm').format(ss.messagedate);
        //DateTime time = DateTime.parse(timeFormat);

        ss.datetimeasked = '${ss.datetimeasked.substring(0, 10)} ${ss.datetimeasked.substring(11, 19)}';

        print(ss.datetimeasked);

        DateTime dated = DateTime.parse(ss.datetimeasked);

        DateTime timeNow = new DateTime.now();

        print (dated.year);

        var timeAsked = DateTime(dated.year, dated.month, dated.day, dated.hour, dated.minute, dated.second);

        var differenceTimeAsked = timeNow.difference(timeAsked);

        var time;

        print (differenceTimeAsked);

        if (differenceTimeAsked.inHours > 24)
        {
          if (differenceTimeAsked.inHours * 24 < 2)
          {
            time = '${differenceTimeAsked.inHours.round().toString()} day ago';
          }
          else if (differenceTimeAsked.inHours * 24 == 2)
          {
            time = '${differenceTimeAsked.inHours.round().toString()} days ago';
          }
          else
          {
            time = DateFormat('EEEE, MMM d, ''yyyy').format(dated);
          }
        }
        else if (((differenceTimeAsked.inMinutes) - 60 > 60) && (differenceTimeAsked.inHours < 24)) {
          if (differenceTimeAsked.inHours < 2)
          {
            time = '${differenceTimeAsked.inHours.round().toString()} hour ago';
          }
          else
          {
            time = '${differenceTimeAsked.inHours.round().toString()} hours ago';
          }
        }
        else if ((differenceTimeAsked.inSeconds) - (60 * 60) - 60 > 60 && (differenceTimeAsked.inMinutes) - 60 < 60)
        {
          if ((differenceTimeAsked.inMinutes) - 60 < 2)
          {
            time = '${((differenceTimeAsked.inMinutes) - 60).round().toString()} min ago';
          }
          else
          {
            time = '${((differenceTimeAsked.inMinutes) - 60).round().toString()} mins ago';
          }
        }
        else
        {
          time = 'Just Now';
        }

        print (time);


        QuestionVote askQuestion = QuestionVote (
            askQuestion: ss.askQuestion,
            countvote: ss.countvote,
            firstname: ss.firstname,
            datetimeasked: time,
            id: ss.id,
            qid: ss.qid,
            qtext: ss.qtext,
            surname: ss.surname,
            votebyid: ss.votebyid,
        );

        question.add(askQuestion);

      }
    }
    catch(e)
    {
      print('Error: $e');
    }

    print(question.length);

    question..sort((a, b) => b.countvote.compareTo(a.countvote));


    return question;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334, allowFontScaling: true)..init(context);
    return Scaffold(
      key: global,
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(152, 160, 87, 1),
        title: new Text("Chatter Forum"),
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
      body: new RefreshIndicator(
        onRefresh: refreshList,
        child: new SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              new Container(
                child: new Column(
                  children: <Widget>[
                    new Container(
                      padding: new EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0),
                      width: MediaQuery.of(context).size.width,
//                    height: ScreenUtil.getInstance().setHeight(85),
                      color: Color.fromRGBO(239, 239, 239, 1),
                      child: new Text('Ask the speaker',
                        style: new TextStyle(
                            fontSize: ScreenUtil(allowFontScaling: true).setSp(28),
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(163, 163, 163, 1)
                        ),
                      ),
                    ),
                    new Container(
                      child: new Form(
                        key: formKey,
                        child: new Container(
                          margin: new EdgeInsets.all(5.0),
                          child: new TextFormField(
                            controller: _questionFilter,
                            decoration: new InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Type your question',
                                prefixIcon: new Padding(
                                    padding: new EdgeInsets.all(0.0),
                                    child: new Icon(
                                      Icons.add_comment,
                                      color: Colors.grey,
                                    )
                                ),
                                suffixIcon: new Padding(
                                    padding: new EdgeInsets.all(0.0),
                                    child: new IconButton(
                                      icon: new Icon(
                                        Icons.check_circle,
                                        color: Color.fromRGBO(53, 182, 134, 1),
                                      ),
                                      onPressed: () {
                                        if (_authStatus == AuthStatus.notSignedIn) {
                                          _showDialogTwo(context);
                                        }
                                        else {
                                          validateAndSubmit ();
                                        }
                                      },
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
                            validator: (value) => value.isEmpty ? 'Question can\'t be empty' : null,
                            onSaved: (value) => _question = value,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              new Container(
                child: new Column(
                  children: <Widget>[
//                  new Container(
//                    padding: new EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0),
//                    width: MediaQuery.of(context).size.width,
////                    height: ScreenUtil.getInstance().setHeight(85),
//                    color: Color.fromRGBO(239, 239, 239, 1),
//                    child: new Text('1 Question(s)',
//                      style: new TextStyle(
//                          fontSize: ScreenUtil(allowFontScaling: true).setSp(28),
//                          fontWeight: FontWeight.bold,
//                          color: Color.fromRGBO(163, 163, 163, 1)
//                      ),
//                    ),
//                  ),
                    new Container(
                      padding: new EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0),
                      width: MediaQuery.of(context).size.width,
//                    height: ScreenUtil.getInstance().setHeight(85),
                      color: Color.fromRGBO(239, 239, 239, 1),
                      child: new FutureBuilder(
                          future: _getQuestions(),
                          builder: (BuildContext context,
                              AsyncSnapshot snapshot) {
                            if (snapshot.data == null) {
                              return new Container(
//                            padding: new EdgeInsets.only(top: 225.0),
                                child: new Text('Loading',
                                  style: new TextStyle(
                                      fontSize: ScreenUtil(allowFontScaling: true).setSp(28),
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(163, 163, 163, 1)
                                  ),
                                ),
                              );
                            }
                            else {
                              return new Container(
//                            padding: new EdgeInsets.only(top: 225.0),
                                child: new Text('${snapshot.data.length} Questions',
                                  style: new TextStyle(
                                      fontSize: ScreenUtil(allowFontScaling: true).setSp(28),
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(163, 163, 163, 1)
                                  ),
                                ),
                              );
                            }
                          }
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.only(
                          top: 20.0, left: 10.0, right: 10.0, bottom: 20.0),
                      child: new FutureBuilder(
                          future: _getQuestions(),
                          builder: (BuildContext context,
                              AsyncSnapshot snapshot) {
                            if (snapshot.data == null) {
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
                                    child: new Text('No Questions here yet',
                                      style: new TextStyle(
                                        fontSize: ScreenUtil(
                                            allowFontScaling: true)
                                            .setSp(31),
                                      ),
                                    ),
                                  )
                              );
                            }
                            else {
                              return ListView.builder(
                                  controller: controller,
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (BuildContext context,
                                      int index) {
                                    return new Container(
                                      padding: new EdgeInsets.only(left: 10.0, right: 10.0, bottom: 20.0),
                                      child: new Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          new Container(
                                            child: new Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                new Container(
                                                  child: new Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      new Container(
                                                        child: new CircleAvatar(
                                                          backgroundColor: Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0),
                                                          child: new Text('${snapshot.data[index].surname.substring(0, 1)}'
                                                              '${snapshot.data[index].firstname.substring(0, 1)}'
                                                          ),
                                                        ),
                                                      ),
                                                      new Container(
                                                        margin: new EdgeInsets.only(left: 5.0,),
                                                        child: new Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: <Widget>[
                                                            new Container(
                                                              child: new Text('${snapshot.data[index].surname} ${snapshot.data[index].firstname}',
                                                                style: new TextStyle(
                                                                    fontSize: ScreenUtil(
                                                                        allowFontScaling: true)
                                                                        .setSp(31),
                                                                    fontWeight: FontWeight.bold
                                                                ),
                                                              ),
                                                            ),
                                                            new Container(
                                                              child: new Text('${snapshot.data[index].datetimeasked}',
                                                                style: new TextStyle(
                                                                  fontSize: ScreenUtil(
                                                                      allowFontScaling: true)
                                                                      .setSp(28),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                new GestureDetector(
                                                  onTap: () {
                                                    if (_authStatus == AuthStatus.notSignedIn) {
                                                      _showDialogTwo(context);
                                                    }
                                                    else {

                                                    }
                                                  },
                                                  child: new Center(
                                                    child: new Container(
                                                      padding: new EdgeInsets.only(top: 5.0, right: 8.0, bottom: 5.0, left: 8.0),
                                                      decoration: new BoxDecoration(
                                                          border: new Border(
                                                            top: new BorderSide(
                                                                style: BorderStyle.solid,
                                                                width: 1.0,
                                                                color: Colors.grey
                                                            ),
                                                            bottom: new BorderSide(
                                                                style: BorderStyle.solid,
                                                                width: 1.0,
                                                                color: Colors.grey
                                                            ),
                                                            left: new BorderSide(
                                                                style: BorderStyle.solid,
                                                                width: 1.0,
                                                                color: Colors.grey
                                                            ),
                                                            right: new BorderSide(
                                                                style: BorderStyle.solid,
                                                                width: 1.0,
                                                                color: Colors.grey
                                                            ),
                                                          ),
                                                          borderRadius: new BorderRadius.circular(15.0)
                                                      ),
                                                      child: new Row(
                                                        children: <Widget>[
                                                          new Container(
                                                            padding: new EdgeInsets.only(left: 5.0, right: 5.0),
                                                            child: new Text('${snapshot.data[index].countvote}',
                                                              style: new TextStyle(
                                                                  fontWeight: FontWeight.bold,
                                                                  color: Colors.grey
                                                              ),
                                                            ),
                                                          ),
                                                          new Container(
                                                            padding: new EdgeInsets.only(right: 5.0),
                                                            child: new Icon(
                                                              Icons.thumb_up,
                                                              size: 20.0,
                                                              color: Colors.grey,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          new Container(
                                            padding: new EdgeInsets.only(left: 5.0, top: 10.0, bottom: 15.0),
                                            child: new Text('${snapshot.data[index].qtext}',
                                              style: new TextStyle(
                                                  fontSize: ScreenUtil(
                                                      allowFontScaling: true)
                                                      .setSp(31),
                                                  color: Colors.grey
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                              );
                            }
                          }
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
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

  void validateAndSubmit () async {
    if (validateAndSave()) {

      _showDialog(context);

      final String url = 'http://icps19.com:6060/icps/icps/19/ask';

      Response response;
      Dio dio = new Dio();
      response = await dio.post(url, queryParameters: {"userinfoid": widget.data.id,"questiontext":_question},
          options: Options(
            headers: {HttpHeaders.contentTypeHeader: 'application/json',"accept": "application/json"},)
      );

      Navigator.pop(context, (response.statusCode == 200 || response.statusCode == 401 || response.statusCode == 111));

      if(response.statusCode == 200){

//        print(_to);
        print(_question);
        print(widget.data.surname);

        Fluttertoast.showToast(
            msg: "Question Submitted",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 6,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
      else {
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

      print('Got response here as $response.statusCode');

    }
  }

  void _scrollListener() {
    print(controller.position.extentAfter);
    if (controller.position.extentAfter < 500) {
      setState(() {
        _getQuestions();
      });
    }
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
            MaterialPageRoute(builder: (context) => EditProfile(data: widget.data, password: widget.password))
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
              Text ('Submitting Question',
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
