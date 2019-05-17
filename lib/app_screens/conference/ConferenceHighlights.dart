import 'package:flutter/material.dart';
import 'package:icps/app_screens/conference/conference_highlights/HighlightsOne.dart';
import 'package:icps/app_screens/conference/conference_highlights/HighlightsTwo.dart';

import 'package:page_indicator/page_indicator.dart';

class ConferenceHighlights extends StatefulWidget {
  @override
  _ConferenceHighlightsState createState() => _ConferenceHighlightsState();
}

class _ConferenceHighlightsState extends State<ConferenceHighlights> {

  List<Widget> myConferenceHighlightsPages = [HighlightsOne(), HighlightsTwo()];

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
        title: new Text("Key Conference Highlights"),
        leading: Builder(
          builder: (context) => IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop (context);
            },
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
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
            HighlightsOne(),
            HighlightsTwo(),
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
