import 'package:flutter/material.dart';
// import 'package:icps/app_screens/Conference.dart';

class ConferenceTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(152, 160, 87, 1),
        title: new Text("Conference Theme"),
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
            children: <Widget>[
              new Container(
                margin: new EdgeInsets.all(10.0),
                padding: new EdgeInsets.all(15.0),
                width: MediaQuery.of(context).size.width,
                height: 100.0,
                decoration: new BoxDecoration(
                  color: Color.fromRGBO(180, 188, 151, 1),
                  image: new DecorationImage(
                    image: new AssetImage(
                        'assets/images/logo/icpslogo.png'
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              new Container(
                padding: new EdgeInsets.all(10.0),
                child: new Text(
                  'Conference Theme - '
                      'THE IMPACT OF ELECTRONIC PAYMENTS ON ECONOMIC GROWTH',
                  style: new TextStyle(
                    color: Color.fromRGBO(25, 110, 42, 1),
                    fontSize: 20.0
                  ),
                ),
              ),
              new Container(
                margin: new EdgeInsets.only(left: 15.0, right: 15.0),
                padding: new EdgeInsets.all(25.0),
                decoration: new BoxDecoration(
                  color: Color.fromRGBO(245, 245, 245, 1),
                ),
                child: new Text ('HOW DIGITAL TOOLS COULD BE A DECISIVE FACTOR '
                    'IN MEETING THE  2030 SUSTAINABLE DEVELOPMENT GOALS '
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
