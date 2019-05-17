import 'package:flutter/material.dart';
import 'package:icps/app_screens/conference/ConferenceSurvey.dart';
// import 'package:icps/app_screens/HomePage.dart';
import 'package:icps/app_screens/conference/ConferenceObjectives.dart';
import 'package:icps/app_screens/conference/ConferenceHighlights.dart';
import 'package:icps/app_screens/conference/ConferenceTheme.dart';
import 'package:icps/app_screens/conference/ConferenceAudience.dart';
import 'package:icps/app_screens/conference/ConferencePaper.dart';
import 'package:icps/Constants.dart';
import 'package:icps/app_screens/Register.dart';
import 'package:icps/app_screens/drawer/Login.dart';

import 'package:icps/app_screens/popupMenu/Dashboard.dart';
import 'package:icps/app_screens/popupMenu/EditProfile.dart';
import 'package:icps/app_screens/popupMenu/Settings.dart';


void main() {
  runApp(MaterialApp (
    home: Conference(),
    theme: ThemeData(
        fontFamily: 'Montserrat'
    ),
  )
  );
}

class Conference extends StatefulWidget {

  Data data; String password;

  Conference({this.data, this.password});

  @override
  _ConferenceState createState() => _ConferenceState();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
  signedInSpeaker
}

class _ConferenceState extends State<Conference>
{
  AuthStatus _authStatus = AuthStatus.notSignedIn;

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
        title: new Text("Conference"),
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
        child: new Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new GestureDetector(
              onTap: () {
                Navigator.push (context,
                    MaterialPageRoute(builder: (context) => ConferenceObjectives(data: widget.data, password: widget.password))
                );
              },
              child: new Container (
                width: MediaQuery.of(context).size.width,
                padding: new EdgeInsets.only (
                    left: 20.0,
                    top: 30.0,
                    bottom: 30.0
                ),
                child: new Row (
                  children: <Widget>[
                    new Container(
                      margin: new EdgeInsets.only(right: 34.0),
                      child: new Icon(Icons.school),
                    ),
                    new Text('Key Conference Objectives',
                      style: new TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  border: new Border(
                    bottom: BorderSide(
                      width: 1.0,
                      style: BorderStyle.solid,
                      color: Color.fromRGBO(192, 192, 192, 1),
                    ),
                  ),
                ),
              ),
            ),
            new GestureDetector(
              onTap: () {
                Navigator.push (context,
                    MaterialPageRoute(builder: (context) => ConferenceHighlights(data: widget.data, password: widget.password))
                );
              },
              child: new Container (
                width: MediaQuery.of(context).size.width,
                padding: new EdgeInsets.only (
                    left: 20.0,
                    top: 30.0,
                    bottom: 30.0
                ),
                child: new Row(
                  children: <Widget>[
                    new Container(
                      margin: new EdgeInsets.only(right: 34.0),
                      child: new Icon(Icons.vpn_key),
                    ),
                    new Text('Key Conference Highlights',
                      style: new TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  border: new Border(
                    bottom: BorderSide(
                      width: 1.0,
                      style: BorderStyle.solid,
                      color: Color.fromRGBO(192, 192, 192, 1),
                    ),
                  ),
                ),
              ),
            ),
            new GestureDetector(
              onTap: () {
                Navigator.push (context,
                    MaterialPageRoute(builder: (context) => ConferenceTheme(data: widget.data, password: widget.password))
                );
              },
              child: new Container (
                width: MediaQuery.of(context).size.width,
                padding: new EdgeInsets.only (
                    left: 20.0,
                    top: 30.0,
                    bottom: 30.0
                ),
                child: new Row(
                  children: <Widget>[
                    new Container(
                      margin: new EdgeInsets.only(right: 34.0),
                      child: new Icon(Icons.format_paint),
                    ),
                    new Text('Conference Theme',
                      style: new TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  border: new Border(
                    bottom: BorderSide(
                      width: 1.0,
                      style: BorderStyle.solid,
                      color: Color.fromRGBO(192, 192, 192, 1),
                    ),
                  ),
                ),
              ),
            ),
            new GestureDetector(
              onTap: () {
                Navigator.push (context,
                    MaterialPageRoute(builder: (context) => ConferenceAudience(data: widget.data, password: widget.password))
                );
              },
              child: new Container (
                width: MediaQuery.of(context).size.width,
                padding: new EdgeInsets.only (
                    left: 20.0,
                    top: 30.0,
                    bottom: 30.0
                ),
                child: new Row(
                  children: <Widget>[
                    new Container(
                      margin: new EdgeInsets.only(right: 34.0),
                      child: new Icon(Icons.headset),
                    ),
                    new Text('Conference Audience',
                      style: new TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  border: new Border(
                    bottom: BorderSide(
                      width: 1.0,
                      style: BorderStyle.solid,
                      color: Color.fromRGBO(192, 192, 192, 1),
                    ),
                  ),
                ),
              ),
            ),
            new GestureDetector(
              onTap: () {
                Navigator.push (context,
                    MaterialPageRoute(builder: (context) => ConferencePaper(data: widget.data, password: widget.password))
                );
              },
              child: new Container (
                width: MediaQuery.of(context).size.width,
                padding: new EdgeInsets.only (
                    left: 20.0,
                    top: 30.0,
                    bottom: 30.0
                ),
                child: new Row (
                  children: <Widget>[
                    new Container(
                      margin: new EdgeInsets.only(right: 34.0),
                      child: new Icon(Icons.insert_drive_file),
                    ),
                    new Text('Conference Papers',
                      style: new TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  border: new Border(
                    bottom: BorderSide(
                      width: 1.0,
                      style: BorderStyle.solid,
                      color: Color.fromRGBO(192, 192, 192, 1),
                    ),
                  ),
                ),
              ),
            ),
            new GestureDetector(
              onTap: () {
//                Navigator.push (context,
//                    MaterialPageRoute(builder: (context) => ConferencePaper())
//                );
              },
              child: new Container (
                width: MediaQuery.of(context).size.width,
                padding: new EdgeInsets.only (
                    left: 20.0,
                    top: 30.0,
                    bottom: 30.0
                ),
                child: new Row (
                  children: <Widget>[
                    new Container(
                      margin: new EdgeInsets.only(right: 34.0),
                      child: new Icon(Icons.people),
                    ),
                    new Text('Panelist Discussion',
                      style: new TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  border: new Border(
                    bottom: BorderSide(
                      width: 1.0,
                      style: BorderStyle.solid,
                      color: Color.fromRGBO(192, 192, 192, 1),
                    ),
                  ),
                ),
              ),
            ),
            new GestureDetector(
              onTap: () {
                Navigator.push (context,
                    MaterialPageRoute(builder: (context) => ConferenceSurvey(data: widget.data, password: widget.password))
                );
              },
              child: new Container (
                width: MediaQuery.of(context).size.width,
                padding: new EdgeInsets.only (
                    left: 20.0,
                    top: 30.0,
                    bottom: 30.0
                ),
                child: new Row (
                  children: <Widget>[
                    new Container(
                      margin: new EdgeInsets.only(right: 34.0),
                      child: new Icon(Icons.tag_faces),
                    ),
                    new Text('Conference Survey',
                      style: new TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
//                decoration: BoxDecoration(
//                  border: new Border(
//                    bottom: BorderSide(
//                      width: 1.0,
//                      style: BorderStyle.solid,
//                      color: Color.fromRGBO(192, 192, 192, 1),
//                    ),
//                  ),
//                ),
              ),
            ),
          ]
        ),
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
          MaterialPageRoute(builder: (context) => Settings(data: widget.data, password: widget.password,))
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
