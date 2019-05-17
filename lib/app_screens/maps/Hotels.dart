import 'package:flutter/material.dart';
//  import 'package:icps/app_screens/Locations.dart';
import 'package:icps/app_screens/maps/hotels/Boardwalk.dart';
import 'package:icps/app_screens/maps/hotels/Serendib.dart';
import 'package:icps/app_screens/maps/hotels/Fraser.dart';
import 'package:icps/app_screens/maps/hotels/Transcorp.dart';
import 'package:icps/app_screens/maps/hotels/Corinthia.dart';
import 'package:icps/app_screens/maps/hotels/Sheraton.dart';
import 'package:icps/app_screens/maps/hotels/Valencia.dart';
import 'package:icps/app_screens/maps/hotels/Quo.dart';
import 'package:icps/app_screens/maps/hotels/Yaban.dart';
import 'package:icps/app_screens/maps/hotels/Citilodge.dart';
import 'package:icps/app_screens/maps/hotels/Newton.dart';
import 'package:icps/app_screens/maps/hotels/Vynedresa.dart';
import 'package:icps/app_screens/maps/hotels/Ambassador.dart';
import 'package:icps/app_screens/maps/hotels/Western.dart';
import 'package:icps/app_screens/maps/hotels/Oak.dart';
import 'package:icps/app_screens/maps/hotels/Kebbi.dart';
import 'package:icps/app_screens/maps/hotels/Elvis.dart';
import 'package:icps/app_screens/maps/hotels/Roses.dart';
import 'package:icps/app_screens/maps/hotels/Petrus.dart';
import 'package:icps/Constants.dart';
import 'package:icps/app_screens/Register.dart';
import 'package:icps/app_screens/drawer/Login.dart';

import 'package:icps/app_screens/popupMenu/Dashboard.dart';
import 'package:icps/app_screens/popupMenu/EditProfile.dart';
import 'package:icps/app_screens/popupMenu/Settings.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_rating/flutter_rating.dart';

void main() {
  runApp(MaterialApp (
    home: Hotels(),
    theme: ThemeData(
        fontFamily: 'Montserrat'
    ),
  )
  );
}

class Hotels extends StatefulWidget {

  Data data; String password;

  Hotels({this.data, this.password});

  @override
  _HotelsState createState() => new _HotelsState();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
  signedInSpeaker
}

class _HotelsState extends State<Hotels> {
  double rating = 4.1;
  int starCount = 5;

  AuthStatus _authStatus = AuthStatus.notSignedIn;

  @override
  void initState() {
    super.initState();

    widget.data = widget.data ?? Data();

    _authStatus = ((widget.data.surname == '')) ? AuthStatus.notSignedIn : (widget.data.speaker && widget.data.surname != '') ? AuthStatus.signedInSpeaker : AuthStatus.signedIn;

  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334, allowFontScaling: true)..init(context);
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(152, 160, 87, 1),
        title: new Text("Hotels"),
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
          PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return Constants.choices.map((String choice){
                return PopupMenuItem<String>(
                  value: choice,
                  child: new Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: new SingleChildScrollView(
        child: new Column (
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Container(
              padding: new EdgeInsets.only (bottom: 20.0),
              decoration: BoxDecoration(
                border: new Border(
                  bottom: BorderSide(
                      width: 1.0,
                      style: BorderStyle.solid,
                      color: Color.fromRGBO(192, 192, 192, 1)
                  ),
                ),
              ),
              child: new GestureDetector (
                onTap: () {
                  Navigator.push (context,
                      MaterialPageRoute(builder: (context) => Boardwalk(data: widget.data, password: widget.password))
                  );
                },
                child: new Row (
                  children: <Widget>[
                    new Container (
                    margin: new EdgeInsets.only (left: 20.0, top: 20.0),
                      child: new Container (
                        width: ScreenUtil.getInstance().setWidth(165),
                        height: ScreenUtil.getInstance().setHeight(165),
                        decoration: BoxDecoration (
                          image: new DecorationImage (
                            image: new AssetImage (
                                'assets/images/maps/hotels/boardwalk.jpg'
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.only(
                        top: 18.0,
                      ),
                      child: new Container(
                        padding: new EdgeInsets.only (
                          right: 10.0
                        ),
                        child: new Column(
                          children: <Widget>[
                            new Container(
                              margin: new EdgeInsets.only(left: 12.0),
                              child: Text('Boardwalk Hotel',
                                style: TextStyle (
                                  fontSize: 17.0,
                                ),
                              ),
                            ),
                            new Container(
                              child: new Row (
                                children: <Widget>[
                                  new Container(
                                    margin: new EdgeInsets.only(left: 10.0),
                                    child: new Text('4.1',
                                      style: new TextStyle(
                                          color: Colors.orange,
                                          fontSize: 16.0
                                      ),
                                    ),
                                  ),
                                  new StarRating(
                                    size: 20.0,
                                    rating: rating,
                                    color: Colors.orange,
                                    borderColor: Colors.grey,
                                    starCount: starCount,
//                                    onRatingChanged: (rating) => setState(
//                                          () {
//                                        this.rating = rating;
//                                      },
//                                    ),
                                  ),
                                  new Container(
                                    child: new Text('(63)',
                                      style: new TextStyle(color: Colors.grey),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            new Container(
                              child: new Text('3-star hotel',
                                style: new TextStyle(
                                    color: Colors.grey,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            )
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        border: new Border(
                          right: BorderSide(
                              width: 2.0,
                              style: BorderStyle.solid,
                              color: Color.fromRGBO(192, 192, 192, 1)
                          ),
                        ),
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.only(left: 7.0),
                      child: new Text('NGN28,823',
                        style: TextStyle(
                          fontSize: ScreenUtil(allowFontScaling: true).setSp(25),
                        ),
                        textAlign: TextAlign.start,
                      ),
                    )
                  ],
                ),
              ),
            ),
            new Container(
              padding: new EdgeInsets.only (bottom: 20.0),
              decoration: BoxDecoration(
                border: new Border(
                  bottom: BorderSide(
                      width: 1.0,
                      style: BorderStyle.solid,
                      color: Color.fromRGBO(192, 192, 192, 1)
                  ),
                ),
              ),
              child: new GestureDetector (
                onTap: () {
                  Navigator.push (context,
                      MaterialPageRoute(builder: (context) => Serendib(data: widget.data, password: widget.password))
                  );
                },
                child: new Row (
                  children: <Widget>[
                    new Container (
                      margin: new EdgeInsets.only (left: 20.0, top: 20.0),
                      child: new Container (
                        width: ScreenUtil.getInstance().setWidth(165),
                        height: ScreenUtil.getInstance().setHeight(165),
                        decoration: BoxDecoration (
                          image: new DecorationImage (
                            image: new AssetImage (
                                'assets/images/maps/hotels/serendib.jpg'
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.only(
                        top: 18.0,
                      ),
                      child: new Container(
                        padding: new EdgeInsets.only (
                            right: 10.0
                        ),
                        child: new Column(
                          children: <Widget>[
                            new Container(
                              margin: new EdgeInsets.only(left: 12.0),
                              child: Text('Serendib Hotel',
                                style: TextStyle (
                                  fontSize: 17.0,
                                ),
                              ),
                            ),
                            new Container(
                              child: new Row (
                                children: <Widget>[
                                  new Container(
                                    margin: new EdgeInsets.only(left: 10.0),
                                    child: new Text('3.8',
                                      style: new TextStyle(
                                          color: Colors.orange,
                                          fontSize: 16.0
                                      ),
                                    ),
                                  ),
                                  new StarRating(
                                    size: 20.0,
                                    rating: 3.8,
                                    color: Colors.orange,
                                    borderColor: Colors.grey,
                                    starCount: starCount,
//                                    onRatingChanged: (rating) => setState(
//                                          () {
//                                        this.rating = rating;
//                                      },
//                                    ),
                                  ),
                                  new Container(
                                    child: new Text('(18)',
                                      style: new TextStyle(color: Colors.grey),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            new Container(
                              child: new Text('3-star hotel',
                                style: new TextStyle(
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            )
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        border: new Border(
                          right: BorderSide(
                              width: 2.0,
                              style: BorderStyle.solid,
                              color: Color.fromRGBO(192, 192, 192, 1)
                          ),
                        ),
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.only(left: 7.0),
                      child: new Text('NGN19,575',
                        style: TextStyle(
                          fontSize: ScreenUtil(allowFontScaling: true).setSp(25),
                        ),
                        textAlign: TextAlign.start,
                      ),
                    )
                  ],
                ),
              ),
            ),
            new Container(
              padding: new EdgeInsets.only (bottom: 20.0),
              decoration: BoxDecoration(
                border: new Border(
                  bottom: BorderSide(
                    width: 1.0,
                    style: BorderStyle.solid,
                    color: Color.fromRGBO(192, 192, 192, 1)
                  ),
                ),
              ),
              child: new GestureDetector (
                onTap: () {
                  Navigator.push (context,
                      MaterialPageRoute(builder: (context) => Fraser(data: widget.data, password: widget.password))
                  );
                },
                child: new Row (
                  children: <Widget>[
                    new Container (
                    margin: new EdgeInsets.only (left: 20.0, top: 20.0),
                      child: new Container (
                        width: ScreenUtil.getInstance().setWidth(165),
                        height: ScreenUtil.getInstance().setHeight(165),
                        decoration: BoxDecoration (
                          image: new DecorationImage (
                            image: new AssetImage (
                              'assets/images/maps/hotels/fraser.jpg'
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    new Container(
                    margin: new EdgeInsets.only(
                      top: 18.0,
                    ),
                      child: new Container(
                      padding: new EdgeInsets.only (
                        right: 10.0
                      ),
                        child: new Column(
                          children: <Widget>[
                            new Container(
                            margin: new EdgeInsets.only(left: 12.0),
                              child: Text('Fraser Suites Abuja',
                                style: TextStyle (fontSize: 17.0),
                              ),
                            ),
                            new Container(
                              child: new Row (
                                children: <Widget>[
                                  new Container(
                                  margin: new EdgeInsets.only(left: 10.0),
                                    child: new Text('4.6',
                                      style: new TextStyle(
                                        color: Colors.orange,
                                        fontSize: 16.0
                                      ),
                                    ),
                                  ),
                                  new StarRating(
                                    size: 20.0,
                                    rating: 4.6,
                                    color: Colors.orange,
                                    borderColor: Colors.grey,
                                    starCount: starCount,
//                                    onRatingChanged: (rating) => setState(
//                                      () {
//                                        this.rating = rating;
//                                      },
//                                    ),
                                  ),
                                  new Container(
                                    child: new Text('(707)',
                                      style: new TextStyle(color: Colors.grey),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            new Container(
                              child: new Text('4-star hotel',
                                style: new TextStyle(
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            new Container(
                              padding: new EdgeInsets.only(top: 5.0),
                              child: new Text('1 pool & 2 restaurants',
                                style: new TextStyle(color: Colors.grey),
                              ),
                            ),
                            new Container(
                              padding: new EdgeInsets.only(left: 6.0),
                              child: new Text('Free Wi-Fi & free breakfast',
                                style: new TextStyle(color: Colors.grey),
                              ),
                            )
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        border: new Border(
                          right: BorderSide(
                            width: 2.0,
                            style: BorderStyle.solid,
                            color: Color.fromRGBO(192, 192, 192, 1)
                          ),
                        ),
                      ),
                    ),
                    new Container(
                    margin: new EdgeInsets.only(left: 7.0),
                      child: new Text('NGN90,250',
                        style: TextStyle(
                          fontSize: ScreenUtil(allowFontScaling: true).setSp(25),
                        ),
                        textAlign: TextAlign.start,
                      ),
                    )
                  ],
                ),
              ),
            ),
            new Container(
              padding: new EdgeInsets.only (bottom: 20.0),
              decoration: BoxDecoration(
                border: new Border(
                  bottom: BorderSide(
                      width: 1.0,
                      style: BorderStyle.solid,
                      color: Color.fromRGBO(192, 192, 192, 1)
                  ),
                ),
              ),
              child: new GestureDetector (
                onTap: () {
                  Navigator.push (context,
                      MaterialPageRoute(builder: (context) => Transcorp(data: widget.data, password: widget.password))
                  );
                },
                child: new Row (
                  children: <Widget>[
                    new Container (
                      margin: new EdgeInsets.only (left: 20.0, top: 20.0),
                      child: new Container (
                        width: ScreenUtil.getInstance().setWidth(165),
                        height: ScreenUtil.getInstance().setHeight(165),
                        decoration: BoxDecoration (
                          image: new DecorationImage (
                            image: new AssetImage (
                                'assets/images/maps/hotels/transcorp.jpg'
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.only(
                        top: 18.0,
                      ),
                      child: new Container(
                        padding: new EdgeInsets.only (
                            right: 5.0
                        ),
                        child: new Column(
                          children: <Widget>[
                            new Container(
                              margin: new EdgeInsets.only(left: 12.0),
                              child: Text('Transcorp Hilton',
                                style: TextStyle (fontSize: 17.0),
                              ),
                            ),
                            new Container(
                              child: new Row (
                                children: <Widget>[
                                  new Container(
                                    margin: new EdgeInsets.only(left: 5.0),
                                    child: new Text('4.5',
                                      style: new TextStyle(
                                          color: Colors.orange,
                                          fontSize: 16.0
                                      ),
                                    ),
                                  ),
                                  new StarRating(
                                    size: 20.0,
                                    rating: 4.5,
                                    color: Colors.orange,
                                    borderColor: Colors.grey,
                                    starCount: starCount,
//                                    onRatingChanged: (rating) => setState(
//                                          () {
//                                        this.rating = rating;
//                                      },
//                                    ),
                                  ),
                                  new Container(
                                    child: new Text('(7,295)',
                                      style: new TextStyle(color: Colors.grey),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            new Container(
                              child: new Text('5-star hotel',
                                style: new TextStyle(
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            new Container(
                              padding: new EdgeInsets.only(top: 5.0),
                              child: new Text('1 pool & 1 piano bar',
                                style: new TextStyle(color: Colors.grey),
                              ),
                            ),
                            new Container(
                              child: new Text('Free Wi-Fi',
                                style: new TextStyle(color: Colors.grey),
                              ),
                            )
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        border: new Border(
                          right: BorderSide(
                              width: 2.0,
                              style: BorderStyle.solid,
                              color: Color.fromRGBO(192, 192, 192, 1)
                          ),
                        ),
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.only(left: 7.0),
                      child: new Text('NGN103,401',
                        style: TextStyle(
                          fontSize: ScreenUtil(allowFontScaling: true).setSp(25),
                        ),
                        textAlign: TextAlign.start,
                      ),
                    )
                  ],
                ),
              ),
            ),
            new Container(
              padding: new EdgeInsets.only (bottom: 20.0),
              decoration: BoxDecoration(
                border: new Border(
                  bottom: BorderSide(
                      width: 1.0,
                      style: BorderStyle.solid,
                      color: Color.fromRGBO(192, 192, 192, 1)
                  ),
                ),
              ),
              child: new GestureDetector (
                onTap: () {
                  Navigator.push (context,
                      MaterialPageRoute(builder: (context) => Corinthia(data: widget.data, password: widget.password))
                  );
                },
                child: new Row (
                  children: <Widget>[
                    new Container (
                      margin: new EdgeInsets.only (left: 20.0, top: 20.0),
                      child: new Container (
                        width: ScreenUtil.getInstance().setWidth(165),
                        height: ScreenUtil.getInstance().setHeight(165),
                        decoration: BoxDecoration (
                          image: new DecorationImage (
                            image: new AssetImage (
                                'assets/images/maps/hotels/corinthia.jpg'
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.only(
                        top: 18.0,
                      ),
                      child: new Container(
                        padding: new EdgeInsets.only (
                            right: 10.0
                        ),
                        child: new Column(
                          children: <Widget>[
                            new Container(
                              margin: new EdgeInsets.only(left: 12.0),
                              child: Text('Corinthia Villa Hotel',
                                style: TextStyle (fontSize: 17.0),
                              ),
                            ),
                            new Container(
                              child: new Row (
                                children: <Widget>[
                                  new Container(
                                    margin: new EdgeInsets.only(left: 10.0),
                                    child: new Text('4.3',
                                      style: new TextStyle(
                                          color: Colors.orange,
                                          fontSize: 16.0
                                      ),
                                    ),
                                  ),
                                  new StarRating(
                                    size: 20.0,
                                    rating: 4.3,
                                    color: Colors.orange,
                                    borderColor: Colors.grey,
                                    starCount: starCount,
//                                    onRatingChanged: (rating) => setState(
//                                          () {
//                                        this.rating = rating;
//                                      },
//                                    ),
                                  ),
                                  new Container(
                                    child: new Text('(334)',
                                      style: new TextStyle(color: Colors.grey),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            new Container(
                              child: new Text('Hotel',
                                style: new TextStyle(
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        border: new Border(
                          right: BorderSide(
                              width: 2.0,
                              style: BorderStyle.solid,
                              color: Color.fromRGBO(192, 192, 192, 1)
                          ),
                        ),
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.only(left: 7.0),
                      child: new Text('NGN30,000',
                        style: TextStyle(
                          fontSize: ScreenUtil(allowFontScaling: true).setSp(25),
                        ),
                        textAlign: TextAlign.start,
                      ),
                    )
                  ],
                ),
              ),
            ),
            new Container(
              padding: new EdgeInsets.only (bottom: 20.0),
              decoration: BoxDecoration(
                border: new Border(
                  bottom: BorderSide(
                      width: 1.0,
                      style: BorderStyle.solid,
                      color: Color.fromRGBO(192, 192, 192, 1)
                  ),
                ),
              ),
              child: new GestureDetector (
                onTap: () {
                  Navigator.push (context,
                      MaterialPageRoute(builder: (context) => Sheraton(data: widget.data, password: widget.password))
                  );
                },
                child: new Row (
                  children: <Widget>[
                    new Container (
                      margin: new EdgeInsets.only (left: 20.0, top: 20.0),
                      child: new Container (
                        width: ScreenUtil.getInstance().setWidth(165),
                        height: ScreenUtil.getInstance().setHeight(165),
                        decoration: BoxDecoration (
                          image: new DecorationImage (
                            image: new AssetImage (
                                'assets/images/maps/hotels/sheraton.png'
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.only(
                        top: 18.0,
                      ),
                      child: new Container(
                        padding: new EdgeInsets.only (
                            right: 10.0
                        ),
                        child: new Column(
                          children: <Widget>[
                            new Container(
                              margin: new EdgeInsets.only(left: 12.0),
                              child: Text('Sheraton Abuja Hotel',
                                style: TextStyle (fontSize: 17.0),
                              ),
                            ),
                            new Container(
                              child: new Row (
                                children: <Widget>[
                                  new Container(
                                    margin: new EdgeInsets.only(left: 10.0),
                                    child: new Text('4.1',
                                      style: new TextStyle(
                                          color: Colors.orange,
                                          fontSize: 16.0
                                      ),
                                    ),
                                  ),
                                  new StarRating(
                                    size: 20.0,
                                    rating: 4.1,
                                    color: Colors.orange,
                                    borderColor: Colors.grey,
                                    starCount: starCount,
//                                    onRatingChanged: (rating) => setState(
//                                          () {
//                                        this.rating = rating;
//                                      },
//                                    ),
                                  ),
                                  new Container(
                                    child: new Text('(3,319)',
                                      style: new TextStyle(color: Colors.grey),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            new Container(
                              child: new Text('4-star hotel',
                                style: new TextStyle(
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            new Container(
                              padding: new EdgeInsets.only(left: 6.0),
                              child: new Text('Modern Lodging with a pool',
                                style: new TextStyle(
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            new Container(
                              child: new Text('Free Wi-Fi',
                                style: new TextStyle(
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        border: new Border(
                          right: BorderSide(
                              width: 2.0,
                              style: BorderStyle.solid,
                              color: Color.fromRGBO(192, 192, 192, 1)
                          ),
                        ),
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.only(left: 4.0),
                      child: new Text('NGN87,628',
                        style: TextStyle(
                          fontSize: ScreenUtil(allowFontScaling: true).setSp(25),
                        ),
                        textAlign: TextAlign.start,
                      ),
                    )
                  ],
                ),
              ),
            ),
            new Container(
              padding: new EdgeInsets.only (bottom: 20.0),
              decoration: BoxDecoration(
                border: new Border(
                  bottom: BorderSide(
                      width: 1.0,
                      style: BorderStyle.solid,
                      color: Color.fromRGBO(192, 192, 192, 1)
                  ),
                ),
              ),
              child: new GestureDetector (
                onTap: () {
                  Navigator.push (context,
                      MaterialPageRoute(builder: (context) => Valencia(data: widget.data, password: widget.password))
                  );
                },
                child: new Row (
                  children: <Widget>[
                    new Container (
                      margin: new EdgeInsets.only (left: 20.0, top: 20.0),
                      child: new Container (
                        width: ScreenUtil.getInstance().setWidth(165),
                        height: ScreenUtil.getInstance().setHeight(165),
                        decoration: BoxDecoration (
                          image: new DecorationImage (
                            image: new AssetImage (
                                'assets/images/maps/hotels/valencia.jpg'
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.only(
                        top: 18.0,
                      ),
                      child: new Container(
                        padding: new EdgeInsets.only (
                            right: 10.0
                        ),
                        child: new Column(
                          children: <Widget>[
                            new Container(
                              margin: new EdgeInsets.only(left: 12.0),
                              child: Text('Valencia Hotel',
                                style: TextStyle (fontSize: 17.0),
                              ),
                            ),
                            new Container(
                              child: new Row (
                                children: <Widget>[
                                  new Container(
                                    margin: new EdgeInsets.only(left: 10.0),
                                    child: new Text('3.8',
                                      style: new TextStyle(
                                          color: Colors.orange,
                                          fontSize: 16.0
                                      ),
                                    ),
                                  ),
                                  new StarRating(
                                    size: 20.0,
                                    rating: 3.8,
                                    color: Colors.orange,
                                    borderColor: Colors.grey,
                                    starCount: starCount,
//                                    onRatingChanged: (rating) => setState(
//                                          () {
//                                        this.rating = rating;
//                                      },
//                                    ),
                                  ),
                                  new Container(
                                    child: new Text('(303)',
                                      style: new TextStyle(color: Colors.grey),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            new Container(
                              child: new Text('Hotel',
                                style: new TextStyle(
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            new Container(
                              padding: new EdgeInsets.only(left: 6.0),
                              child: new Text('Business hotel with dinning',
                                style: new TextStyle(
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        border: new Border(
                          right: BorderSide(
                              width: 2.0,
                              style: BorderStyle.solid,
                              color: Color.fromRGBO(192, 192, 192, 1)
                          ),
                        ),
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.only(left: 4.0),
                      child: new Text('NGN32,338',
                        style: TextStyle(
                          fontSize: ScreenUtil(allowFontScaling: true).setSp(25),
                        ),
                        textAlign: TextAlign.start,
                      ),
                    )
                  ],
                ),
              ),
            ),
            new Container(
              padding: new EdgeInsets.only (bottom: 20.0),
              decoration: BoxDecoration(
                border: new Border(
                  bottom: BorderSide(
                      width: 1.0,
                      style: BorderStyle.solid,
                      color: Color.fromRGBO(192, 192, 192, 1)
                  ),
                ),
              ),
              child: new GestureDetector (
                onTap: () {
                  Navigator.push (context,
                      MaterialPageRoute(builder: (context) => Quo(data: widget.data, password: widget.password))
                  );
                },
                child: new Row (
                  children: <Widget>[
                    new Container (
                      margin: new EdgeInsets.only (left: 20.0, top: 20.0),
                      child: new Container (
                        width: ScreenUtil.getInstance().setWidth(165),
                        height: ScreenUtil.getInstance().setHeight(165),
                        decoration: BoxDecoration (
                          image: new DecorationImage (
                            image: new AssetImage (
                                'assets/images/maps/hotels/quo.jpg'
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.only(
                        top: 18.0,
                      ),
                      child: new Container(
                        padding: new EdgeInsets.only (
                            right: 10.0
                        ),
                        child: new Column(
                          children: <Widget>[
                            new Container(
                              margin: new EdgeInsets.only(left: 12.0),
                              child: Text('Quo Vadis Hotel',
                                style: TextStyle (fontSize: 17.0),
                              ),
                            ),
                            new Container(
                              child: new Row (
                                children: <Widget>[
                                  new Container(
                                    margin: new EdgeInsets.only(left: 10.0),
                                    child: new Text('4.3',
                                      style: new TextStyle(
                                          color: Colors.orange,
                                          fontSize: 16.0
                                      ),
                                    ),
                                  ),
                                  new StarRating(
                                    size: 20.0,
                                    rating: 4.3,
                                    color: Colors.orange,
                                    borderColor: Colors.grey,
                                    starCount: starCount,
//                                    onRatingChanged: (rating) => setState(
//                                          () {
//                                        this.rating = rating;
//                                      },
//                                    ),
                                  ),
                                  new Container(
                                    child: new Text('(103)',
                                      style: new TextStyle(color: Colors.grey),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            new Container(
                              child: new Text('4-star hotel',
                                style: new TextStyle(
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        border: new Border(
                          right: BorderSide(
                              width: 2.0,
                              style: BorderStyle.solid,
                              color: Color.fromRGBO(192, 192, 192, 1)
                          ),
                        ),
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.only(left: 7.0),
                      child: new Text('NGN41,709',
                        style: TextStyle(
                          fontSize: ScreenUtil(allowFontScaling: true).setSp(25),
                        ),
                        textAlign: TextAlign.start,
                      ),
                    )
                  ],
                ),
              ),
            ),
            new Container(
              padding: new EdgeInsets.only (bottom: 20.0),
              decoration: BoxDecoration(
                border: new Border(
                  bottom: BorderSide(
                      width: 1.0,
                      style: BorderStyle.solid,
                      color: Color.fromRGBO(192, 192, 192, 1)
                  ),
                ),
              ),
              child: new GestureDetector (
                onTap: () {
                  Navigator.push (context,
                      MaterialPageRoute(builder: (context) => Yaban(data: widget.data, password: widget.password))
                  );
                },
                child: new Row (
                  children: <Widget>[
                    new Container (
                      margin: new EdgeInsets.only (left: 20.0, top: 20.0),
                      child: new Container (
                        width: ScreenUtil.getInstance().setWidth(165),
                        height: ScreenUtil.getInstance().setHeight(165),
                        decoration: BoxDecoration (
                          image: new DecorationImage (
                            image: new AssetImage (
                                'assets/images/maps/hotels/yaban.jpg'
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.only(
                        top: 18.0,
                      ),
                      child: new Container(
                        padding: new EdgeInsets.only (
                            right: 10.0
                        ),
                        child: new Column(
                          children: <Widget>[
                            new Container(
                              margin: new EdgeInsets.only(left: 12.0),
                              child: Text('Yaban Hotel',
                                style: TextStyle (fontSize: 17.0),
                              ),
                            ),
                            new Container(
                              child: new Row (
                                children: <Widget>[
                                  new Container(
                                    margin: new EdgeInsets.only(left: 10.0),
                                    child: new Text('3.6',
                                      style: new TextStyle(
                                          color: Colors.orange,
                                          fontSize: 16.0
                                      ),
                                    ),
                                  ),
                                  new StarRating(
                                    size: 20.0,
                                    rating: 3.6,
                                    color: Colors.orange,
                                    borderColor: Colors.grey,
                                    starCount: starCount,
//                                    onRatingChanged: (rating) => setState(
//                                          () {
//                                        this.rating = rating;
//                                      },
//                                    ),
                                  ),
                                  new Container(
                                    child: new Text('(29)',
                                      style: new TextStyle(color: Colors.grey),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            new Container(
                              child: new Text('3-star hotel',
                                style: new TextStyle(
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        border: new Border(
                          right: BorderSide(
                              width: 2.0,
                              style: BorderStyle.solid,
                              color: Color.fromRGBO(192, 192, 192, 1)
                          ),
                        ),
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.only(left: 7.0),
                      child: new Text('NGN9,200',
                        style: TextStyle(
                          fontSize: ScreenUtil(allowFontScaling: true).setSp(25),
                        ),
                        textAlign: TextAlign.start,
                      ),
                    )
                  ],
                ),
              ),
            ),
            new Container(
              padding: new EdgeInsets.only (bottom: 20.0),
              decoration: BoxDecoration(
                border: new Border(
                  bottom: BorderSide(
                      width: 1.0,
                      style: BorderStyle.solid,
                      color: Color.fromRGBO(192, 192, 192, 1)
                  ),
                ),
              ),
              child: new GestureDetector (
                onTap: () {
                  Navigator.push (context,
                      MaterialPageRoute(builder: (context) => Citilodge(data: widget.data, password: widget.password))
                  );
                },
                child: new Row (
                  children: <Widget>[
                    new Container (
                      margin: new EdgeInsets.only (left: 20.0, top: 20.0),
                      child: new Container (
                        width: ScreenUtil.getInstance().setWidth(165),
                        height: ScreenUtil.getInstance().setHeight(165),
                        decoration: BoxDecoration (
                          image: new DecorationImage (
                            image: new AssetImage (
                                'assets/images/maps/hotels/citilodge.jpg'
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.only(
                        top: 18.0,
                      ),
                      child: new Container(
                        padding: new EdgeInsets.only (
                            right: 10.0
                        ),
                        child: new Column(
                          children: <Widget>[
                            new Container(
                              margin: new EdgeInsets.only(left: 12.0),
                              child: Text('Citilodge Hotel',
                                style: TextStyle (fontSize: 17.0),
                              ),
                            ),
                            new Container(
                              child: new Row (
                                children: <Widget>[
                                  new Container(
                                    margin: new EdgeInsets.only(left: 10.0),
                                    child: new Text('3.4',
                                      style: new TextStyle(
                                          color: Colors.orange,
                                          fontSize: 16.0
                                      ),
                                    ),
                                  ),
                                  new StarRating(
                                    size: 20.0,
                                    rating: 3.4,
                                    color: Colors.orange,
                                    borderColor: Colors.grey,
                                    starCount: starCount,
//                                    onRatingChanged: (rating) => setState(
//                                          () {
//                                        this.rating = rating;
//                                      },
//                                    ),
                                  ),
                                  new Container(
                                    child: new Text('(94)',
                                      style: new TextStyle(color: Colors.grey),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            new Container(
                              child: new Text('3-star hotel',
                                style: new TextStyle(
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        border: new Border(
                          right: BorderSide(
                              width: 2.0,
                              style: BorderStyle.solid,
                              color: Color.fromRGBO(192, 192, 192, 1)
                          ),
                        ),
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.only(left: 7.0),
                      child: new Text('NGN12,158',
                        style: TextStyle(
                          fontSize: ScreenUtil(allowFontScaling: true).setSp(25),
                        ),
                        textAlign: TextAlign.start,
                      ),
                    )
                  ],
                ),
              ),
            ),
            new Container(
              padding: new EdgeInsets.only (bottom: 20.0),
              decoration: BoxDecoration(
                border: new Border(
                  bottom: BorderSide(
                      width: 1.0,
                      style: BorderStyle.solid,
                      color: Color.fromRGBO(192, 192, 192, 1)
                  ),
                ),
              ),
              child: new GestureDetector (
                onTap: () {
                  Navigator.push (context,
                      MaterialPageRoute(builder: (context) => Newton(data: widget.data, password: widget.password))
                  );
                },
                child: new Row (
                  children: <Widget>[
                    new Container (
                      margin: new EdgeInsets.only (left: 20.0, top: 20.0),
                      child: new Container (
                        width: ScreenUtil.getInstance().setWidth(165),
                        height: ScreenUtil.getInstance().setHeight(165),
                        decoration: BoxDecoration (
                          image: new DecorationImage (
                            image: new AssetImage (
                                'assets/images/maps/hotels/newton.jpg'
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.only(
                        top: 18.0,
                      ),
                      child: new Container(
                        padding: new EdgeInsets.only (
                            right: 10.0
                        ),
                        child: new Column(
                          children: <Widget>[
                            new Container(
                              margin: new EdgeInsets.only(left: 12.0),
                              child: Text('Newton Park Hotel',
                                style: TextStyle (fontSize: 17.0),
                              ),
                            ),
                            new Container(
                              child: new Row (
                                children: <Widget>[
                                  new Container(
                                    margin: new EdgeInsets.only(left: 10.0),
                                    child: new Text('3.9',
                                      style: new TextStyle(
                                          color: Colors.orange,
                                          fontSize: 16.0
                                      ),
                                    ),
                                  ),
                                  new StarRating(
                                    size: 20.0,
                                    rating: 3.9,
                                    color: Colors.orange,
                                    borderColor: Colors.grey,
                                    starCount: starCount,
//                                    onRatingChanged: (rating) => setState(
//                                          () {
//                                        this.rating = rating;
//                                      },
//                                    ),
                                  ),
                                  new Container(
                                    child: new Text('(394)',
                                      style: new TextStyle(color: Colors.grey),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            new Container(
                              child: new Text('Hotel',
                                style: new TextStyle(
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        border: new Border(
                          right: BorderSide(
                              width: 2.0,
                              style: BorderStyle.solid,
                              color: Color.fromRGBO(192, 192, 192, 1)
                          ),
                        ),
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.only(left: 7.0),
                      child: new Text('NGN30,395',
                        style: TextStyle(
                          fontSize: ScreenUtil(allowFontScaling: true).setSp(25),
                        ),
                        textAlign: TextAlign.start,
                      ),
                    )
                  ],
                ),
              ),
            ),
            new Container(
              padding: new EdgeInsets.only (bottom: 20.0),
              decoration: BoxDecoration(
                border: new Border(
                  bottom: BorderSide(
                      width: 1.0,
                      style: BorderStyle.solid,
                      color: Color.fromRGBO(192, 192, 192, 1)
                  ),
                ),
              ),
              child: new GestureDetector (
                onTap: () {
                  Navigator.push (context,
                      MaterialPageRoute(builder: (context) => Vynedresa(data: widget.data, password: widget.password))
                  );
                },
                child: new Row (
                  children: <Widget>[
                    new Container (
                      margin: new EdgeInsets.only (left: 20.0, top: 20.0),
                      child: new Container (
                        width: ScreenUtil.getInstance().setWidth(165),
                        height: ScreenUtil.getInstance().setHeight(165),
                        decoration: BoxDecoration (
                          image: new DecorationImage (
                            image: new AssetImage (
                                'assets/images/maps/hotels/vynedresa.jpg'
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.only(
                        top: 18.0,
                      ),
                      child: new Container(
                        padding: new EdgeInsets.only (
                            right: 10.0
                        ),
                        child: new Column(
                          children: <Widget>[
                            new Container(
                              margin: new EdgeInsets.only(left: 12.0),
                              child: Text('Vynedresa Hotel',
                                style: TextStyle (fontSize: 17.0),
                              ),
                            ),
                            new Container(
                              child: new Row (
                                children: <Widget>[
                                  new Container(
                                    margin: new EdgeInsets.only(left: 10.0),
                                    child: new Text('3.9',
                                      style: new TextStyle(
                                          color: Colors.orange,
                                          fontSize: 16.0
                                      ),
                                    ),
                                  ),
                                  new StarRating(
                                    size: 20.0,
                                    rating: 3.9,
                                    color: Colors.orange,
                                    borderColor: Colors.grey,
                                    starCount: starCount,
//                                    onRatingChanged: (rating) => setState(
//                                          () {
//                                        this.rating = rating;
//                                      },
//                                    ),
                                  ),
                                  new Container(
                                    child: new Text('(94)',
                                      style: new TextStyle(color: Colors.grey),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            new Container(
                              child: new Text('3-star hotel',
                                style: new TextStyle(
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        border: new Border(
                          right: BorderSide(
                              width: 2.0,
                              style: BorderStyle.solid,
                              color: Color.fromRGBO(192, 192, 192, 1)
                          ),
                        ),
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.only(left: 7.0),
                      child: new Text('NGN20,000',
                        style: TextStyle(
                          fontSize: ScreenUtil(allowFontScaling: true).setSp(25),
                        ),
                        textAlign: TextAlign.start,
                      ),
                    )
                  ],
                ),
              ),
            ),
            new Container(
              padding: new EdgeInsets.only (bottom: 20.0),
              decoration: BoxDecoration(
                border: new Border(
                  bottom: BorderSide(
                      width: 1.0,
                      style: BorderStyle.solid,
                      color: Color.fromRGBO(192, 192, 192, 1)
                  ),
                ),
              ),
              child: new GestureDetector (
                onTap: () {
                  Navigator.push (context,
                      MaterialPageRoute(builder: (context) => Ambassador(data: widget.data, password: widget.password))
                  );
                },
                child: new Row (
                  children: <Widget>[
                    new Container (
                      margin: new EdgeInsets.only (left: 20.0, top: 20.0),
                      child: new Container (
                        width: ScreenUtil.getInstance().setWidth(165),
                        height: ScreenUtil.getInstance().setHeight(165),
                        decoration: BoxDecoration (
                          image: new DecorationImage (
                            image: new AssetImage (
                                'assets/images/maps/hotels/ambassador.jpg'
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.only(
                        top: 18.0,
                      ),
                      child: new Container(
                        padding: new EdgeInsets.only (
                            right: 10.0
                        ),
                        child: new Column(
                          children: <Widget>[
                            new Container(
                              margin: new EdgeInsets.only(left: 12.0),
                              child: Text('Hotel Ambassador',
                                style: TextStyle (fontSize: 17.0),
                              ),
                            ),
                            new Container(
                              child: new Row (
                                children: <Widget>[
                                  new Container(
                                    margin: new EdgeInsets.only(left: 10.0),
                                    child: new Text('4.3',
                                      style: new TextStyle(
                                          color: Colors.orange,
                                          fontSize: 16.0
                                      ),
                                    ),
                                  ),
                                  new StarRating(
                                    size: 20.0,
                                    rating: 4.3,
                                    color: Colors.orange,
                                    borderColor: Colors.grey,
                                    starCount: starCount,
//                                    onRatingChanged: (rating) => setState(
//                                          () {
//                                        this.rating = rating;
//                                      },
//                                    ),
                                  ),
                                  new Container(
                                    child: new Text('(19)',
                                      style: new TextStyle(color: Colors.grey),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            new Container(
                              child: new Text('Lodging',
                                style: new TextStyle(
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        border: new Border(
                          right: BorderSide(
                              width: 2.0,
                              style: BorderStyle.solid,
                              color: Color.fromRGBO(192, 192, 192, 1)
                          ),
                        ),
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.only(left: 7.0),
                      child: new Text('NGN27,189',
                        style: TextStyle(
                          fontSize: ScreenUtil(allowFontScaling: true).setSp(25),
                        ),
                        textAlign: TextAlign.start,
                      ),
                    )
                  ],
                ),
              ),
            ),
            new Container(
              padding: new EdgeInsets.only (bottom: 20.0),
              decoration: BoxDecoration(
                border: new Border(
                  bottom: BorderSide(
                      width: 1.0,
                      style: BorderStyle.solid,
                      color: Color.fromRGBO(192, 192, 192, 1)
                  ),
                ),
              ),
              child: new GestureDetector (
                onTap: () {
                  Navigator.push (context,
                      MaterialPageRoute(builder: (context) => Western(data: widget.data, password: widget.password))
                  );
                },
                child: new Row (
                  children: <Widget>[
                    new Container (
                      margin: new EdgeInsets.only (left: 20.0, top: 20.0),
                      child: new Container (
                        width: ScreenUtil.getInstance().setWidth(165),
                        height: ScreenUtil.getInstance().setHeight(165),
                        decoration: BoxDecoration (
                          image: new DecorationImage (
                            image: new AssetImage (
                                'assets/images/maps/hotels/western.jpg'
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.only(
                        top: 18.0,
                      ),
                      child: new Container(
                        padding: new EdgeInsets.only (
                            right: 5.0
                        ),
                        child: new Column(
                          children: <Widget>[
                            new Container(
                              margin: new EdgeInsets.only(left: 12.0),
                              child: Text('Western Dreams Hotel',
                                style: TextStyle (fontSize: 17.0),
                              ),
                            ),
                            new Container(
                              child: new Row (
                                children: <Widget>[
                                  new Container(
                                    margin: new EdgeInsets.only(left: 10.0),
                                    child: new Text('3.6',
                                      style: new TextStyle(
                                          color: Colors.orange,
                                          fontSize: 16.0
                                      ),
                                    ),
                                  ),
                                  new StarRating(
                                    size: 20.0,
                                    rating: 3.6,
                                    color: Colors.orange,
                                    borderColor: Colors.grey,
                                    starCount: starCount,
//                                    onRatingChanged: (rating) => setState(
//                                          () {
//                                        this.rating = rating;
//                                      },
//                                    ),
                                  ),
                                  new Container(
                                    child: new Text('(130)',
                                      style: new TextStyle(color: Colors.grey),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            new Container(
                              child: new Text('4-star hotel',
                                style: new TextStyle(
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            new Container(
                              child: new Text ('1 outdoor pool',
                                style: new TextStyle(color: Colors.grey),
                              ),
                            )
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        border: new Border(
                          right: BorderSide(
                              width: 2.0,
                              style: BorderStyle.solid,
                              color: Color.fromRGBO(192, 192, 192, 1)
                          ),
                        ),
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.only(left: 4.0),
                      child: new Text('NGN16,851',
                        style: TextStyle(
                          fontSize: ScreenUtil(allowFontScaling: true).setSp(25),
                        ),
                        textAlign: TextAlign.start,
                      ),
                    )
                  ],
                ),
              ),
            ),
            new Container(
              padding: new EdgeInsets.only (bottom: 20.0),
              decoration: BoxDecoration(
                border: new Border(
                  bottom: BorderSide(
                      width: 1.0,
                      style: BorderStyle.solid,
                      color: Color.fromRGBO(192, 192, 192, 1)
                  ),
                ),
              ),
              child: new GestureDetector (
                onTap: () {
                  Navigator.push (context,
                      MaterialPageRoute(builder: (context) => Oak(data: widget.data, password: widget.password))
                  );
                },
                child: new Row (
                  children: <Widget>[
                    new Container (
                      margin: new EdgeInsets.only (left: 20.0, top: 20.0),
                      child: new Container (
                        width: ScreenUtil.getInstance().setWidth(165),
                        height: ScreenUtil.getInstance().setHeight(165),
                        decoration: BoxDecoration (
                          image: new DecorationImage (
                            image: new AssetImage (
                                'assets/images/maps/hotels/oak.jpg'
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.only(
                        top: 18.0,
                      ),
                      child: new Container(
                        padding: new EdgeInsets.only (
                            right: 10.0
                        ),
                        child: new Column(
                          children: <Widget>[
                            new Container(
                              margin: new EdgeInsets.only(left: 12.0),
                              child: Text('1 Oak Place',
                                style: TextStyle (fontSize: 17.0),
                              ),
                            ),
                            new Container(
                              child: new Row (
                                children: <Widget>[
                                  new Container(
                                    margin: new EdgeInsets.only(left: 10.0),
                                    child: new Text('3.8',
                                      style: new TextStyle(
                                          color: Colors.orange,
                                          fontSize: 16.0
                                      ),
                                    ),
                                  ),
                                  new StarRating(
                                    size: 20.0,
                                    rating: 3.8,
                                    color: Colors.orange,
                                    borderColor: Colors.grey,
                                    starCount: starCount,
//                                    onRatingChanged: (rating) => setState(
//                                          () {
//                                        this.rating = rating;
//                                      },
//                                    ),
                                  ),
                                  new Container(
                                    child: new Text('(199)',
                                      style: new TextStyle(color: Colors.grey),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            new Container(
                              child: new Text('Hotel',
                                style: new TextStyle(
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        border: new Border(
                          right: BorderSide(
                              width: 2.0,
                              style: BorderStyle.solid,
                              color: Color.fromRGBO(192, 192, 192, 1)
                          ),
                        ),
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.only(left: 7.0),
                      child: new Text('NGN18,000',
                        style: TextStyle(
                          fontSize: ScreenUtil(allowFontScaling: true).setSp(25),
                        ),
                        textAlign: TextAlign.start,
                      ),
                    )
                  ],
                ),
              ),
            ),
            new Container(
              padding: new EdgeInsets.only (bottom: 20.0),
              decoration: BoxDecoration(
                border: new Border(
                  bottom: BorderSide(
                      width: 1.0,
                      style: BorderStyle.solid,
                      color: Color.fromRGBO(192, 192, 192, 1)
                  ),
                ),
              ),
              child: new GestureDetector (
                onTap: () {
                  Navigator.push (context,
                      MaterialPageRoute(builder: (context) => Kebbi(data: widget.data, password: widget.password))
                  );
                },
                child: new Row (
                  children: <Widget>[
                    new Container (
                      margin: new EdgeInsets.only (left: 20.0, top: 20.0),
                      child: new Container (
                        width: ScreenUtil.getInstance().setWidth(165),
                        height: ScreenUtil.getInstance().setHeight(165),
                        decoration: BoxDecoration (
                          image: new DecorationImage (
                            image: new AssetImage (
                                'assets/images/maps/hotels/kebbi.jpg'
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.only(
                        top: 18.0,
                      ),
                      child: new Container(
                        padding: new EdgeInsets.only (
                            right: 10.0
                        ),
                        child: new Column(
                          children: <Widget>[
                            new Container(
                              margin: new EdgeInsets.only(left: 12.0),
                              child: Text('Kebbi Hotel',
                                style: TextStyle (fontSize: 17.0),
                              ),
                            ),
                            new Container(
                              child: new Row (
                                children: <Widget>[
                                  new Container(
                                    margin: new EdgeInsets.only(left: 10.0),
                                    child: new Text('3.4',
                                      style: new TextStyle(
                                          color: Colors.orange,
                                          fontSize: 16.0
                                      ),
                                    ),
                                  ),
                                  new StarRating(
                                    size: 20.0,
                                    rating: 3.4,
                                    color: Colors.orange,
                                    borderColor: Colors.grey,
                                    starCount: starCount,
//                                    onRatingChanged: (rating) => setState(
//                                          () {
//                                        this.rating = rating;
//                                      },
//                                    ),
                                  ),
                                  new Container(
                                    child: new Text('(68)',
                                      style: new TextStyle(color: Colors.grey),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            new Container(
                              child: new Text('2-star hotel',
                                style: new TextStyle(
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        border: new Border(
                          right: BorderSide(
                              width: 2.0,
                              style: BorderStyle.solid,
                              color: Color.fromRGBO(192, 192, 192, 1)
                          ),
                        ),
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.only(left: 7.0),
                      child: new Text('NGN12,741',
                        style: TextStyle(
                          fontSize: ScreenUtil(allowFontScaling: true).setSp(25),
                        ),
                        textAlign: TextAlign.start,
                      ),
                    )
                  ],
                ),
              ),
            ),
            new Container(
              padding: new EdgeInsets.only (bottom: 20.0),
              decoration: BoxDecoration(
                border: new Border(
                  bottom: BorderSide(
                      width: 1.0,
                      style: BorderStyle.solid,
                      color: Color.fromRGBO(192, 192, 192, 1)
                  ),
                ),
              ),
              child: new GestureDetector (
                onTap: () {
                  Navigator.push (context,
                      MaterialPageRoute(builder: (context) => Elvis(data: widget.data, password: widget.password))
                  );
                },
                child: new Row (
                  children: <Widget>[
                    new Container (
                      margin: new EdgeInsets.only (left: 20.0, top: 20.0),
                      child: new Container (
                        width: ScreenUtil.getInstance().setWidth(165),
                        height: ScreenUtil.getInstance().setHeight(165),
                        decoration: BoxDecoration (
                          image: new DecorationImage (
                            image: new AssetImage (
                                'assets/images/maps/hotels/elvis.jpg'
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.only(
                        top: 18.0,
                      ),
                      child: new Container(
                        padding: new EdgeInsets.only (
                            right: 10.0
                        ),
                        child: new Column(
                          children: <Widget>[
                            new Container(
                              margin: new EdgeInsets.only(left: 12.0),
                              child: Text('BON Hotel Elvis',
                                style: TextStyle (fontSize: 17.0),
                              ),
                            ),
                            new Container(
                              child: new Row (
                                children: <Widget>[
                                  new Container(
                                    margin: new EdgeInsets.only(left: 10.0),
                                    child: new Text('4.4',
                                      style: new TextStyle(
                                          color: Colors.orange,
                                          fontSize: 16.0
                                      ),
                                    ),
                                  ),
                                  new StarRating(
                                    size: 20.0,
                                    rating: 4.4,
                                    color: Colors.orange,
                                    borderColor: Colors.grey,
                                    starCount: starCount,
//                                    onRatingChanged: (rating) => setState(
//                                          () {
//                                        this.rating = rating;
//                                      },
//                                    ),
                                  ),
                                  new Container(
                                    child: new Text('(26)',
                                      style: new TextStyle(color: Colors.grey),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            new Container(
                              child: new Text('Hotel',
                                style: new TextStyle(
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            new Container(
                              child: new Text('Free Wi-Fi',
                                style: new TextStyle(
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        border: new Border(
                          right: BorderSide(
                              width: 2.0,
                              style: BorderStyle.solid,
                              color: Color.fromRGBO(192, 192, 192, 1)
                          ),
                        ),
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.only(left: 7.0),
                      child: new Text('NGN35,415',
                        style: TextStyle(
                          fontSize: ScreenUtil(allowFontScaling: true).setSp(25),
                        ),
                        textAlign: TextAlign.start,
                      ),
                    )
                  ],
                ),
              ),
            ),
            new Container(
              padding: new EdgeInsets.only (bottom: 20.0),
              decoration: BoxDecoration(
                border: new Border(
                  bottom: BorderSide(
                      width: 1.0,
                      style: BorderStyle.solid,
                      color: Color.fromRGBO(192, 192, 192, 1)
                  ),
                ),
              ),
              child: new GestureDetector (
                onTap: () {
                  Navigator.push (context,
                      MaterialPageRoute(builder: (context) => Roses(data: widget.data, password: widget.password))
                  );
                },
                child: new Row (
                  children: <Widget>[
                    new Container (
                      margin: new EdgeInsets.only (left: 20.0, top: 20.0),
                      child: new Container (
                        width: ScreenUtil.getInstance().setWidth(165),
                        height: ScreenUtil.getInstance().setHeight(165),
                        decoration: BoxDecoration (
                          image: new DecorationImage (
                            image: new AssetImage (
                                'assets/images/maps/hotels/roses.jpg'
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.only(
                        top: 18.0,
                      ),
                      child: new Container(
                        padding: new EdgeInsets.only (
                            right: 10.0
                        ),
                        child: new Column(
                          children: <Widget>[
                            new Container(
                              margin: new EdgeInsets.only(left: 12.0),
                              child: Text('Roses Hotel',
                                style: TextStyle (fontSize: 17.0),
                              ),
                            ),
                            new Container(
                              child: new Row (
                                children: <Widget>[
                                  new Container(
                                    margin: new EdgeInsets.only(left: 10.0),
                                    child: new Text('4.0',
                                      style: new TextStyle(
                                          color: Colors.orange,
                                          fontSize: 16.0
                                      ),
                                    ),
                                  ),
                                  new StarRating(
                                    size: 20.0,
                                    rating: 4.0,
                                    color: Colors.orange,
                                    borderColor: Colors.grey,
                                    starCount: starCount,
//                                    onRatingChanged: (rating) => setState(
//                                          () {
//                                        this.rating = rating;
//                                      },
//                                    ),
                                  ),
                                  new Container(
                                    child: new Text('(17)',
                                      style: new TextStyle(color: Colors.grey),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            new Container(
                              child: new Text('Hotel',
                                style: new TextStyle(
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        border: new Border(
                          right: BorderSide(
                              width: 2.0,
                              style: BorderStyle.solid,
                              color: Color.fromRGBO(192, 192, 192, 1)
                          ),
                        ),
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.only(left: 7.0),
                      child: new Text('NGN15,068',
                        style: TextStyle(
                          fontSize: ScreenUtil(allowFontScaling: true).setSp(25),
                        ),
                        textAlign: TextAlign.start,
                      ),
                    )
                  ],
                ),
              ),
            ),
            new Container(
              padding: new EdgeInsets.only (bottom: 20.0),
              decoration: BoxDecoration(
                border: new Border(
                  bottom: BorderSide(
                      width: 1.0,
                      style: BorderStyle.solid,
                      color: Color.fromRGBO(192, 192, 192, 1)
                  ),
                ),
              ),
              child: new GestureDetector (
                onTap: () {
                  Navigator.push (context,
                      MaterialPageRoute(builder: (context) => Petrus(data: widget.data, password: widget.password))
                  );
                },
                child: new Row (
                  children: <Widget>[
                    new Container (
                      margin: new EdgeInsets.only (left: 20.0, top: 20.0),
                      child: new Container (
                        width: ScreenUtil.getInstance().setWidth(165),
                        height: ScreenUtil.getInstance().setHeight(165),
                        decoration: BoxDecoration (
                          image: new DecorationImage (
                            image: new AssetImage (
                                'assets/images/maps/hotels/petrus.jpg'
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.only(
                        top: 18.0,
                      ),
                      child: new Container(
                        padding: new EdgeInsets.only (
                            right: 10.0
                        ),
                        child: new Column(
                          children: <Widget>[
                            new Container(
                              margin: new EdgeInsets.only(left: 12.0),
                              child: Text('Petrus Hotel Royale',
                                style: TextStyle (fontSize: 17.0),
                              ),
                            ),
                            new Container(
                              child: new Row (
                                children: <Widget>[
                                  new Container(
                                    margin: new EdgeInsets.only(left: 10.0),
                                    child: new Text('3.8',
                                      style: new TextStyle(
                                          color: Colors.orange,
                                          fontSize: 16.0
                                      ),
                                    ),
                                  ),
                                  new StarRating(
                                    size: 20.0,
                                    rating: 3.8,
                                    color: Colors.orange,
                                    borderColor: Colors.grey,
                                    starCount: starCount,
//                                    onRatingChanged: (rating) => setState(
//                                          () {
//                                        this.rating = rating;
//                                      },
//                                    ),
                                  ),
                                  new Container(
                                    child: new Text('(94)',
                                      style: new TextStyle(color: Colors.grey),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            new Container(
                              child: new Text('3-star hotel',
                                style: new TextStyle(
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        border: new Border(
                          right: BorderSide(
                              width: 2.0,
                              style: BorderStyle.solid,
                              color: Color.fromRGBO(192, 192, 192, 1)
                          ),
                        ),
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.only(left: 7.0),
                      child: new Text('NGN15,500',
                        style: TextStyle(
                          fontSize: ScreenUtil(allowFontScaling: true).setSp(25),
                        ),
                        textAlign: TextAlign.start,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void choiceAction (String choice)
  {
    if (choice == Constants.Dashboard){
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Dashboard(data: widget.data, password: widget.password))
      );
    }
    else if (choice == Constants.EditProfile){
      if (_authStatus == AuthStatus.notSignedIn)
      {
        _showDialog(context);
      }
      else
      {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => EditProfile(data: widget.data, password: widget.password,))
        );
      }
    }
    else if (choice == Constants.Settings){
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Settings(data: widget.data, password: widget.password,))
      );
    }
  }

  void _showDialog (BuildContext context)
  {
    var alertDialog = AlertDialog(
      title: new Text('Login'),
      content: new Text('You are not Logged in'),
      actions: <Widget>[
        new FlatButton(
          child: new Text('Login'),
          onPressed: () {
            Navigator.push (context, MaterialPageRoute(builder: (context) => Login()));
          },
        ),
        new FlatButton(
          child: new Text('Register'),
          onPressed: () {
            Navigator.push (context, MaterialPageRoute(builder: (context) => Register()));
          },
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
//       if (progressString != '100%') {
        return alertDialog;

//       }
      },
//        barrierDismissible: false
    );
  }
}
