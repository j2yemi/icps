import 'package:flutter/material.dart';
// import 'package:icps/app_screens/ConferenceCentre.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:icps/app_screens/maps/conference_centre/CentreDescription.dart';
import 'package:icps/app_screens/maps/conference_centre/CentreMap.dart';
import 'package:icps/Constants.dart';
import 'package:icps/app_screens/Register.dart';
import 'package:icps/app_screens/drawer/Login.dart';

import 'package:icps/app_screens/popupMenu/Dashboard.dart';
import 'package:icps/app_screens/popupMenu/EditProfile.dart';
import 'package:icps/app_screens/popupMenu/Settings.dart';

void main() {
  runApp(MaterialApp (
    home: ConferenceCentre(),
    theme: ThemeData(
        fontFamily: 'Montserrat'
    ),
  )
  );
}

class ConferenceCentre extends StatefulWidget {

  Data data; String password;

  ConferenceCentre({this.data, this.password});

  @override
  _ConferenceCentreState createState() => _ConferenceCentreState();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
  signedInSpeaker
}

class _ConferenceCentreState extends State<ConferenceCentre> {

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
        title: new Text("Conference Centre"),
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CentreDescription(data: widget.data, password: widget.password))
                );
              },
              child: new Container (
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                padding: new EdgeInsets.only (
                    left: 20.0,
                    top: 30.0,
                    bottom: 30.0
                ),
                child: new Row(
                  children: <Widget>[
                    new Container(
                      margin: new EdgeInsets.only(right: 34.0),
                      child: new Icon(Icons.pages),
                    ),
                    new Text('Conference Centre Description',
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CentreMap(data: widget.data, password: widget.password))
                );
              },
              child: new Container (
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                padding: new EdgeInsets.only (
                    left: 20.0,
                    top: 30.0,
                    bottom: 30.0
                ),
                child: new Row(
                  children: <Widget>[
                    new Container(
                      margin: new EdgeInsets.only(right: 34.0),
                      child: new Icon(Icons.map),
                    ),
                    new Text('Conference Centre Map',
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
          ],
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