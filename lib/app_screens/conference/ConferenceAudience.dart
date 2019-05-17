import 'package:flutter/material.dart';
import 'package:icps/app_screens/conference/conference_audience/AudienceOne.dart';
import 'package:icps/app_screens/conference/conference_audience/AudienceTwo.dart';
import 'package:icps/app_screens/conference/conference_audience/AudienceThree.dart';
import 'package:icps/app_screens/conference/conference_audience/AudienceFour.dart';
import 'package:icps/app_screens/conference/conference_audience/AudienceFive.dart';

import 'package:page_indicator/page_indicator.dart';

class ConferenceAudience extends StatefulWidget {
  @override
  _ConferenceAudienceState createState() => _ConferenceAudienceState();
}

class _ConferenceAudienceState extends State<ConferenceAudience> {

  List<Widget> myConferenceAudiencePages = [AudienceOne(), AudienceTwo(), AudienceThree(), AudienceFour(), AudienceFive()];

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
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(152, 160, 87, 1),
        title: new Text("Conference Audience"),
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
            AudienceOne(),
            AudienceTwo(),
            AudienceThree(),
            AudienceFour(),
            AudienceFive()
          ],
        ),
        align: IndicatorAlign.bottom, // your indicator align with container
        length: 5, // indicator count
        indicatorColor: Colors.grey, // unselected indicator color
        indicatorSelectorColor: Color.fromRGBO(25, 110, 42, 1), // selected indicator color
        padding: EdgeInsets.only(bottom: 10.0), // padding with bottom .when align top you should use properties `top:10.0`
        size: 15.0, // indicator size.
        indicatorSpace: 10.0, // space between circles
      ),
    );
  }
}

