import 'package:flutter/material.dart';
// import 'package:icps/app_screens/Conference.dart';

void main() {
  runApp(MaterialApp (
    home: CentreDescription(),
    theme: ThemeData(
        fontFamily: 'Montserrat'
    ),
  )
  );
}

class CentreDescription extends StatelessWidget {
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
          IconButton(icon: Icon(
              Icons.search
          ),
            onPressed: () {

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
}
