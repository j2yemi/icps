import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(MaterialApp (
    home: SpeakerDetailsFour(),
    theme: ThemeData(
        fontFamily: 'Montserrat'
    ),
  )
  );
}

class SpeakerDetailsFour extends StatelessWidget {
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
                            'assets/images/speakers/speaker_names/speaker4.jpg'
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
                            child: new Text('Sola Akindale',
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
                            child: new Text('Co-founder/CEO, Paystack',
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
                            child: new Text('Sola Akinlade is the cofounder '
                                'and the CEO of Paystack; a modern payments '
                                'platform that allows Nigerian merchants to '
                                'receive funds from anyone, anywhere in the '
                                'world. Paystack help African go toe to toe '
                                'with the best companies on the planet, '
                                'and win. The platform serves over '
                                '17,000 businesses, and process over 15% of '
                                'all online payments in Nigeria.\n'
                                'Paystack is proudly Nigerian, entirely '
                                'designed and built in the dynamic, '
                                'entrepreneurial city of Lagos! ',
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
