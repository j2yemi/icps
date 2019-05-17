import 'package:flutter/material.dart';
import 'package:icps/Constants.dart';
import 'package:icps/app_screens/Register.dart';
import 'package:icps/app_screens/drawer/Login.dart';

import 'package:icps/app_screens/popupMenu/Dashboard.dart';
import 'package:icps/app_screens/popupMenu/EditProfile.dart';
import 'package:icps/app_screens/popupMenu/Settings.dart';

class ConferenceObjectives extends StatefulWidget {

  Data data; String password;

  ConferenceObjectives({this.data, this.password});

  @override
  _ConferenceObjectivesState createState() => _ConferenceObjectivesState();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
  signedInSpeaker
}

class _ConferenceObjectivesState extends State<ConferenceObjectives>
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
    return Scaffold (
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(152, 160, 87, 1),
        title: new Text("Key Conference Objectives"),
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
//            Icons.search
//            ),
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
          margin: new EdgeInsets.all(25.0),
          child: new Column(
          children: <Widget>[
            new Container(
              margin: new EdgeInsets.only(bottom: 45.0),
              child: new Row(
                children: <Widget>[
                  new Container(
                    padding: new EdgeInsets.only(right: 10.0),
                    decoration: new BoxDecoration(
                      border: new Border(
                        right: new BorderSide(
                            style: BorderStyle.solid,
                            width: 2.0,
                            color: Colors.grey
                        ),
                      )
                    ),
                    child: new Container(
                      padding: new EdgeInsets.all(25.0),
                      decoration: new BoxDecoration(
                        color: Color.fromRGBO(247, 185, 0, 1),
                        border: new Border(
                          top: new BorderSide(
                            style: BorderStyle.solid,
                            width: 2.0,
                            color: Colors.grey
                          ),
                          left: new BorderSide(
                              style: BorderStyle.solid,
                              width: 2.0,
                              color: Colors.grey
                          ),
                          right: new BorderSide(
                              style: BorderStyle.solid,
                              width: 2.0,
                              color: Colors.grey
                          ),
                          bottom: new BorderSide(
                              style: BorderStyle.solid,
                              width: 2.0,
                              color: Colors.grey
                          ),
                        )
                      ),
                      child: new Text('REFLECT',
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 16.0
                        ),
                      ),
                    ),
                  ),
                  new Container(
                    width: 200.0,
                    margin: new EdgeInsets.only(left: 10.0),
                    padding: new EdgeInsets.all(5.0),
                    child: new Text('To review the journey of Nigeria\'s '
                        'payment system, and present the progress made '
                        'so far to the world'
                    ),
                  ),
                ],
              ),
            ),
            new Container(
              margin: new EdgeInsets.only(bottom: 45.0),
              child: new Row(
                children: <Widget>[
                  new Container(
                    padding: new EdgeInsets.only(right: 10.0),
                    decoration: new BoxDecoration(
                        border: new Border(
                          right: new BorderSide(
                              style: BorderStyle.solid,
                              width: 2.0,
                              color: Colors.grey
                          ),
                        )
                    ),
                    child: new Container(
                      padding: new EdgeInsets.all(25.0),
                      decoration: new BoxDecoration(
                          color: Color.fromRGBO(22, 52, 90, 1),
                          border: new Border(
                            top: new BorderSide(
                                style: BorderStyle.solid,
                                width: 2.0,
                                color: Colors.grey
                            ),
                            left: new BorderSide(
                                style: BorderStyle.solid,
                                width: 2.0,
                                color: Colors.grey
                            ),
                            right: new BorderSide(
                                style: BorderStyle.solid,
                                width: 2.0,
                                color: Colors.grey
                            ),
                            bottom: new BorderSide(
                                style: BorderStyle.solid,
                                width: 2.0,
                                color: Colors.grey
                            ),
                          )
                      ),
                      child: new Text('LEARN     ',
                        style: new TextStyle(
                            color: Colors.white,
                            fontSize: 16.0
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  new Container(
                    width: 200.0,
                    padding: new EdgeInsets.all(15.0),
                    child: new Text('To validate our experience against global '
                        'practise and learn from other climes on payments system'
                    ),
                  ),
                ],
              ),
            ),
            new Container(
              margin: new EdgeInsets.only(bottom: 45.0),
              child: new Row(
                children: <Widget>[
                  new Container(
                    padding: new EdgeInsets.only(right: 10.0),
                    decoration: new BoxDecoration(
                        border: new Border(
                          right: new BorderSide(
                              style: BorderStyle.solid,
                              width: 2.0,
                              color: Colors.grey
                          ),
                        )
                    ),
                    child: new Container(
                      padding: new EdgeInsets.all(25.0),
                      decoration: new BoxDecoration(
                          color: Color.fromRGBO(0, 98, 0, 1),
                          border: new Border(
                            top: new BorderSide(
                                style: BorderStyle.solid,
                                width: 2.0,
                                color: Colors.grey
                            ),
                            left: new BorderSide(
                                style: BorderStyle.solid,
                                width: 2.0,
                                color: Colors.grey
                            ),
                            right: new BorderSide(
                                style: BorderStyle.solid,
                                width: 2.0,
                                color: Colors.grey
                            ),
                            bottom: new BorderSide(
                                style: BorderStyle.solid,
                                width: 2.0,
                                color: Colors.grey
                            ),
                          )
                      ),
                      child: new Text('PROSPECT',
                        style: new TextStyle(
                            color: Colors.white,
                            fontSize: 16.0
                        ),
                      ),
                    ),
                  ),
                  new Container(
                    width: 190.0,
                    padding: new EdgeInsets.all(15.0),
                    child: new Text('To chart a vision for the next phase of '
                        'payment advancement in Nigeria towards the '
                        'actualisation of 2030 SDG.'
                    ),
                  ),
                ],
              ),
            ),
            new Container(
              child: new Text('ICPS 2019 WILL CREATE OPPORTUNITIES FOR NEW '
                  'PLAYERS IN PAYMENTS SYSTEM, CREATE NEW INVESTMENTS; AND IT '
                  'WILL BE A PLATFORM WHERE INNOVATORS INTERACT '
                  'WITH THE INVESTORS.',
                style: new TextStyle(
                  fontSize: 18.0
                ),
              ),
            )
          ],
          )
        )
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
