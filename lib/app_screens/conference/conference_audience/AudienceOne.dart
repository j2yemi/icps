import 'package:flutter/material.dart';

class AudienceOne extends StatelessWidget {
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
                        child: new Text ('1. WORLD BANK           ',
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
                            children: <Widget>[
                              new Container(
                                child: new Text('(And Other Multilateral Institutions)'),
                              ),
                              new Container(
                                width: 100.0,
                                height: 50.0,
                                decoration: new BoxDecoration(
                                    image: new DecorationImage(
                                      image: new AssetImage(
                                          'assets/images/conference/conference_audience/icpsWorldBank.PNG'
                                      ),
                                      fit: BoxFit.contain,
                                    )
                                ),
                              )
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
                        child: new Text ('2. CENTRAL BANKS   ',
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
                              child: new Text('- Central Bank of Nigeria (CBN)'),
                            ),
                            new Container(
                              margin: new EdgeInsets.only(bottom: 5.0),
                              child: new Text('- Other Central Banks (in Africa), including...'),
                            ),
                            new Container(
                              margin: new EdgeInsets.only(bottom: 5.0),
                              child: new Text('- Reserve Bank of South Africa'),
                            ),
                            new Container(
                              margin: new EdgeInsets.only(bottom: 5.0),
                              child: new Text('- Bank Negara, etc.'),
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
                        child: new Text ('3. FINANCIAL REGULATORS',
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
                                child: new Text('- Central Bank of Nigeria'),
                              ),
                              new Container(
                                margin: new EdgeInsets.only(bottom: 5.0),
                                child: new Text('- Other Central Banks (in Africa)'),
                              ),
                              new Container(
                                margin: new EdgeInsets.only(bottom: 5.0),
                                child: new Text('- NSE'),
                              ),
                              new Container(
                                margin: new EdgeInsets.only(bottom: 5.0),
                                child: new Text('- SEC'),
                              ),
                              new Container(
                                margin: new EdgeInsets.only(bottom: 5.0),
                                child: new Text('- PENCOM'),
                              ),
                              new Container(
                                margin: new EdgeInsets.only(bottom: 5.0),
                                child: new Text('- NAICOM'),
                              ),
                              new Container(
                                margin: new EdgeInsets.only(bottom: 5.0),
                                child: new Text('- NDIC'),
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
                        child: new Text ('4. DEPOSIT MONEY BANKS',
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
                              child: new Text('- All Nigerian banks'),
                            ),
                            new Container(
                              margin: new EdgeInsets.only(bottom: 5.0),
                              child: new Text('- International players like:'),
                            ),
                            new Container(
                              margin: new EdgeInsets.only(bottom: 5.0),
                              child: new Text('    - CITI Bank'),
                            ),
                            new Container(
                              margin: new EdgeInsets.only(bottom: 5.0),
                              child: new Text('    - JP Morgan'),
                            ),
                            new Container(
                              margin: new EdgeInsets.only(bottom: 5.0),
                              child: new Text('    - Standard Bank of South Africa'),
                            ),
                            new Container(
                              margin: new EdgeInsets.only(bottom: 5.0),
                              child: new Text('    - Rand Merchant Bank, etc.'),
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
