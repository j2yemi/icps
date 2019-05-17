import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(152, 160, 87, 1),
        title: new Text("Dashboard"),
        leading: Builder(
          builder: (context) => IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop (context);
            },
          ),
        ),
        actions: <Widget>[
//          IconButton(icon: Icon(
//              Icons.search
//          ),
//            onPressed: () {
//
//            },
//          ),
        ],
      ),
      body: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new Container(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Card(
                    child: new ListTile(
                      leading: new Icon(Icons.public),
                      title: new Text ('Registration by Location'),
                      onTap: () {},
                    ),
                  ),
                  new Card(
                    child: new ListTile(
                      leading: new Icon(Icons.business_center),
                      title: new Text ('Registration by Job Title'),
                      onTap: () {},
                    ),
                  ),
                  new Card(
                    child: new ListTile(
                      leading: new Icon(Icons.business),
                      title: new Text ('Registration by Organisation'),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
