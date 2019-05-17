import 'package:flutter/material.dart';
// import 'package:icps/app_screens/HomePage.dart';
//import 'package:icps/app_screens/agenda/AgendaOne.dart';
//import 'package:icps/app_screens/agenda/AgendaTwo.dart';
import 'package:icps/app_screens/agenda/NewAgendaOne.dart';
import 'package:icps/app_screens/agenda/NewAgendaTwo.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_indicator/page_indicator.dart';

void main() {
  runApp(MaterialApp (
    home: Agenda(),
    theme: ThemeData(
        fontFamily: 'Montserrat'
    ),
  )
  );
}

class Agenda extends StatefulWidget {
  @override
  _AgendaState createState() => _AgendaState ();
}

class _AgendaState extends State<Agenda> {

  List<Widget> myAgendaPages = [NewAgendaOne(), NewAgendaTwo()];

  PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334, allowFontScaling: true)..init(context);
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(152, 160, 87, 1),
        title: new Text("Agenda"),
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
      body: new PageIndicatorContainer(
        pageView: PageView(
          children: <Widget>[
            NewAgendaOne(),
            NewAgendaTwo(),
          ],
        ),
        align: IndicatorAlign.bottom, // your indicator align with container
        length: 2, // indicator count
        indicatorColor: Colors.grey, // unselected indicator color
        indicatorSelectorColor: Color.fromRGBO(25, 110, 42, 1), // selected indicator color
        padding: EdgeInsets.only(bottom: 10.0), // padding with bottom .when align top you should use properties `top:10.0`
        size: 15.0, // indicator size.
        indicatorSpace: 10.0, // space between circles
      ),
    );
  }
}
