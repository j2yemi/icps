import 'package:flutter/material.dart';
// import 'package:icps/app_screens/HomePage.dart';
//import 'package:icps/app_screens/extraactivities/BreakoutSession.dart';
import 'package:icps/app_screens/extraactivities/Cocktail.dart';
//import 'package:icps/app_screens/extraactivities/GalaNite.dart';
import 'package:icps/app_screens/extraactivities/ExihibitionsRegister.dart';
import 'package:icps/app_screens/extraactivities/PartnerRegister.dart';
import 'package:icps/Constants.dart';
import 'package:icps/app_screens/Register.dart';
import 'package:icps/app_screens/drawer/Login.dart';

import 'package:icps/app_screens/popupMenu/Dashboard.dart';
import 'package:icps/app_screens/popupMenu/EditProfile.dart';
import 'package:icps/app_screens/popupMenu/Settings.dart';

void main() {
  runApp(MaterialApp (
    home: ExtraActivities(),
    theme: ThemeData(
        fontFamily: 'Montserrat'
    ),
  )
  );
}

class ExtraActivities extends StatefulWidget {

  Data data; String password;

  ExtraActivities({this.data, this.password});

  @override
  _ExtraActivitiesState createState() => _ExtraActivitiesState();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
  signedInSpeaker
}

class _ExtraActivitiesState extends State<ExtraActivities> {

  AuthStatus _authStatus = AuthStatus.notSignedIn;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.data = widget.data ?? Data();

    _authStatus = ((widget.data.surname == '')) ? AuthStatus.notSignedIn : (widget.data.speaker && widget.data.surname != '') ? AuthStatus.signedInSpeaker : AuthStatus.signedIn;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(152, 160, 87, 1),
        title: new Text("Extra Activities"),
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
                      MaterialPageRoute(builder: (context) => Cocktail(data: widget.data, password: widget.password))
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
                      child: new Icon(Icons.local_bar),
                    ),
                    new Text('Cocktail',
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
                  if (_authStatus == AuthStatus.notSignedIn) {
                    _showDialog(context);
                  }
                  else {
                    Navigator.push (context,
                        MaterialPageRoute(builder: (context) => ExhibitionsRegister(data: widget.data, password: widget.password))
                    );
                  }
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
                      child: new Icon(Icons.card_membership),
                    ),
                    new Text('Register for Exhibitions',
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
                if (_authStatus == AuthStatus.notSignedIn) {
                  _showDialog(context);
                }
                else {
                  Navigator.push (context,
                      MaterialPageRoute(builder: (context) => PartnerRegister(data: widget.data, password: widget.password))
                  );
                }
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
                      child: new Icon(Icons.thumb_up),
                    ),
                    new Text('Register for Partnership',
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
          ]
        ),
      ),
    );
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
