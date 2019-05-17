import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(MaterialApp (
    home: SpeakerDetailsTwo(),
    theme: ThemeData(
        fontFamily: 'Montserrat'
    ),
  )
  );
}

class SpeakerDetailsTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334, allowFontScaling: true)..init(context);
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(152, 160, 87, 1),
        title: new Text("Speaker\'s Details"),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                padding: new EdgeInsets.only(bottom: 50.0),
                color: Color.fromRGBO(180, 188, 151, 1),
                child: new Center(
                  child: new Container (
                    margin: new EdgeInsets.only(top: 50.0),
                    width: 110.0,
                    height: 110.0,
                    decoration: new BoxDecoration(
                      image: new DecorationImage (
                        image: new AssetImage (
                            'assets/images/speakers/speaker_names/speaker2.PNG'
                        ),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: new BorderRadius.circular(70.0),
                    ),
                  ),
                ),
              ),
              new Center (
                  child: new Container(
                      padding: new EdgeInsets.only(top: 30.0, bottom: 30.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: new BoxDecoration(
                          border: new Border(
                              bottom: new BorderSide(
                                width: 1.0,
                                style: BorderStyle.solid,
                                color: Color.fromRGBO(192, 192, 192, 1),
                              )
                          )
                      ),
                      child: new Row(
                        children: <Widget>[
                          new Container(
                              padding: new EdgeInsets.only(left: 30.0, right: 30.0),
                              child: new Icon(
                                  Icons.person
                              )
                          ),
                          new Container(
                            child: new Text('Blythe Masters',
                              style: new TextStyle(
                                  fontSize: 20.0
                              ),
                            ),
                          )
                        ],
                      )
                  )
              ),
              new Center (
                  child: new Container(
                      padding: new EdgeInsets.only(top: 30.0, bottom: 30.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: new BoxDecoration(
                          border: new Border(
                              bottom: new BorderSide(
                                width: 1.0,
                                style: BorderStyle.solid,
                                color: Color.fromRGBO(192, 192, 192, 1),
                              )
                          )
                      ),
                      child: new Row(
                        children: <Widget>[
                          new Container(
                              padding: new EdgeInsets.only(left: 30.0, right: 30.0),
                              child: new Icon(
                                  Icons.business_center
                              )
                          ),
                          new Container(
                            width: ScreenUtil.getInstance().setWidth(550),
                            child: new Text('Ex JP Morgan Prodigy, Founder, '
                                'Digital Asset Holdings, a Bitcoin Company',
                              style: new TextStyle(
                                  fontSize: ScreenUtil(allowFontScaling: true).setSp(36)
                              ),
                            ),
                          )
                        ],
                      )
                  )
              ),
              new Center (
                  child: new Container(
                      padding: new EdgeInsets.only(top: 30.0, bottom: 30.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: new BoxDecoration(
                          border: new Border(
                              bottom: new BorderSide(
                                width: 1.0,
                                style: BorderStyle.solid,
                                color: Color.fromRGBO(192, 192, 192, 1),
                              )
                          )
                      ),
                      child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Container(
                              padding: new EdgeInsets.only(left: 30.0, right: 30.0),
                              child: new Icon(
                                  Icons.person_pin
                              )
                          ),
                          new Container(
                            width: ScreenUtil.getInstance().setWidth(550),
                            child: new Text('Blythe Masters is one of the '
                                'best-known proponents of blockchain as tool '
                                'for commercial banking systems. But Masters, '
                                'who was a prodigy at JP Morgan, is a '
                                'controversial figure in the community.\n '
                                'While many bitcoin experts want to see '
                                'blockchain used to \" make [the current '
                                'financial system] stronger, better, '
                                'and safer.\" She is perhaps one of '
                                'the best-known advocates for it.\n Masters\' '
                                'company, Digital Asset Holdings, promotes the '
                                'blockchain as a way of streamlining '
                                'financial transactions. By taking the '
                                'intermediatry out of the process, bank could '
                                'theoritically reduce costs and resources with '
                                'their own distributed ledger systems, '
                                'in the same way that bitcoin uses a  shared '
                                'ledger systems, in the same way that bitcoin '
                                'uses a shared ledger instead of a '
                                'central bank record.',
                              style: new TextStyle(
                                  fontSize: ScreenUtil(allowFontScaling: true).setSp(29)
                              ),
                            ),
                          )
                        ],
                      )
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
