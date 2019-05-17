import 'package:flutter/material.dart';
// import 'package:icps/app_screens/HomePage.dart';
import 'package:icps/app_screens/maps/ConferenceCentre.dart';
import 'package:icps/app_screens/maps/Hotels.dart';
import 'package:icps/app_screens/maps/Airports.dart';
import 'package:icps/app_screens/maps/FunAttractions.dart';

void main() {
  runApp(MaterialApp (
    home: Locations(),
    theme: ThemeData(
      fontFamily: 'Montserrat'
    ),
  )
  );
}

class Locations extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(152, 160, 87, 1),
        title: new Text("Locations"),
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
                  MaterialPageRoute(builder: (context) => ConferenceCentre())
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
                      child: new Icon(Icons.domain),
                    ),
                    new Text('Conference Center',
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
                  MaterialPageRoute(builder: (context) => Hotels())
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
                      child: new Icon(Icons.hotel),
                    ),
                    new Text('Hotels',
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
                  MaterialPageRoute(builder: (context) => Airports())
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
                      child: new Icon(Icons.local_airport),
                    ),
                    new Text('Airports',
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
                  MaterialPageRoute(builder: (context) => FunAttractions())
                );
              },
              child: new Container (
                width: MediaQuery.of(context).size.width,
                padding: new EdgeInsets.only (left: 20.0, top: 30.0, bottom: 30.0),
                child: new Row(
                  children: <Widget>[
                    new Container(
                      margin: new EdgeInsets.only(right: 34.0),
                      child: new Icon(Icons.casino),
                    ),
                    new Text('Fun Attractions',
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
}
