import 'package:flutter/material.dart';
// import 'package:icps/app_screens/Conference.dart';
import 'package:icps/Constants.dart';
import 'package:icps/app_screens/Register.dart';
import 'package:icps/app_screens/drawer/Login.dart';

import 'package:icps/app_screens/popupMenu/Dashboard.dart';
import 'package:icps/app_screens/popupMenu/EditProfile.dart';
import 'package:icps/app_screens/popupMenu/Settings.dart';

void main() {
  runApp(MaterialApp (
    home: CentreDescription(),
    theme: ThemeData(
        fontFamily: 'Montserrat'
    ),
  )
  );
}

class CentreDescription extends StatefulWidget {

  Data data; String password;

  CentreDescription({this.data, this.password});

  @override
  _CentreDescriptionState createState() => _CentreDescriptionState();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
  signedInSpeaker
}

class _CentreDescriptionState extends State<CentreDescription> {

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
        title: new Text("Conference Centre Description"),
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
                        'assets/images/maps/conference_centre/icpsCongressHall.PNG'
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              new Container(
                padding: new EdgeInsets.all(10.0),
                child: new Text(
                  'Conference Centre - Congress Hall, Transcorp Hilton Hotel',
                  style: new TextStyle(
                      color: Color.fromRGBO(25, 110, 42, 1),
                      fontSize: 20.0
                  ),
                ),
              ),
              new Container(
                margin: new EdgeInsets.only(left: 15.0, right: 15.0),
                padding: new EdgeInsets.all(25.0),
                decoration: new BoxDecoration(
                  color: Color.fromRGBO(245, 245, 245, 1),
                ),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Container(
                      margin: new EdgeInsets.only(bottom: 15.0),
                      child: new Text ('- LOCATED IN THE CENTRAL BUSINESS DISTRICT OF ABUJA',
                        style: new TextStyle (
                          fontSize: 14.0
                        )
                      )
                    ),
                    new Container(
                      margin: new EdgeInsets.only(bottom: 15.0),
                      child: new Text ('- 5 MINUTES\' DRIVE FROM GOVERNMENT MINISTRIES AND DIPLOMATIC OFFICES',
                        style: new TextStyle (
                          fontSize: 14.0
                        )
                      )
                    ),
                    new Container(
                      margin: new EdgeInsets.only(bottom: 15.0),
                      child: new Text ('- 40 MINUTES AWAY FROM NNAMDI AZIKIWE AIRPORT',
                        style: new TextStyle (
                          fontSize: 14.0
                        )
                      )
                    ),
                    new Container(
                      margin: new EdgeInsets.only(bottom: 15.0),
                      child: new Text ('- CONGRESS HALL COULD HOLDS 1,200 GUESTS',
                        style: new TextStyle (
                          fontSize: 14.0
                        )
                      )
                    ),
                    new Container(
                      margin: new EdgeInsets.only(bottom: 15.0),
                      child: new Text ('- HOST 24 MEETING ROOMS WHICH IS GOOD FOR BREAKOUT SESSIONS',
                        style: new TextStyle (
                          fontSize: 14.0
                        )
                      )
                    ),
                    new Container(
                      margin: new EdgeInsets.only(bottom: 15.0),
                      child: new Text ('- FEATURES 670 ROOMS (MORE THAN ENOUGH ROOMS TO HOST GUESTS)',
                        style: new TextStyle (
                          fontSize: 14.0
                        )
                      )
                    ),
                    new Container(
                      margin: new EdgeInsets.only(bottom: 15.0),
                      child: new Text ('- 5-STAR SERVICE, SECURITY GUARATEED',
                        style: new TextStyle (
                          fontSize: 14.0
                        )
                      )
                    ),
                  ],
                ),
              )
            ]
          )
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
