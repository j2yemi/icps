import 'package:flutter/material.dart';
// import 'package:icps/app_screens/HomePage.dart';
//import 'package:icps/app_screens/agenda/AgendaOne.dart';
//import 'package:icps/app_screens/agenda/AgendaTwo.dart';
import 'package:icps/app_screens/agenda/NewAgendaOne.dart';
import 'package:icps/app_screens/agenda/NewAgendaTwo.dart';
import 'package:icps/Constants.dart';
import 'package:icps/app_screens/Register.dart';
import 'package:icps/app_screens/drawer/Login.dart';

import 'package:icps/app_screens/popupMenu/Dashboard.dart';
import 'package:icps/app_screens/popupMenu/EditProfile.dart';
import 'package:icps/app_screens/popupMenu/Settings.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_indicator/page_indicator.dart';

void main() {
  runApp(MaterialApp (
    home: Agenda(),
    theme: ThemeData(
        fontFamily: 'Montserrat'
    ),
  )
  );
}

class Agenda extends StatefulWidget {

  Data data; String password;

  Agenda({this.data, this.password});

  @override
  _AgendaState createState() => _AgendaState ();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
  signedInSpeaker
}

class _AgendaState extends State<Agenda> {

  AuthStatus _authStatus = AuthStatus.notSignedIn;

  List<Widget> myAgendaPages = [NewAgendaOne(), NewAgendaTwo()];

  PageController controller;

  @override
  void initState() {
    super.initState();

    controller = PageController();

    widget.data = widget.data ?? Data();

    _authStatus = ((widget.data.surname == '')) ? AuthStatus.notSignedIn : (widget.data.speaker && widget.data.surname != '') ? AuthStatus.signedInSpeaker : AuthStatus.signedIn;

  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334, allowFontScaling: true)..init(context);
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(152, 160, 87, 1),
        title: new Text("Agenda"),
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
      body: new PageIndicatorContainer(
        pageView: PageView(
          children: <Widget>[
            NewAgendaOne(data: widget.data, password: widget.password),
            NewAgendaTwo(data: widget.data, password: widget.password),
          ],
        ),
        align: IndicatorAlign.bottom, // your indicator align with container
        length: 2, // indicator count
        indicatorColor: Colors.grey, // unselected indicator color
        indicatorSelectorColor: Color.fromRGBO(25, 110, 42, 1), // selected indicator color
        padding: EdgeInsets.only(bottom: 10.0), // padding with bottom .when align top you should use properties `top:10.0`
        size: 15.0, // indicator size.
        indicatorSpace: 10.0, // space between circles
      ),
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
