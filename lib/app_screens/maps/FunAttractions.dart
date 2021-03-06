import 'package:flutter/material.dart';
// import 'package:icps/app_screens/Locations.dart';
import 'package:icps/app_screens/maps/fun_attractions/Ibb.dart';
import 'package:icps/app_screens/maps/fun_attractions/Millennium.dart';
import 'package:icps/app_screens/maps/fun_attractions/Funville.dart';
import 'package:icps/app_screens/maps/fun_attractions/Jojo.dart';
import 'package:icps/app_screens/maps/fun_attractions/Zoo.dart';
import 'package:icps/app_screens/maps/fun_attractions/Genesis.dart';
import 'package:icps/app_screens/maps/fun_attractions/Jabi.dart';
import 'package:icps/app_screens/maps/fun_attractions/Usuma.dart';
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
    home: FunAttractions(),
    theme: ThemeData(
        fontFamily: 'Montserrat'
    ),
  )
  );
}

class FunAttractions extends StatefulWidget {

  Data data; String password;

  FunAttractions({this.data, this.password});

  @override
  _FunAttractionsState createState() => _FunAttractionsState();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
  signedInSpeaker
}

class _FunAttractionsState extends State<FunAttractions>
{
  double rating = 4.4;
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
        title: new Text("Fun Attractions"),
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
                      MaterialPageRoute(builder: (context) => Ibb(data: widget.data, password: widget.password))
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
                                'assets/images/maps/fun_attractions/ibb.jpg'
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
                              child: Text('IBB International Golf & Country Club',
                                style: TextStyle (fontSize: ScreenUtil(allowFontScaling: true).setSp(31),),
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
                                    child: new Text('(359)',
                                      style: new TextStyle(color: Colors.grey),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            new Container(
                              child: new Text('Golf Course',
                                style: new TextStyle(
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            new Container(
                              child: new Text('Open until 8:00 pm',
                                style: new TextStyle(
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
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
                      MaterialPageRoute(builder: (context) => Millennium(data: widget.data, password: widget.password))
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
                                'assets/images/maps/fun_attractions/millennium.jpg'
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
                              child: Text('Millennium Park',
                                style: TextStyle (fontSize: ScreenUtil(allowFontScaling: true).setSp(31),),
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
                                    child: new Text('(115)',
                                      style: new TextStyle(color: Colors.grey),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            new Container(
                              child: new Text('Park',
                                style: new TextStyle(
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
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
                      MaterialPageRoute(builder: (context) => Funville(data: widget.data, password: widget.password))
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
                                'assets/images/maps/fun_attractions/funville.jpg'
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
                              child: Text('Kidz Funville',
                                style: TextStyle (fontSize: ScreenUtil(allowFontScaling: true).setSp(31),),
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
                                    child: new Text('(141)',
                                      style: new TextStyle(color: Colors.grey),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            new Container(
                              child: new Text('Park',
                                style: new TextStyle(
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
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
                      MaterialPageRoute(builder: (context) => Jojo(data: widget.data, password: widget.password))
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
                                'assets/images/maps/fun_attractions/jojo.jpg'
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
                              child: Text('Jojo\'s Fun Water Park',
                                style: TextStyle (fontSize: ScreenUtil(allowFontScaling: true).setSp(31),),
                              ),
                            ),
                            new Container(
                              child: new Row (
                                children: <Widget>[
                                  new Container(
                                    margin: new EdgeInsets.only(left: 10.0),
                                    child: new Text('3.5',
                                      style: new TextStyle(
                                          color: Colors.orange,
                                          fontSize: 16.0
                                      ),
                                    ),
                                  ),
                                  new StarRating(
                                    size: 20.0,
                                    rating: 3.5,
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
                                    child: new Text('(2)',
                                      style: new TextStyle(color: Colors.grey),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            new Container(
                              child: new Text('Park',
                                style: new TextStyle(
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            new Container(
                              child: new Text('Open until 6:00 pm',
                                style: new TextStyle(
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
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
                      MaterialPageRoute(builder: (context) => Zoo(data: widget.data, password: widget.password))
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
                                'assets/images/maps/fun_attractions/zoo.jpg'
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
                              child: Text('National Childrens\' Park and Zoo',
                                style: TextStyle (fontSize: ScreenUtil(allowFontScaling: true).setSp(31),),
                              ),
                            ),
                            new Container(
                              child: new Row (
                                children: <Widget>[
                                  new Container(
                                    margin: new EdgeInsets.only(left: 10.0),
                                    child: new Text('3.7',
                                      style: new TextStyle(
                                          color: Colors.orange,
                                          fontSize: 16.0
                                      ),
                                    ),
                                  ),
                                  new StarRating(
                                    size: 20.0,
                                    rating: 3.7,
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
                                    child: new Text('(369)',
                                      style: new TextStyle(color: Colors.grey),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            new Container(
                              child: new Text('Zoo',
                                style: new TextStyle(
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            new Container(
                              child: new Text('Open until 6:00 pm',
                                style: new TextStyle(
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
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
                      MaterialPageRoute(builder: (context) => Genesis(data: widget.data, password: widget.password))
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
                                'assets/images/maps/fun_attractions/genesis.jpg'
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
                              child: Text('Genesis Cinema',
                                style: TextStyle (fontSize: ScreenUtil(allowFontScaling: true).setSp(31),),
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
                                    child: new Text('(32)',
                                      style: new TextStyle(color: Colors.grey),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            new Container(
                              child: new Text('Movie theater',
                                style: new TextStyle(
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
                      MaterialPageRoute(builder: (context) => Jabi(data: widget.data, password: widget.password))
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
                                'assets/images/maps/fun_attractions/jabi.jpg'
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
                              child: Text('Jabi Lake Hill',
                                style: TextStyle (fontSize: ScreenUtil(allowFontScaling: true).setSp(31),),
                              ),
                            ),
                            new Container(
                              child: new Row (
                                children: <Widget>[
                                  new Container(
                                    margin: new EdgeInsets.only(left: 10.0),
                                    child: new Text('4.2',
                                      style: new TextStyle(
                                          color: Colors.orange,
                                          fontSize: 16.0
                                      ),
                                    ),
                                  ),
                                  new StarRating(
                                    size: 20.0,
                                    rating: 4.2,
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
                                    child: new Text('(10)',
                                      style: new TextStyle(color: Colors.grey),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            new Container(
                              child: new Text('Tourist attraction',
                                style: new TextStyle(
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
                      MaterialPageRoute(builder: (context) => Usuma(data: widget.data, password: widget.password))
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
                                'assets/images/maps/fun_attractions/usuma.jpg'
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
                              child: Text('Usuma Lower Dam',
                                style: TextStyle (fontSize: ScreenUtil(allowFontScaling: true).setSp(31),),
                              ),
                            ),
                            new Container(
                              child: new Row (
                                children: <Widget>[
                                  new Container(
                                    margin: new EdgeInsets.only(left: 10.0),
                                    child: new Text('4.2',
                                      style: new TextStyle(
                                          color: Colors.orange,
                                          fontSize: 16.0
                                      ),
                                    ),
                                  ),
                                  new StarRating(
                                    size: 20.0,
                                    rating: 4.2,
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
                                    child: new Text('(9)',
                                      style: new TextStyle(color: Colors.grey),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            new Container(
                              child: new Text('Tourist attraction',
                                style: new TextStyle(
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
