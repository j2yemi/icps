import 'package:flutter/material.dart';

class HighlightsTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: new Column(
        children: <Widget>[
          new Container(
            margin: new EdgeInsets.only(top: 20.0, bottom: 20.0),
            width: MediaQuery.of(context).size.width,
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new Container(
                  width: 154.0,
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        padding: new EdgeInsets.all(10.0),
                        color: Color.fromRGBO(25, 110, 42, 1),
                        child: new Text ('OBJECTIVE SPECIFIC',
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
                        child: new Text('Speakers address specific areas of the conference objectives'),
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
                        child: new Text ('EXHIBITIONS               ',
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
                        child: new Text('Exhibition stands for interested '
                            'vendors/providers to showcase their products'
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          new Container(
            margin: new EdgeInsets.only(top: 20.0, bottom: 20.0, left: 25.0),
            width: MediaQuery.of(context).size.width,
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                  width: 151.0,
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        padding: new EdgeInsets.all(10.0),
                        color: Color.fromRGBO(25, 110, 42, 1),
                        child: new Text ('GALA NIGHT               ',
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
                        child: new Text('Conference Dinner/Gala Night'),
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
