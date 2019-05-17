import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(MaterialApp (
    home: SpeakerDetailsThree(),
    theme: ThemeData(
        fontFamily: 'Montserrat'
    ),
  )
  );
}

class SpeakerDetailsThree extends StatelessWidget {
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
                            'assets/images/speakers/speaker_names/speaker3.jpg'
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
                            child: new Text('Mr. Godwin Emefiele',
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
                            child: new Text('Governor, Central Bank of Nigeria',
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
                            child: new Text('Godwin Emefiele has been '
                                'Governor of the Central Bank of Nigeria '
                                'since June 3, 2014. He served as '
                                'Chief Executive officer and '
                                'Group Managing Director of Zenith Bank Plc. '
                                'Emefiele served as Deputy Managing Director '
                                'of Zenith Bank Plc. since 2001. He served as '
                                'Executive Director in charge of Corporate '
                                'Banking, Treasury, Financial Control and '
                                'Strategic Planning of Zenith Bank Plc and has '
                                'been on the Management team since inception. '
                                'Emefiele has over eighteen years of banking '
                                'experience. Emefiele served as director at '
                                'Zenith Bank Plc and Zenith Bank (Gambia) '
                                'Limited. Before commencing his banking career,'
                                ' he lectured Finance and Insurance at the '
                                'University of Nigeria Nsukka, and University '
                                'of Port Harcourt, respectively. Emefiele '
                                'serves as Director of ACCION Microfinance '
                                'Bank Limited. He is also an alumnus of '
                                'Executive Education at Stanford University, '
                                'Harvard University (2004) and Wharton '
                                'School of Business (2005). Emefiele holds a '
                                'B.Sc. degree in Finance[3] 1984 and an MBA '
                                'Degree in Finance in 1986, both from the '
                                'University of Nigeria, Nsukka.',
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
