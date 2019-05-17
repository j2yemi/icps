import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(MaterialApp (
    home: SpeakerDetails(),
    theme: ThemeData(
        fontFamily: 'Montserrat'
    ),
  )
  );
}

class SpeakerDetails extends StatelessWidget {
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
                          'assets/images/speakers/speaker_names/speaker1b.jpg'
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
                        child: new Text('Aboyeji Iyinoluwa',
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
                            child: new Text('Co-Founder, Andela, '
                                'Flutterwave, Capital Street',
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
                            child: new Text('Aboyeji Iyinoluwa, is a Nigerian '
                                'entrepreneur. He is a co-founder of Andela, '
                                'and was the former managing director of '
                                'Flutterwave, a payments company to connect '
                                'Africa to the global economy. Flutterwave is '
                                'one of the fastest growing payments technology '
                                'businesses, processing over \$2 billion across '
                                'over 50 million transaction with annual '
                                'revenues of millions of dollars a year. '
                                'Aboyeji\'s previous startup Andela, gained '
                                'attention when the venture received \$24 '
                                'million in funding from Mark Zuckerberg and '
                                'Google Ventures amongst others. '
                                'He was born 1991.',
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
