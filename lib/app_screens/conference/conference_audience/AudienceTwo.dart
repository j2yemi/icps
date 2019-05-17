import 'package:flutter/material.dart';

class AudienceTwo extends StatelessWidget {
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
                        child: new Text ('5. MOBILE MONEY OPERATORS',
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
                                child: new Text('- Paga (PagaTech)'),
                              ),
                              new Container(
                                margin: new EdgeInsets.only(bottom: 5.0),
                                child: new Text('- PocketMoni (ETranzact)'),
                              ),
                              new Container(
                                margin: new EdgeInsets.only(bottom: 5.0),
                                child: new Text('- AfriPay (UMO)'),
                              ),
                              new Container(
                                margin: new EdgeInsets.only(bottom: 5.0),
                                child: new Text('- EazyMoney (Zenith Bank)'),
                              ),
                              new Container(
                                margin: new EdgeInsets.only(bottom: 5.0),
                                child: new Text('- FortisMobileMoney'),
                              ),
                              new Container(
                                margin: new EdgeInsets.only(bottom: 5.0),
                                child: new Text('- FirstMonie (First Bank)'),
                              ),
                              new Container(
                                margin: new EdgeInsets.only(bottom: 5.0),
                                child: new Text('- *909#Stanbic Mobile Money'),
                              ),
                              new Container(
                                margin: new EdgeInsets.only(bottom: 5.0),
                                child: new Text('- GTMobileMoney'),
                              ),
                              new Container(
                                margin: new EdgeInsets.only(bottom: 5.0),
                                child: new Text('- Cellulant'),
                              ),
                              new Container(
                                margin: new EdgeInsets.only(bottom: 5.0),
                                child: new Text('- Tigo (Ghana)'),
                              ),
                              new Container(
                                margin: new EdgeInsets.only(bottom: 5.0),
                                child: new Text('- Mpesa (Kenya)'),
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
                        child: new Text ('6. PAYMENT TERMINALS SERVICE PROVIDERS',
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
                              child: new Text('- Unified Payment System'),
                            ),
                            new Container(
                              margin: new EdgeInsets.only(bottom: 5.0),
                              child: new Text('- Paystacks'),
                            ),
                            new Container(
                              margin: new EdgeInsets.only(bottom: 5.0),
                              child: new Text('- Citiserve'),
                            ),
                            new Container(
                              margin: new EdgeInsets.only(bottom: 5.0),
                              child: new Text('- e-Top'),
                            ),
                            new Container(
                              margin: new EdgeInsets.only(bottom: 5.0),
                              child: new Text('- Paymaster'),
                            ),
                            new Container(
                              margin: new EdgeInsets.only(bottom: 5.0),
                              child: new Text('- Itex'),
                            ),
                            new Container(
                              margin: new EdgeInsets.only(bottom: 5.0),
                              child: new Text('- Easyfuel'),
                            ),
                            new Container(
                              margin: new EdgeInsets.only(bottom: 5.0),
                              child: new Text('- Global Accelerex'),
                            ),
                            new Container(
                              margin: new EdgeInsets.only(bottom: 5.0),
                              child: new Text('- Brinq'),
                            ),
                            new Container(
                              margin: new EdgeInsets.only(bottom: 5.0),
                              child: new Text('- Globasure'),
                            ),
                            new Container(
                              margin: new EdgeInsets.only(bottom: 5.0),
                              child: new Text('- PayCom'),
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
