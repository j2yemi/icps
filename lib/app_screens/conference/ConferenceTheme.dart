import 'package:flutter/material.dart';
// import 'package:icps/app_screens/Conference.dart';
import 'package:icps/Constants.dart';
import 'package:icps/app_screens/Register.dart';
import 'package:icps/app_screens/drawer/Login.dart';

import 'package:icps/app_screens/popupMenu/Dashboard.dart';
import 'package:icps/app_screens/popupMenu/EditProfile.dart';
import 'package:icps/app_screens/popupMenu/Settings.dart';

class ConferenceTheme extends StatefulWidget {

  Data data; String password;

  ConferenceTheme({this.data, this.password});

  @override
  _ConferenceThemeState createState() => _ConferenceThemeState();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
  signedInSpeaker
}

class _ConferenceThemeState extends State<ConferenceTheme>
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
        title: new Text("Conference Theme"),
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
                        'assets/images/logo/icpslogo.png'
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              new Container(
                padding: new EdgeInsets.all(10.0),
                child: new Text(
                  'Conference Theme - '
                      'THE IMPACT OF ELECTRONIC PAYMENTS ON ECONOMIC GROWTH',
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
                child: new Text ('HOW DIGITAL TOOLS COULD BE A DECISIVE FACTOR '
                    'IN MEETING THE  2030 SUSTAINABLE DEVELOPMENT GOALS '
                )
              ),
            ],
          ),
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
