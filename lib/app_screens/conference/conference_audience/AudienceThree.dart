import 'package:flutter/material.dart';

class AudienceThree extends StatelessWidget {
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
                  width: 160.0,
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        padding: new EdgeInsets.all(10.0),
                        color: Color.fromRGBO(25, 110, 42, 1),
                        child: new Text ('7. SWITCHES                 ',
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
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Container(
                                margin: new EdgeInsets.only(bottom: 5.0),
                                child: new Text('- InterSwitch'),
                              ),
                              new Container(
                                margin: new EdgeInsets.only(bottom: 5.0),
                                child: new Text('- Unified Payment System'),
                              ),
                              new Container(
                                margin: new EdgeInsets.only(bottom: 5.0),
                                child: new Text('- ETranzact'),
                              ),
                              new Container(
                                margin: new EdgeInsets.only(bottom: 5.0),
                                child: new Text('- NIBSS'),
                              ),
                            ],
                          )
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
                        child: new Text ('8. SOLUTION PROVIDERS',
                          style: new TextStyle(
                              color: Colors.white
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      new Container(
                        width: 155.0,
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
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Container(
                              margin: new EdgeInsets.only(bottom: 5.0),
                              child: new Text('- SystemSpecs'),
                            ),
                            new Container(
                              margin: new EdgeInsets.only(bottom: 5.0),
                              child: new Text('- Chams'),
                            ),
                            new Container(
                              margin: new EdgeInsets.only(bottom: 5.0),
                              child: new Text('- ROE'),
                            ),
                            new Container(
                              margin: new EdgeInsets.only(bottom: 5.0),
                              child: new Text('- NCR'),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          new Container(
            margin: new EdgeInsets.only(top: 35.0, bottom: 35.0),
            width: MediaQuery.of(context).size.width,
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new Container(
                  width: 160.0,
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        padding: new EdgeInsets.all(10.0),
                        color: Color.fromRGBO(25, 110, 42, 1),
                        child: new Text ('9. INTEGRATORS          ',
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
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Container(
                                margin: new EdgeInsets.only(bottom: 5.0),
                                child: new Text('- InterSwitch'),
                              ),
                              new Container(
                                margin: new EdgeInsets.only(bottom: 5.0),
                                child: new Text('- MasterCard'),
                              ),
                              new Container(
                                margin: new EdgeInsets.only(bottom: 5.0),
                                child: new Text('- Unified Payment System'),
                              ),
                              new Container(
                                margin: new EdgeInsets.only(bottom: 5.0),
                                child: new Text('- ETranzact'),
                              ),
                            ],
                          )
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
                        child: new Text ('10. INVESTMENT WINDOWS',
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
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Container(
                              margin: new EdgeInsets.only(bottom: 5.0),
                              child: new Text('- Citi Bank'),
                            ),
                            new Container(
                              margin: new EdgeInsets.only(bottom: 5.0),
                              child: new Text('- Renaissance Capitals'),
                            ),
                            new Container(
                              margin: new EdgeInsets.only(bottom: 5.0),
                              child: new Text('- JP Morgan'),
                            ),
                            new Container(
                              margin: new EdgeInsets.only(bottom: 5.0),
                              child: new Text('- Standard Bank'),
                            ),
                            new Container(
                              margin: new EdgeInsets.only(bottom: 5.0),
                              child: new Text('- Rand Merchant Bank'),
                            ),
                            new Container(
                              margin: new EdgeInsets.only(bottom: 5.0),
                              child: new Text('- HSBC'),
                            ),
                          ],
                        ),
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
