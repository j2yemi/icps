import 'package:flutter/material.dart';
// import 'package:icps/app_screens/Gallery.dart';

class PartnersPictures extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(152, 160, 87, 1),
        title: new Text("Partners\' Pictures"),
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
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new Container(
              child: new Column(
                children: <Widget>[
                  new Container(
                    padding: new EdgeInsets.only(left: 25.0, top: 5.0, bottom: 5.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: new BoxDecoration(
                      color: Color.fromRGBO(152, 160, 87, 1),
                    ),
                    child: new Text ('Platinum Partners',
                      style: new TextStyle(
                          color: Colors.white,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  new Container(
                    padding: new EdgeInsets.only(top: 0.0, bottom: 9.0),
                    child: new Column(
                      children: <Widget>[
                        new Container(
                          width: MediaQuery.of(context).size.width,
                          height: 230.0,
                          decoration: new BoxDecoration(
                            image: new DecorationImage(
                              image: new AssetImage(
                                  'assets/images/gallery/partners_pictures/hp.jpg'
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ),
            new Container(
              child: new Column(
                children: <Widget>[
                  new Container(
                    padding: new EdgeInsets.only(left: 25.0, top: 5.0, bottom: 5.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: new BoxDecoration(
                      color: Color.fromRGBO(152, 160, 87, 1),
                    ),
                    child: new Text ('Gold Partners',
                      style: new TextStyle(
                          color: Colors.white,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  new Container(
                    padding: new EdgeInsets.only(top: 0.0, bottom: 9.0),
                    child: new Column(
                      children: <Widget>[
                        new Container(
                          width: MediaQuery.of(context).size.width,
                          height: 230.0,
                          decoration: new BoxDecoration(
                            image: new DecorationImage(
                              image: new AssetImage(
                                  'assets/images/gallery/partners_pictures/dell.jpg'
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ),
            new Container(
              child: new Column(
                children: <Widget>[
                  new Container(
                    padding: new EdgeInsets.only(left: 25.0, top: 5.0, bottom: 5.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: new BoxDecoration(
                      color: Color.fromRGBO(152, 160, 87, 1),
                    ),
                    child: new Text ('Silver Partners',
                      style: new TextStyle(
                          color: Colors.white,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  new Container(
                    padding: new EdgeInsets.only(top: 0.0, bottom: 9.0),
                    child: new Column(
                      children: <Widget>[
                        new Container(
                          width: MediaQuery.of(context).size.width,
                          height: 230.0,
                          decoration: new BoxDecoration(
                            image: new DecorationImage(
                              image: new AssetImage(
                                  'assets/images/gallery/partners_pictures/google.jpg'
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ),
            new Container(
              child: new Column(
                children: <Widget>[
                  new Container(
                    padding: new EdgeInsets.only(left: 25.0, top: 5.0, bottom: 5.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: new BoxDecoration(
                      color: Color.fromRGBO(152, 160, 87, 1),
                    ),
                    child: new Text ('Bronze Partners',
                      style: new TextStyle(
                          color: Colors.white,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  new Container(
                    padding: new EdgeInsets.only(top: 0.0, bottom: 9.0),
                    child: new Column(
                      children: <Widget>[
                        new Container(
                          width: MediaQuery.of(context).size.width,
                          height: 230.0,
                          decoration: new BoxDecoration(
                            image: new DecorationImage(
                              image: new AssetImage(
                                  'assets/images/gallery/partners_pictures/amazon.jpg'
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}
