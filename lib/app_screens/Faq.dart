import 'package:flutter/material.dart';
import 'package:icps/Constants.dart';
import 'package:icps/app_screens/Register.dart';
import 'package:icps/app_screens/drawer/Login.dart';

import 'package:icps/app_screens/popupMenu/Dashboard.dart';
import 'package:icps/app_screens/popupMenu/EditProfile.dart';
import 'package:icps/app_screens/popupMenu/Settings.dart';

class Faq extends StatefulWidget {

  Data data; String password;

  Faq({this.data, this.password});

  @override
  _FaqState createState() => _FaqState();
}

class NewItem {
  bool isExpanded;
  final String header;
  final Widget body;
  NewItem(this.isExpanded, this.header, this.body);
}

enum AuthStatus {
  notSignedIn,
  signedIn,
  signedInSpeaker
}

class _FaqState extends State<Faq> {

  AuthStatus _authStatus = AuthStatus.notSignedIn;

  List<NewItem> items = <NewItem>[
    new NewItem(
        false,
        'What is ICPS?',
        new Padding(
            padding: new EdgeInsets.all(20.0),
            child: new Column(
                children: <Widget>[
                  new Container(
                    child: new Text('ICPS stands for International '
                        'Conference on Payments System',
                      style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0
                      ),
                    ),
                  ),
                ]
            )
        )
    ),
    new NewItem(
        false,
        'When is ICPS 19?',
        new Padding(
            padding: new EdgeInsets.all(20.0),
            child: new Column(
                children: <Widget>[
                  new Container(
                    child: new Text('ICPS 19 is a 2-day conference and '
                        'will start on Tuesday, 3rd September, 2019 and '
                        'end on Wednesdat, 4th September, 2019',
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0
                      ),
                    ),
                  ),
                ]
            )
        )
    ),
    new NewItem(
        false,
        'Where will ICPS 19 hold?',
        new Padding(
            padding: new EdgeInsets.all(20.0),
            child: new Column(
                children: <Widget>[
                  new Container(
                    child: new Text('ICPS 19 will be hosted in Nigeria by the '
                        'Central Bank of Nigeria',
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0
                      ),
                    ),
                  ),
                ]
            )
        )
    ),
    new NewItem(
        false,
        'How do I join attendee list?',
        new Padding(
            padding: new EdgeInsets.all(20.0),
            child: new Column(
                children: <Widget>[
                  new Container(
                    child: new Text('User will have to login in first to join '
                        'attendee list. After login, tap the menu button at '
                        'the top left of the home screen; then '
                        'tap \'Attendees\'. Now, tap the button that '
                        'says \'Join Attendee List\'',
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0
                      ),
                    ),
                  ),
                ]
            )
        )
    ),
    new NewItem(
        false,
        'How do I join cocktail list?',
        new Padding(
            padding: new EdgeInsets.all(20.0),
            child: new Column(
                children: <Widget>[
                  new Container(
                    child: new Text('User will have to login in first to join '
                        'cocktail list. After login, tap the menu button at '
                        'the top left of the home screen; then '
                        'tap \'Extra Activities\'. Next tap \'Cocktail\'; after you have done that, tap the button that '
                        'says \'Join Attendee List\'',
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0
                      ),
                    ),
                  ),
                ]
            )
        )
    ),
    new NewItem(
        false,
        'How do I join exhibitions list?',
        new Padding(
            padding: new EdgeInsets.all(20.0),
            child: new Column(
                children: <Widget>[
                  new Container(
                    child: new Text('User will have to login in first to join '
                        'exhibitions list. After login, tap the menu button at '
                        'the top left of the home screen; then '
                        'tap \'Extra Activities\'. Next tap \'Register for Exhibitions\'; after you have done that, fill out the form and submit.'
                        'We will contact you to give more information',
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0
                      ),
                    ),
                  ),
                ]
            )
        )
    ),
    new NewItem(
        false,
        'How do I join partners list?',
        new Padding(
            padding: new EdgeInsets.all(20.0),
            child: new Column(
                children: <Widget>[
                  new Container(
                    child: new Text('User will have to login in first to join '
                        'partners list. After login, tap the menu button at '
                        'the top left of the home screen; then '
                        'tap \'Extra Activities\'. Next tap \'Register for Partnership\'; after you have done that, fill out the form and submit.'
                        'We will contact you to give more information',
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0
                      ),
                    ),
                  ),
                ]
            )
        )
    ),
    new NewItem(
        false,
        'What are the categories for Partnership with us?',
        new Padding(
            padding: new EdgeInsets.all(20.0),
            child: new Column(
                children: <Widget>[
                  new Container(
                    child: new Text('There are four partnership categories namely:\nPlatinum\nDiamond\nGold\nSiler',
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0
                      ),
                    ),
                  ),
                ]
            )
        )
    ),
    //give all your items here
  ];

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
          title: new Text("FAQ"),
          leading: Builder(
            builder: (context) => IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop (context);
              },
            ),
          ),
          actions: <Widget>[
//            IconButton(icon: Icon(
//              Icons.search
//            ),
//            onPressed: () {},
//            ),
            new PopupMenuButton<String>(
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
            new ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                new Padding(
                  padding: new EdgeInsets.all(10.0),
                  child: new ExpansionPanelList(
                    expansionCallback: (int index, bool isExpanded) {
                      setState(() {
                        items[index].isExpanded = !items[index].isExpanded;
                      });
                    },
                    children: items.map((NewItem item) {
                      return new ExpansionPanel(
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return new ListTile(
                              leading: new CircleAvatar(
                                backgroundImage: new AssetImage('assets/images/logo/icpslogoTwo.png'),
                                backgroundColor: Color.fromRGBO(152, 160, 87, 1),
                              ),
                              title: new Text(
                                item.header,
                                textAlign: TextAlign.left,
                                style: new TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ));
                        },
                        isExpanded: item.isExpanded,
                        body: item.body,
                      );
                    }).toList(),
                  ),
                )
              ],
            )
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
