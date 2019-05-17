import 'package:flutter/material.dart';

class HighlightsOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: new Column(
        children: <Widget>[
          new Container(
            margin: new EdgeInsets.only(top: 35.0, bottom: 35.0),
            width: MediaQuery.of(context).size.width,
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new Container(
                  width: 151.0,
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        padding: new EdgeInsets.all(10.0),
                        color: Color.fromRGBO(25, 110, 42, 1),
                        child: new Text ('NEWS CONFERENCE',
                          style: new TextStyle(
                              color: Colors.white
                          ),
                        ),
                      ),
                      new Container(
                        padding: new EdgeInsets.all(7.0),
                        decoration: new BoxDecoration(
                            border: new Border(
                              left: new BorderSide(
                                  style: BorderStyle.solid,
                                  width: 2.0,
                                  color: Color.fromRGBO(25, 110, 42, 1)
                              ),
                              right: new BorderSide(
                                  style: BorderStyle.solid,
                                  width: 2.0,
                                  color: Color.fromRGBO(25, 110, 42, 1)
                              ),
                              bottom: new BorderSide(
                                  style: BorderStyle.solid,
                                  width: 2.0,
                                  color: Color.fromRGBO(25, 110, 42, 1)
                              ),
                            )
                        ),
                        child: new Text('Pre-conference world news conference '
                            'to be hosted by CBN'),
                      )
                    ],
                  ),
                ),
                new Container(
                  width: 155.0,
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        padding: new EdgeInsets.all(10.0),
                        color: Color.fromRGBO(25, 110, 42, 1),
                        child: new Text ('MEDIA BLITZ               ',
                          style: new TextStyle(
                              color: Colors.white
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      new Container(
                        padding: new EdgeInsets.all(7.0),
                        decoration: new BoxDecoration(
                            border: new Border(
                              left: new BorderSide(
                                  style: BorderStyle.solid,
                                  width: 2.0,
                                  color: Color.fromRGBO(25, 110, 42, 1)
                              ),
                              right: new BorderSide(
                                  style: BorderStyle.solid,
                                  width: 2.0,
                                  color: Color.fromRGBO(25, 110, 42, 1)
                              ),
                              bottom: new BorderSide(
                                  style: BorderStyle.solid,
                                  width: 2.0,
                                  color: Color.fromRGBO(25, 110, 42, 1)
                              ),
                            )
                        ),
                        child: new Text('Media blits through the local and international media'),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          new Container(
            margin: new EdgeInsets.only(top: 20.0, bottom: 20.0),
            width: MediaQuery.of(context).size.width,
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new Container(
                  width: 151.0,
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        padding: new EdgeInsets.all(10.0),
                        color: Color.fromRGBO(25, 110, 42, 1),
                        child: new Text ('OPENING SPEECH     ',
                          style: new TextStyle(
                              color: Colors.white
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      new Container(
                        padding: new EdgeInsets.all(7.0),
                        decoration: new BoxDecoration(
                            border: new Border(
                              left: new BorderSide(
                                  style: BorderStyle.solid,
                                  width: 2.0,
                                  color: Color.fromRGBO(25, 110, 42, 1)
                              ),
                              right: new BorderSide(
                                  style: BorderStyle.solid,
                                  width: 2.0,
                                  color: Color.fromRGBO(25, 110, 42, 1)
                              ),
                              bottom: new BorderSide(
                                  style: BorderStyle.solid,
                                  width: 2.0,
                                  color: Color.fromRGBO(25, 110, 42, 1)
                              ),
                            )
                        ),
                        child: new Text('CBN Governor gives keynote address, '
                            'opens conference'),
                      )
                    ],
                  ),
                ),
                new Container(
                  width: 168.0,
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        padding: new EdgeInsets.all(10.0),
                        color: Color.fromRGBO(25, 110, 42, 1),
                        child: new Text ('PRESIDENT\'S ADDRESS',
                          style: new TextStyle(
                              color: Colors.white
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      new Container(
                        padding: new EdgeInsets.all(7.0),
                        decoration: new BoxDecoration(
                            border: new Border(
                              left: new BorderSide(
                                  style: BorderStyle.solid,
                                  width: 2.0,
                                  color: Color.fromRGBO(25, 110, 42, 1)
                              ),
                              right: new BorderSide(
                                  style: BorderStyle.solid,
                                  width: 2.0,
                                  color: Color.fromRGBO(25, 110, 42, 1)
                              ),
                              bottom: new BorderSide(
                                  style: BorderStyle.solid,
                                  width: 2.0,
                                  color: Color.fromRGBO(25, 110, 42, 1)
                              ),
                            )
                        ),
                        child: new Text('President speech on payment as a tool for economic growth'),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          new Container(
            margin: new EdgeInsets.only(top: 20.0, bottom: 20.0),
            width: MediaQuery.of(context).size.width,
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new Container(
                  width: 151.0,
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        padding: new EdgeInsets.all(10.0),
                        color: Color.fromRGBO(25, 110, 42, 1),
                        child: new Text ('EXECUTIVE FORUM     ',
                          style: new TextStyle(
                              color: Colors.white
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      new Container(
                        padding: new EdgeInsets.all(7.0),
                        decoration: new BoxDecoration(
                            border: new Border(
                              left: new BorderSide(
                                  style: BorderStyle.solid,
                                  width: 2.0,
                                  color: Color.fromRGBO(25, 110, 42, 1)
                              ),
                              right: new BorderSide(
                                  style: BorderStyle.solid,
                                  width: 2.0,
                                  color: Color.fromRGBO(25, 110, 42, 1)
                              ),
                              bottom: new BorderSide(
                                  style: BorderStyle.solid,
                                  width: 2.0,
                                  color: Color.fromRGBO(25, 110, 42, 1)
                              ),
                            )
                        ),
                        child: new Text('Central Bank Governors forum/convergence'),
                      )
                    ],
                  ),
                ),
                new Container(
                  width: 155.0,
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        padding: new EdgeInsets.all(10.0),
                        color: Color.fromRGBO(25, 110, 42, 1),
                        child: new Text ('PRESENTATIONS        ',
                          style: new TextStyle(
                              color: Colors.white
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      new Container(
                        padding: new EdgeInsets.all(7.0),
                        decoration: new BoxDecoration(
                            border: new Border(
                              left: new BorderSide(
                                  style: BorderStyle.solid,
                                  width: 2.0,
                                  color: Color.fromRGBO(25, 110, 42, 1)
                              ),
                              right: new BorderSide(
                                  style: BorderStyle.solid,
                                  width: 2.0,
                                  color: Color.fromRGBO(25, 110, 42, 1)
                              ),
                              bottom: new BorderSide(
                                  style: BorderStyle.solid,
                                  width: 2.0,
                                  color: Color.fromRGBO(25, 110, 42, 1)
                              ),
                            )
                        ),
                        child: new Text('Paper presentations/Technical sessions/Break-out sessions'),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
