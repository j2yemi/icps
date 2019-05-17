import 'package:flutter/material.dart';
// import 'package:icps/app_screens/Gallery.dart';

class SessionsPhoto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(152, 160, 87, 1),
        title: new Text("Sessions Photo-shoot"),
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
        child: new Column(
          children: <Widget>[
            new Container(
              width: MediaQuery.of(context).size.width,
              height: 230.0,
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage(
                      'assets/images/gallery/sessions_photos/sessions.jpg'
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
