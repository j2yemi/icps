import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:icps/app_screens/NewMessage/ComposeMessage.dart';
import 'package:icps/Constants.dart';
import 'package:icps/app_screens/Register.dart';
import 'package:icps/app_screens/drawer/Login.dart';

import 'package:icps/app_screens/popupMenu/Dashboard.dart';
import 'package:icps/app_screens/popupMenu/EditProfile.dart';
import 'package:icps/app_screens/popupMenu/Settings.dart';
import 'package:icps/MessagesJson.dart';

import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:icps/app_screens/activity_feed/NewFeed.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

//import 'package:icps/app_screens/HomePage.dart';

void main() {
  runApp(MaterialApp (
    debugShowCheckedModeBanner: false,
    home: NewMessages(),
  )
  );
}

class NewMessages extends StatefulWidget {

  Data data; String password;

  NewMessages({this.data, this.password});

  @override
  _NewMessagesState createState() => _NewMessagesState();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
  signedInSpeaker
}

class _NewMessagesState extends State<NewMessages> {

  ScrollController controller;

  AuthStatus _authStatus = AuthStatus.notSignedIn;

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  String url = 'http://icps19.com:6060/icps/resources/conferencepresentations/profilepics/';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.data = widget.data ?? Data();

    _authStatus = ((widget.data.surname == '')) ? AuthStatus.notSignedIn : (widget.data.speaker && widget.data.surname != '') ? AuthStatus.signedInSpeaker : AuthStatus.signedIn;

    refreshList();

    controller = new ScrollController()..addListener(_scrollListener);
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
      _getMessages();
    });

    return null;
  }

  Future <List<MyMessages>> _getMessages() async {

    List<MyMessages> myMessagesFromJson(String str) => new List<MyMessages>.from(json.decode(str).map((x) => MyMessages.fromJson(x)));

    String myMessagesToJson(List<MyMessages> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

    String getUrl = 'http://icps19.com:6060/icps/icps/19/msl';

    var messagesData = await http.get(getUrl);

    var jsonData = messagesData.body;
    print(jsonData);
    print('get');
    List <MyMessages> myMessages = myMessagesFromJson(jsonData);
    print('get2');
    List <MyMessages> message = [];


    try
    {
      for (MyMessages ss in myMessages)
      {
        //String timeFormat = DateFormat('HH, mm').format(ss.messagedate);
        //DateTime time = DateTime.parse(timeFormat);

        ss.messagedate = '${ss.messagedate.substring(0, 10)} ${ss.messagedate.substring(11, 19)}';

        print(ss.messagedate);

        DateTime dated = DateTime.parse(ss.messagedate);

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

        if (ss.mTo == widget.data.id)
        {
          MyMessages receiveMessages = MyMessages (
              id: ss.id,
              mFrom: ss.mFrom,
              mMessage: ss.mMessage,
              mTo: ss.mTo,
              messagedate: time,
              messageread: ss.messageread,
              sentToInfo: ss.sentToInfo,
              userinfoid: ss.userinfoid,
              usersInfo: ss.usersInfo,
              messageType: 'R'
          );

          message.add(receiveMessages);
        }

        if (ss.mFrom == widget.data.id)
        {
          MyMessages receiveMessages = MyMessages (
              id: ss.id,
              mFrom: ss.mFrom,
              mMessage: ss.mMessage,
              mTo: ss.mTo,
              messagedate: time,
              messageread: ss.messageread,
              sentToInfo: ss.sentToInfo,
              userinfoid: ss.userinfoid,
              usersInfo: ss.usersInfo,
              messageType: 'S'
          );

          message.add(receiveMessages);
        }

      }
    }
    catch(e)
    {
      print('Error: $e');
    }

    print(message.length);

    message..sort((a, b) => b.id.compareTo(a.id));


    return message;
  }

  @override
  Widget build(BuildContext context) {
      ScreenUtil.instance =
      ScreenUtil(width: 750, height: 1334, allowFontScaling: true)
        ..init(context);
      return Scaffold(
          appBar: new AppBar(
            backgroundColor: Color.fromRGBO(152, 160, 87, 1),
            title: new Text("Messages"),
            leading: Builder(
              builder: (context) =>
                  IconButton(
                    icon: new Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
            ),
            actions: <Widget>[
//              IconButton(icon: Icon(
//                  Icons.search
//              ),
//                onPressed: () {
//
//                },
//              ),
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
          floatingActionButton: new FloatingActionButton(
            child: new Icon(Icons.edit),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ComposeMessage(data: widget.data, password: widget.password))
              );
            },
            backgroundColor: Color.fromRGBO(152, 160, 87, 1),
          ),
          body: new RefreshIndicator(
            onRefresh: refreshList,
            child: new SingleChildScrollView(
                child: new Column(
                    children: <Widget>[
                      new Container(
                        margin: new EdgeInsets.only(
                            top: 20.0, left: 10.0, right: 10.0, bottom: 20.0),
                        child: new FutureBuilder(
                            future: _getMessages(),
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
                                      child: new Text('No Message here yet',
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
                                      if (snapshot.data[index].mTo == widget.data.id) {
                                        return new Card(
                                          child: new GestureDetector(
                                            onTap: () {
                                              Navigator.push (context,
                                                  MaterialPageRoute(builder: (context) => MessageDetails(snapshot.data[index], widget.data))
                                              );
                                            },
                                            child: new Container(
                                              padding: new EdgeInsets.all(10.0),
                                              child: new Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    new Container(
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
                                                          new Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: <Widget>[
                                                              new Container(
                                                                padding: new EdgeInsets.only(bottom: 5.0),
                                                                child: new Text('${snapshot.data[index].usersInfo.title} ${snapshot.data[index].usersInfo.surname} ${snapshot.data[index].usersInfo.firstname}',
                                                                  style: new TextStyle(
                                                                      fontSize: ScreenUtil(allowFontScaling: true).setSp(31),
                                                                      fontWeight: !snapshot.data[index].messageread ? FontWeight.bold : FontWeight.normal
                                                                  ),
                                                                ),
                                                              ),
                                                              new Container(
                                                                padding: new EdgeInsets.only(bottom: 5.0),
                                                                child: new Text(snapshot.data[index].mMessage.length > 30 ?
                                                                snapshot.data[index].mMessage.substring(0, 30) + '...'
                                                                    : snapshot.data[index].mMessage,
                                                                  style: new TextStyle(
                                                                      fontSize: ScreenUtil(allowFontScaling: true).setSp(28),
                                                                      fontWeight: !snapshot.data[index].messageread ? FontWeight.bold : FontWeight.normal
                                                                  ),
                                                                ),
                                                              ),
                                                              new Container(
                                                                child: new Text(snapshot.data[index].messagedate,
                                                                  style: new TextStyle(
                                                                      fontSize: ScreenUtil(allowFontScaling: true).setSp(29),
                                                                      color: Colors.grey
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
//                                                new Container(
//                                                  margin: new EdgeInsets.only(top: 5.0),
//                                                  width: 7.0,
//                                                  height: 7.0,
//                                                  decoration: new BoxDecoration(
//                                                      color: !snapshot.data[index].messageread ? Colors.red : Colors.green,
//                                                      borderRadius: new BorderRadius.circular(70.0)
//                                                  ),
//                                                )
                                                    new Container(
                                                      margin: new EdgeInsets.only(top: 5.0),
                                                      child: new Text('R'
                                                      ),
                                                    )
                                                  ]
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      else {
                                        return new Card(
                                          child: new GestureDetector(
                                            onTap: () {
                                              Navigator.push (context,
                                                  MaterialPageRoute(builder: (context) => MessageDetails(snapshot.data[index], widget.data))
                                              );
                                            },
                                            child: new Container(
                                              padding: new EdgeInsets.all(10.0),
                                              child: new Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    new Container(
                                                      child: new Row(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: <Widget>[
                                                          new Container(
                                                            padding: new EdgeInsets.only(right: 20.0),
                                                            child: snapshot.data[index].sentToInfo.picId == null
                                                                ? new CircleAvatar(
                                                              child: new Text('${snapshot.data[index].sentToInfo.surname.substring(0, 1)}'
                                                                  '${snapshot.data[index].sentToInfo.firstname.substring(0, 1)}'
                                                              ),
                                                            )
                                                                : CircleAvatar(
                                                              backgroundImage: NetworkImage(url + snapshot.data[index].sentToInfo.picId),
                                                              backgroundColor: Colors.transparent,
                                                            ),
                                                          ),
                                                          new Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: <Widget>[
                                                              new Container(
                                                                padding: new EdgeInsets.only(bottom: 5.0),
                                                                child: new Text('${snapshot.data[index].sentToInfo.title} ${snapshot.data[index].sentToInfo.surname} ${snapshot.data[index].sentToInfo.firstname}',
                                                                  style: new TextStyle(
                                                                      fontSize: ScreenUtil(allowFontScaling: true).setSp(31),
                                                                      fontWeight: !snapshot.data[index].messageread ? FontWeight.bold : FontWeight.normal
                                                                  ),
                                                                ),
                                                              ),
                                                              new Container(
                                                                padding: new EdgeInsets.only(bottom: 5.0),
                                                                child: new Text(snapshot.data[index].mMessage.length > 30 ?
                                                                snapshot.data[index].mMessage.substring(0, 30) + '...'
                                                                    : snapshot.data[index].mMessage,
                                                                  style: new TextStyle(
                                                                      fontSize: ScreenUtil(allowFontScaling: true).setSp(28),
                                                                      fontWeight: !snapshot.data[index].messageread ? FontWeight.bold : FontWeight.normal
                                                                  ),
                                                                ),
                                                              ),
                                                              new Container(
                                                                child: new Text(snapshot.data[index].messagedate,
                                                                  style: new TextStyle(
                                                                      fontSize: ScreenUtil(allowFontScaling: true).setSp(29),
                                                                      color: Colors.grey
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
//                                                new Container(
//                                                  margin: new EdgeInsets.only(top: 5.0),
//                                                  width: 7.0,
//                                                  height: 7.0,
//                                                  decoration: new BoxDecoration(
//                                                      color: !snapshot.data[index].messageread ? Colors.red : Colors.green,
//                                                      borderRadius: new BorderRadius.circular(70.0)
//                                                  ),
//                                                )
                                                    new Container(
                                                      margin: new EdgeInsets.only(top: 5.0),
                                                      child: new Text('S'
                                                      ),
                                                    )
                                                  ]
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    }
                                );
                              }
                            }
                        ),
                      ),
                    ]
                )
            )
          )
      );
    }

    void _scrollListener() {
      print(controller.position.extentAfter);
      if (controller.position.extentAfter < 500) {
        setState(() {
          _getMessages();
        });
      }
    }

  void choiceAction (String choice)
  {
    if (choice == Constants.Dashboard){
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Dashboard())
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
            MaterialPageRoute(builder: (context) => EditProfile())
        );
      }
    }
    else if (choice == Constants.Settings){
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Settings())
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

class MessageDetails extends StatefulWidget {

  final MyMessages myMessages; Data data;

  MessageDetails(this.myMessages, this.data);

  @override
  _MessageDetailsState createState() => _MessageDetailsState();
}

class _MessageDetailsState extends State<MessageDetails> {

  AuthStatus _authStatus = AuthStatus.notSignedIn;

  final formKey = new GlobalKey<FormState>();

  final global = GlobalKey();

  final TextEditingController _messageFilter = new TextEditingController();

//  final FocusNode _toFocus = FocusNode();
  final FocusNode _messageFocus = FocusNode();

//  String _to = "";
  String _message = "";


  NewMessage() {
//    widget.toFilter.addListener(_toListen);
    _messageFilter.addListener(_messageListen);
  }

  void _messageListen() {
    if (_messageFilter.text.isEmpty) {
      _message = "";
    } else {
      _message = _messageFilter.text;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      widget.myMessages.messageread = true;
    });

    widget.data = widget.data ?? Data();

    _authStatus = ((widget.data.surname == '')) ? AuthStatus.notSignedIn : (widget.data.speaker && widget.data.surname != '') ? AuthStatus.signedInSpeaker : AuthStatus.signedIn;

//    refreshList();
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
        title: new Text("Messages"),
        leading: Builder(
          builder: (context) =>
              IconButton(
                icon: new Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
        ),
        actions: <Widget>[
//              IconButton(icon: Icon(
//                  Icons.search
//              ),
//                onPressed: () {
//
//                },
//              ),
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
        child: new Column(
          children: <Widget>[
            new Container(
              margin: new EdgeInsets.only(top: 20.0, bottom: 20.0, left: 10.0, right: 10.0),
              child: new Card(
                child: new Container(
                  padding: new EdgeInsets.all(5.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Container(
                        padding: new EdgeInsets.all(15.0),
                        width: ScreenUtil.getInstance().setWidth(980),
                        margin: new EdgeInsets.only(bottom: 10.0),
                        decoration: BoxDecoration(
                          border: new Border(
                            bottom: BorderSide(
                              width: 1.0,
                              style: BorderStyle.solid,
                              color: Color.fromRGBO(192, 192, 192, 1),
                            ),
                          ),
                        ),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Container(
                              child: new Text(widget.myMessages.messageType == 'R' ? 'From' : 'To',
                                style: new TextStyle(
                                  fontSize: ScreenUtil(allowFontScaling: true).setSp(31),
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            new Container(
                              child: new Text(widget.myMessages.messageType == 'R' ?
                                            '${widget.myMessages.usersInfo.title} '
                                            '${widget.myMessages.usersInfo.surname} '
                                            '${widget.myMessages.usersInfo.firstname}'
                                : '${widget.myMessages.sentToInfo.title} '
                                  '${widget.myMessages.sentToInfo.surname} '
                                  '${widget.myMessages.sentToInfo.firstname}',
                                style: new TextStyle(
                                  fontSize: ScreenUtil(allowFontScaling: true).setSp(36),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      new Container(
                        padding: new EdgeInsets.all(15.0),
                        width: ScreenUtil.getInstance().setWidth(980),
                        margin: new EdgeInsets.only(bottom: 10.0),
                        decoration: BoxDecoration(
                          border: new Border(
                            bottom: BorderSide(
                              width: 1.0,
                              style: BorderStyle.solid,
                              color: Color.fromRGBO(192, 192, 192, 1),
                            ),
                          ),
                        ),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Container(
                              child: new Text('Time',
                                style: new TextStyle(
                                  fontSize: ScreenUtil(allowFontScaling: true).setSp(31),
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            new Container(
                              child: new Text('${widget.myMessages.messagedate}'),
                            ),
                          ],
                        ),
                      ),
                      new Container(
                        padding: new EdgeInsets.all(15.0),
                        width: ScreenUtil.getInstance().setWidth(980),
                        margin: new EdgeInsets.only(bottom: 10.0),
                        decoration: BoxDecoration(
                          border: new Border(
                            bottom: BorderSide(
                              width: 1.0,
                              style: BorderStyle.solid,
                              color: Color.fromRGBO(192, 192, 192, 1),
                            ),
                          ),
                        ),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Container(
                              margin: new EdgeInsets.only(bottom: 15.0),
                              child: new Text('Message',
                                style: new TextStyle(
                                  fontSize: ScreenUtil(allowFontScaling: true).setSp(31),
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            new Container(
                              child: new Text('${widget.myMessages.mMessage}',
                                style: new TextStyle(
                                  fontSize: ScreenUtil(allowFontScaling: true).setSp(34),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      widget.myMessages.messageType == 'R' ?
                      new Form(
                        key: formKey,
                        child: new Container(
                          padding: new EdgeInsets.all(15.0),
                          width: ScreenUtil.getInstance().setWidth(980),
                          margin: new EdgeInsets.only(bottom: 10.0),
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Container(
                                margin: new EdgeInsets.only(bottom: 15.0),
                                child: new Text('Reply',
                                  style: new TextStyle(
                                      fontSize: ScreenUtil(allowFontScaling: true).setSp(31),
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              new Container(
                                margin: new EdgeInsets.only(bottom: 15.0),
                                child: new TextFormField(
                                  maxLines: null,
                                  keyboardType: TextInputType.multiline,
                                  textInputAction: TextInputAction.done,
                                  focusNode: _messageFocus,
                                  controller: _messageFilter,
                                  decoration: new InputDecoration(
                                      labelText: 'Message*',
                                      prefixIcon: Padding(
                                          padding: EdgeInsets.all(0.0),
                                          child: Icon(
                                            Icons.message,
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
                                  validator: (value) => value.isEmpty ? 'Message can\'t be empty' : null,
                                  onSaved: (value) => _message = value,
  //                        autovalidate: _validate,
                                  onFieldSubmitted: (term){
                                    _messageFocus.unfocus();
                                    validateAndSubmit();
                                  },
                                ),
                              ),
                              new Container(
                                decoration: new BoxDecoration(
                                    color: Color.fromRGBO(53, 182, 134, 1),
                                    borderRadius: new BorderRadius.circular(5.0)
                                ),
                                margin: new EdgeInsets.all(20.0),
                                child: new FlatButton(
                                  child: new Text('Reply',
                                    style: new TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0
                                    ),
                                  ),
                                  onPressed: () {
                                    validateAndSubmit();
                                  },
                                ),
                              )
                            ],
                          )
                        ),
                      )
                       :
                      new Container(),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
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
//    print ('this: ${widget.myMessages.usersInfo.userinfoid}');
    if (validateAndSave())
    {
      try
      {
        _showDialogTwo(context);

        final String url = 'http://icps19.com:6060/icps/icps/19/msg';

//        var currentId = int.parse(currentToSelected);
//        assert(currentId is int);

//        int myMessageId = widget.myMessages.usersInfo.userinfoid;

//        int mToId = widget.myMessages != null ? widget.myMessages.usersInfo.userinfoid : currentId;

//        print ('this: ${widget.myMessages.usersInfo.userinfoid}');

        Response response;
        Dio dio = new Dio();
        response = await dio.post(url, queryParameters: {"m_from":widget.data.id,"m_to": widget.myMessages.usersInfo.userinfoid,"m_message":_message, "userinfoid": widget.data.id,"messageread":false},
            options: Options(
              headers: {HttpHeaders.contentTypeHeader: 'application/json',"accept": "application/json"},)
        );

        print(response.statusCode);

        Navigator.pop(context, (response.statusCode == 200 || response.statusCode == 401 || response.statusCode == 111));

        if(response.statusCode == 200){

//          print(_to);
          print(_message);
          print(widget.data.surname);

          Fluttertoast.showToast(
              msg: "Message Sent",
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
      }
      catch(e)
      {
        print('Error: $e');
      }
    }
  }

  void choiceAction (String choice)
  {
    if (choice == Constants.Dashboard){
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Dashboard())
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
            MaterialPageRoute(builder: (context) => EditProfile())
        );
      }
    }
    else if (choice == Constants.Settings){
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Settings())
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
              Text ('Message Sending',
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


