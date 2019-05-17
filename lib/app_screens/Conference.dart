import 'package:flutter/material.dart';
import 'package:icps/app_screens/conference/ConferenceSurvey.dart';
// import 'package:icps/app_screens/HomePage.dart';
import 'package:icps/app_screens/conference/ConferenceObjectives.dart';
import 'package:icps/app_screens/conference/ConferenceHighlights.dart';
import 'package:icps/app_screens/conference/ConferenceTheme.dart';
import 'package:icps/app_screens/conference/ConferenceAudience.dart';
import 'package:icps/app_screens/conference/ConferencePaper.dart';

void main() {
  runApp(MaterialApp (
    home: Conference(),
    theme: ThemeData(
        fontFamily: 'Montserrat'
    ),
  )
  );
}

class Conference extends StatelessWidget {
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
          IconButton(icon: Icon(
              Icons.search
          ),
            onPressed: () {

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
                    MaterialPageRoute(builder: (context) => ConferenceObjectives())
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
                    MaterialPageRoute(builder: (context) => ConferenceHighlights())
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
                    MaterialPageRoute(builder: (context) => ConferenceTheme())
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
                    MaterialPageRoute(builder: (context) => ConferenceAudience())
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
                    MaterialPageRoute(builder: (context) => ConferencePaper())
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
                    MaterialPageRoute(builder: (context) => ConferenceSurvey())
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
}
