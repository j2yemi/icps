import 'package:flutter/material.dart';
import 'package:icps/app_screens/HomePage.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;

void main() {
  runApp(
    MaterialApp(
      home: CountDown(),
      theme: ThemeData(
        canvasColor: Color.fromRGBO(180, 188, 151, 0.8),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        accentColor: Color.fromRGBO(25, 110, 42, 1),
        brightness: Brightness.dark,
      ),
    )
  );
}

class CountDown extends StatefulWidget {
  @override
  _CountDownState createState() => _CountDownState();
}

class _CountDownState extends State<CountDown> with SingleTickerProviderStateMixin  {

  AnimationController controller;

  String get timerString
  {
    Duration duration = controller.duration * controller.value;
    return '${(duration.inDays).toString().padLeft(2, '0')}:${(duration.inHours % 24).toString().padLeft(2, '0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  var differenceInSeconds = DateTime(2019, DateTime.september, 3).difference(DateTime.now()).inSeconds;

  @override
  void initState()
  {
    super.initState();
//    Future.delayed (Duration(seconds: 7),
//            () {
//          Navigator.push (context, MaterialPageRoute(builder: (context) => HomePage(),
//          ),
//          );
//        }
//    );

    controller = AnimationController(
        vsync: this,
        duration: Duration(seconds: differenceInSeconds)
    );

    controller.reverse(from: controller.value == 0.0 ? 1.0 : controller.value);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334, allowFontScaling: true)..init(context);
    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: new Stack(
          children: <Widget> [
            new Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage(
                      'assets/images/splash/SplashBg.jpg'
                  ),
                  fit: BoxFit.cover
                ),
                color: Color.fromRGBO(180, 188, 151, 0.8),
              ),
            ),
            new Container(
            decoration: new BoxDecoration(
              color: Color.fromRGBO(180, 188, 151, 0.8),
            ),
              child: new Padding(
                padding: new EdgeInsets.all(8.0),
                child:new Column (
                  children: <Widget> [
                    new Expanded(
                      child: new Align(
                        alignment: FractionalOffset.center,
                        child: new AspectRatio(
                          aspectRatio: 1.0,
                          child: new Stack (
                            children: <Widget>[
    //                          new Positioned.fill(
    //                            child: new AnimatedBuilder(
    //                              animation: controller,
    //                              builder: (BuildContext context, Widget child) {
    //                                return CustomPaint(
    //                                  painter: TimerPainter(
    //                                    animation: controller,
    //                                    backgroundColor: Color.fromRGBO(180, 188, 151, 0.8),
    //                                    color: themeData.indicatorColor,
    //                                  ));
    //                              },
    //                            ),
    //                          ),
                              Align(
                                alignment: FractionalOffset.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    new Text(
                                      "Count Down to ICPS 2019",
                                      style: new TextStyle(
                                        color: Colors.white,
                                        fontSize: ScreenUtil(allowFontScaling: true).setSp(38)
                                      ),
                                    ),
                                    new Container(
                                      child: new Text(
                                        'Days : Hours : Mins : Sec',
                                        style: new TextStyle(
                                          color: Colors.white,
                                          fontSize: ScreenUtil(allowFontScaling: true).setSp(48)
                                        ),
                                      ),
                                    ),
                                    AnimatedBuilder(
                                      animation: controller,
                                      builder: (BuildContext context, Widget child) {
                                        return Text(
                                          timerString,
                                          style: new TextStyle(
                                              color: Color.fromRGBO(25, 110, 42, 1),
                                              fontSize: ScreenUtil(allowFontScaling: true).setSp(98)
                                          ),
                                        );
                                      }
                                    ),
                                  ],
                                ),
                              ),
                            ]
                          )
                        )
                      )
                    ),
                    new Center(
                        child: new Container (
                          margin: new EdgeInsets.all(8.0),
//                          width: ScreenUtil.getInstance().setWidth(335),
//                          decoration: new BoxDecoration(
//                              color: Colors.blueAccent[400]
//                          ),
                          child: new FloatingActionButton(
                            onPressed: () {
                              Navigator.push (context, MaterialPageRoute(builder: (context) => HomePage()));
                            },
//                            child: new Text('Skip',
//                              style: new TextStyle(
//                                  color: Colors.white,
//                                  fontSize: ScreenUtil(allowFontScaling: true).setSp(31)
//                              ),
//                            ),
                            child: new Icon(Icons.skip_next),
                            backgroundColor: Color.fromRGBO(152, 160, 87, 1),
                          ),
                        )
                    )
                  ]
                )
              )
            ),
          ]
        )
      )
    );
  }
}

class TimerPainter extends CustomPainter {
  TimerPainter ({
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super (repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint (Canvas canvas, Size size)
  {
    Paint paint = Paint ()
      ..color = backgroundColor
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, - progress, false, paint);
  }

  @override
  bool shouldRepaint (TimerPainter old)
  {
    return animation.value != old.animation.value || color != old.color
        || backgroundColor != old.backgroundColor;
  }
}
