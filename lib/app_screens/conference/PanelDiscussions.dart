import 'package:flutter/material.dart';
import 'package:icps/Constants.dart';
import 'package:icps/app_screens/Register.dart';
import 'package:icps/app_screens/drawer/Login.dart';

import 'package:icps/app_screens/popupMenu/Dashboard.dart';
import 'package:icps/app_screens/popupMenu/EditProfile.dart';
import 'package:icps/app_screens/popupMenu/Settings.dart';

class PanelDiscussion extends StatefulWidget {

  Data data;

  PanelDiscussion({this.data});

  @override
  _PanelDiscussionState createState() => _PanelDiscussionState();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
  signedInSpeaker
}

class _PanelDiscussionState extends State<PanelDiscussion> {

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
    return Scaffold (
      appBar: new AppBar (
        backgroundColor: Color.fromRGBO (152, 160, 87, 1),
        title: new Text ("Panel Discussion"),
        actions: <Widget> [
//          IconButton (icon: Icon (
//              Icons.search
//          ),
//            onPressed: () {
//              Navigator.pop (context);
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
        child: Column(
          children: <Widget>[
            new Container(
                padding: new EdgeInsets.only(top: 13.0),
                child: new Center(
                  child: Column(
                    children: <Widget>[
                      new Container(
                        child: new Icon(
                            Icons.accessibility_new,
                            size: 73.0,
                            color: Colors.grey
                        ),
                      ),
                      new Container(
                        child: new Text('Register for Panel Discussion',
                          style: new TextStyle(
                              color: Colors.grey,
                              fontSize: 20.0
                          ),
                        ),
                      ),
                      new Container(
                        padding: new EdgeInsets.only(top: 13.0, left: 64.0, right: 64.0),
                        child: new Text('Log in to join panel discussion and interact with others at the event.',
                          style: new TextStyle(
                              color: Colors.grey,
                              fontSize: 18.0
                          ),
                        ),
                      ),
                      new Container(
                        margin: new EdgeInsets.only(top: 23.0),
                        color: Color.fromRGBO(152, 160, 87, 1),
                        child: new FlatButton(
                            onPressed: null,
                            child: new Text('JOIN PANEL DISCUSSION',
                              style: new TextStyle(
                                  color: Colors.white
                              ),
                            )
                        ),
                      )
                    ],
                  ),
                )
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
