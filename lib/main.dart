import 'package:flutter/material.dart';
import 'package:icps/app_screens/HomePage.dart';
import 'package:icps/CountDown.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';
//import 'dart:math' as math;

void main() {
  runApp(MaterialApp (
    debugShowCheckedModeBanner: false,
      home: MyApp(),
    )
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{

  @override
  void initState()
  {
    super.initState();
    Future.delayed (Duration(seconds: 7),
            () {
          Navigator.push (context, MaterialPageRoute(builder: (context) => CountDown(),
          ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334, allowFontScaling: true)..init(context);
    return Scaffold(
      body: new Stack (
          children: <Widget>[
            new Container (
              decoration: new BoxDecoration(
                image: new DecorationImage(image: new AssetImage('assets/images/splash/SplashBg.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            new Container (
                decoration: new BoxDecoration(
                  image: new DecorationImage(image: new AssetImage('assets/images/logo/icpslogoTwo.png'),
                  ),
                  color: Color.fromRGBO(180, 188, 151, 0.8),
                ),
            ),
//            new Center(
//              child: new Container (
//                margin: new EdgeInsets.only(top: 454.0),
//                width: ScreenUtil.getInstance().setWidth(335),
//                decoration: new BoxDecoration(
//                  color: Colors.blueAccent[400]
//                ),
//                child: new FlatButton(
//                  onPressed: () {
//                    Navigator.push (context, MaterialPageRoute(builder: (context) => CountDown()));
//                  },
//                  child: new Text('Get Started',
//                    style: new TextStyle(
//                      color: Colors.white,
//                      fontSize: ScreenUtil(allowFontScaling: true).setSp(31)
//                    ),
//                  ),
//
//                ),
//              )
//            )
  //          ),
  //          new Container(
  //            child: new MaterialButton(
  //              height: 50.0,
  //              minWidth: 70.0,
  //              margin: const EdgeInsets.all(4),
  //              color: Theme.of(context).primaryColor,
  //              textColor: Colors.white,
  //              child: new Text("Get Started"),
  //              onPressed: () => {},
  //              splashColor: Colors.blueGrey,
  //            )


          ],
        )

    );
  }
}

