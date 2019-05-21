import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:icps/Constants.dart';
import 'package:icps/app_screens/Register.dart';
import 'package:icps/app_screens/drawer/Login.dart';

import 'package:icps/app_screens/popupMenu/Dashboard.dart';
import 'package:icps/app_screens/popupMenu/EditProfile.dart';
import 'package:icps/app_screens/popupMenu/Settings.dart';

import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:icps/app_screens/activity_feed/NewFeed.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
//import 'package:fluttertoast/fluttertoast.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:icps/PartnersJson.dart';
import 'package:flutter_rating/flutter_rating.dart';

class NewPartners extends StatefulWidget {

  Data data; String password;

  NewPartners({this.data, this.password});

  @override
  _NewPartnersState createState() => _NewPartnersState();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
  signedInSpeaker
}

class _NewPartnersState extends State<NewPartners> {

  AuthStatus _authStatus = AuthStatus.notSignedIn;

  ScrollController controller;

  String url = 'http://icps19.com:6060/icps/resources/conferencepresentations/partners/';

  Future <List<Partners>> _getPartners() async {
    String getUrl = 'http://icps19.com:6060/icps/icps/19/pal';

    var partnerData = await http.get(getUrl);

    var jsonData = partnerData.body;
    print(jsonData);
    print('get');
    List <Partners> partnersLoad = partnersFromJson(jsonData);
    print('get');
    List <Partners> partner = [];

    try
    {

      for (Partners ss in partnersLoad)
      {
        Partners listPartner = Partners(
            briefProfile: ss.briefProfile,
            contact: ss.contact,
            createdDate: ss.createdDate,
            email: ss.email,
            id: ss.id,
            name: ss.name,
            partnercategory: ss.partnercategory,
            partnerpaymentstatus: ss.partnerpaymentstatus,
            picId: ss.picId,
            userinfoid: ss.userinfoid,
//            usersInfo: ss.usersInfo,
            website: ss.website,
            text: ss.text
        );

        partner.add(listPartner);

//        print(timeFormat);
      }
    }
    catch(e)
    {
      print('Error: $e');
    }

    print(partner.length);
    print(partner);

//    question..sort((a, b) => b.countvote.compareTo(a.countvote));

//    question..sort((a, b) => a.datetimeasked.compareTo(b.datetimeasked));

//    List <QuestionVote> questionsReversed = question.reversed.toList();

    return partner;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = new ScrollController()..addListener(_scrollListener);

    widget.data = widget.data ?? Data();

    _authStatus = ((widget.data.surname == '')) ? AuthStatus.notSignedIn : (widget.data.speaker && widget.data.surname != '') ? AuthStatus.signedInSpeaker : AuthStatus.signedIn;

  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334, allowFontScaling: true)..init(context);
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(152, 160, 87, 1),
        title: new Text("Partners"),
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
        child: new Column(
          children: <Widget>[
            new Container(
              margin: new EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0, bottom: 20.0),
              child: new FutureBuilder(
                future: _getPartners(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return new Container(
                      padding: new EdgeInsets.only(top: 225.0),
                      child: new Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  else if (snapshot.data.length == 0) {
                    return new Center(
                        child: new Container(
                          padding: new EdgeInsets.only(top: 35.0),
                          child: new Text('No Partner here yet',
                            style: new TextStyle(
                              fontSize: ScreenUtil(
                                  allowFontScaling: true)
                                  .setSp(31),
                            ),
                          ),
                        )
                    );
                  }
                  return GridView.builder(
                    controller: controller,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: snapshot.data.length,
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height - 40),
                    ),
                      itemBuilder: (BuildContext context, int index) {
                        return new Card(
                          child: new GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => PartnersProfile(partners: snapshot.data[index], data: widget.data, password: widget.password,))
                              );
                            },
//                            padding: new EdgeInsets.only(left: 5.0, right: 5.0),
                            child: new Column(
                                children: <Widget>[
                                  new Container(
                                    child: snapshot.data[index].picId == null ?
                                    new Stack(
                                      children: <Widget>[
                                        new Container(
                                          padding: new EdgeInsets.only(bottom: 53.0, top: 53.0),
                                          width: MediaQuery.of(context).size.width,
                                          height: ScreenUtil.getInstance().setHeight(301),
                                          decoration: new BoxDecoration(
                                            image: new DecorationImage(
                                                image: new AssetImage(
                                                    'assets/images/splash/SplashBg.jpg'
                                                ),
                                                fit: BoxFit.cover
                                            ),
                                          ),
                                        ),
//                                        new Container(
//                                          width: MediaQuery.of(context).size.width,
//                                          height: ScreenUtil.getInstance().setHeight(301),
//                                          color: Color.fromRGBO(180, 188, 151, 0.7),
//                                        ),
                                        new Positioned(
                                          top: 30.0,
                                          left: 39.0,
                                          child: new CircleAvatar(
                                            radius: 50.0,
                                            child: new Text('${snapshot.data[index].name.substring(0, 1)}',
                                              style: new TextStyle(
                                                  fontSize: 43.0
                                              ),
                                            ),
                                          )
//                                              : CircleAvatar(
//                                            radius: 50.0,
//                                            backgroundImage: CachedNetworkImageProvider(url + snapshot.data[index].picId),
//                                            backgroundColor: Colors.transparent,
//                                          ),
                                        ),
                                      ],
                                    ) :
                                    new Container(
                                      padding: new EdgeInsets.only(bottom: 53.0, top: 53.0),
                                      width: MediaQuery.of(context).size.width,
                                      height: ScreenUtil.getInstance().setHeight(351),
                                      decoration: new BoxDecoration(
                                        image: new DecorationImage(
                                            image: new CachedNetworkImageProvider(url + snapshot.data[index].picId),
                                            fit: BoxFit.cover
                                        ),
                                      ),
                                    ),
                                  ),
                                  new Container(
                                    padding: new EdgeInsets.only(top: 10.0, left: 9.0, right: 9.0),
                                    child: new Column(
                                      children: <Widget>[
                                        new Container(
                                          padding: new EdgeInsets.only(bottom: 5.0),
                                          child: new Text(snapshot.data[index].name,
                                            style: new TextStyle(
                                              fontSize: ScreenUtil(allowFontScaling: true).setSp(31),
                                            ),
                                          ),
                                        ),
                                        new Container(
                                            padding: new EdgeInsets.only(bottom: 3.0),
                                            child: new Text('${snapshot.data[index].partnercategory}')
                                        ),
//                                        new Container(
//                                          padding: new EdgeInsets.only(bottom: 3.0),
//                                          child: new Text('${snapshot.data[index].email}'),
//                                        ),
                                        new Container(
                                          padding: new EdgeInsets.only(bottom: 3.0),
                                          child: new Text('${snapshot.data[index].website}'),
                                        ),
//                                        new Container(
//                                          padding: new EdgeInsets.only(bottom: 3.0),
//                                          child: new Text('${snapshot.data[index].contact}'),
//                                        ),
//                                        new Container(
//                                          padding: new EdgeInsets.only(bottom: 3.0),
//                                          child: new Text('${snapshot.data[index].briefProfile}'),
//                                        ),
                                      ],
                                    ),
                                  ),
                                ]
                            ),
                          ),
                        );
                      }
                  );
                }
              ),
            ),
          ]
        )
      )
    );
  }

  void _scrollListener() {
    print(controller.position.extentAfter);
    if (controller.position.extentAfter < 500) {
      setState(() {
        _getPartners();
      });
    }
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
            MaterialPageRoute(builder: (context) => EditProfile(data: widget.data, password: widget.password))
        );
      }
    }
    else if (choice == Constants.Settings){
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Settings(data: widget.data, password: widget.password))
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

class PartnersProfile extends StatefulWidget {

  final Partners partners; Data data; String password;

  PartnersProfile({this.partners, this.data, this.password});

  @override
  _PartnersProfileState createState() => _PartnersProfileState();
}

class _PartnersProfileState extends State<PartnersProfile> {

  AuthStatus _authStatus = AuthStatus.notSignedIn;

  String url = 'http://icps19.com:6060/icps/resources/conferencepresentations/partners/';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.data = widget.data ?? Data();

    _authStatus = ((widget.data.surname == '')) ? AuthStatus.notSignedIn : (widget.data.speaker && widget.data.surname != '') ? AuthStatus.signedInSpeaker : AuthStatus.signedIn;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(152, 160, 87, 1),
        title: new Text('${widget.partners.name}'),
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
        child: new Container(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
            widget.partners.picId == null ?
              new Container(
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage('assets/images/splash/SplashBg.jpg'),
                    fit: BoxFit.cover,
                  ),
//                  color: Color.fromRGBO(180, 188, 151, 0.8),
                ),
                child: new CircleAvatar(
                  radius: 50.0,
                  child: new Text('${widget.partners.name.substring(0, 1)}',
                    style: new TextStyle(
                        fontSize: 43.0
                    ),
                  ),
                )
//                child: new Container(
//                  padding: new EdgeInsets.only(top: 50.0, bottom: 50.0),
//                  color: Color.fromRGBO(180, 188, 151, 0.8),
//                  child: new Center(
//                    child: widget.partners.picId == null
//                        ? new CircleAvatar(
//                      radius: 50.0,
//                      child: new Text('${widget.partners.name.substring(0, 1)}',
//                        style: new TextStyle(
//                            fontSize: 43.0
//                        ),
//                      ),
//                    )
//                        : CircleAvatar(
//                      radius: 50.0,
//                      backgroundImage: NetworkImage(url + widget.partners.picId),
//                      backgroundColor: Colors.transparent,
//                    ),
//                  ),
//                ),
              ) :
              new Container(
                width: MediaQuery.of(context).size.width,
                height: ScreenUtil.getInstance().setHeight(735),
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new CachedNetworkImageProvider(url + widget.partners.picId),
                    fit: BoxFit.cover,
                  ),
  //                  color: Color.fromRGBO(180, 188, 151, 0.8),
                ),
//              child: new Text('${widget.partners.name.substring(0, 1)}',
//                style: new TextStyle(
//                    fontSize: 43.0
//                ),
//              ),
//                child: new Container(
//                  padding: new EdgeInsets.only(top: 50.0, bottom: 50.0),
//                  color: Color.fromRGBO(180, 188, 151, 0.8),
//                  child: new Center(
//                    child: widget.partners.picId == null
//                        ? new CircleAvatar(
//                      radius: 50.0,
//                      child: new Text('${widget.partners.name.substring(0, 1)}',
//                        style: new TextStyle(
//                            fontSize: 43.0
//                        ),
//                      ),
//                    )
//                        : CircleAvatar(
//                      radius: 50.0,
//                      backgroundImage: NetworkImage(url + widget.partners.picId),
//                      backgroundColor: Colors.transparent,
//                    ),
//                  ),
//                ),
            ),
              new Center (
                  child: new Container(
                      padding: new EdgeInsets.only(top: 30.0, bottom: 30.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: new BoxDecoration(
                          border: new Border(
                              bottom: new BorderSide(
                                width: 1.0,
                                style: BorderStyle.solid,
                                color: Color.fromRGBO(192, 192, 192, 1),
                              )
                          )
                      ),
                      child: new Row(
                        children: <Widget>[
                          new Container(
                              padding: new EdgeInsets.only(left: 30.0, right: 30.0),
                              child: new Icon(
                                  Icons.domain
                              )
                          ),
                          new Container(
                            child: new Text('${widget.partners.name}',
                              style: new TextStyle(
                                  fontSize: ScreenUtil(allowFontScaling: true).setSp(36)
                              ),
                            ),
                          )
                        ],
                      )
                  )
              ),
              new Center (
                  child: new Container(
                      padding: new EdgeInsets.only(top: 30.0, bottom: 30.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: new BoxDecoration(
                          border: new Border(
                              bottom: new BorderSide(
                                width: 1.0,
                                style: BorderStyle.solid,
                                color: Color.fromRGBO(192, 192, 192, 1),
                              )
                          )
                      ),
                      child: new Row(
                        children: <Widget>[
                          new Container(
                              padding: new EdgeInsets.only(left: 30.0, right: 30.0),
                              child: new Icon(
                                  Icons.star
                              )
                          ),
                          new Container(
                            width: ScreenUtil.getInstance().setWidth(250),
                            child: new Text('${widget.partners.partnercategory}',
                              style: new TextStyle(
                                  fontSize: ScreenUtil(allowFontScaling: true).setSp(36)
                              ),
                            ),
                          ),
                          new StarRating(
                            size: 20.0,
                            rating: widget.partners.partnercategory == 'Platinum' ? 5 :
                            widget.partners.partnercategory == 'Diamond' ? 4 :
                            widget.partners.partnercategory == 'Gold' ? 3 :
                            2,
                            color: Colors.orange,
                            borderColor: Colors.grey,
                            starCount: widget.partners.partnercategory == 'Platinum' ? 5 :
                            widget.partners.partnercategory == 'Diamond' ? 4 :
                            widget.partners.partnercategory == 'Gold' ? 3 :
                            2,
                          ),
                        ],
                      )
                  )
              ),
              new Center (
                  child: new Container(
                      padding: new EdgeInsets.only(top: 30.0, bottom: 30.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: new BoxDecoration(
                          border: new Border(
                              bottom: new BorderSide(
                                width: 1.0,
                                style: BorderStyle.solid,
                                color: Color.fromRGBO(192, 192, 192, 1),
                              )
                          )
                      ),
                      child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Container(
                              padding: new EdgeInsets.only(left: 30.0, right: 30.0),
                              child: new Icon(
                                  Icons.email
                              )
                          ),
                          new Container(
                            width: ScreenUtil.getInstance().setWidth(550),
                            child: new Text('${widget.partners.email}',
                              style: new TextStyle(
                                  fontSize: ScreenUtil(allowFontScaling: true).setSp(31)
                              ),
                            ),
                          )
                        ],
                      )
                  )
              ),
              new Center (
                  child: new Container(
                      padding: new EdgeInsets.only(top: 30.0, bottom: 30.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: new BoxDecoration(
                          border: new Border(
                              bottom: new BorderSide(
                                width: 1.0,
                                style: BorderStyle.solid,
                                color: Color.fromRGBO(192, 192, 192, 1),
                              )
                          )
                      ),
                      child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Container(
                              padding: new EdgeInsets.only(left: 30.0, right: 30.0),
                              child: new Icon(
                                  Icons.public
                              )
                          ),
                          new Container(
                            width: ScreenUtil.getInstance().setWidth(550),
                            child: new Text('${widget.partners.website}',
                              style: new TextStyle(
                                  fontSize: ScreenUtil(allowFontScaling: true).setSp(31)
                              ),
                            ),
                          )
                        ],
                      )
                  )
              ),
              new Center (
                  child: new Container(
                      padding: new EdgeInsets.only(top: 30.0, bottom: 30.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: new BoxDecoration(
                          border: new Border(
                              bottom: new BorderSide(
                                width: 1.0,
                                style: BorderStyle.solid,
                                color: Color.fromRGBO(192, 192, 192, 1),
                              )
                          )
                      ),
                      child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Container(
                              padding: new EdgeInsets.only(left: 30.0, right: 30.0),
                              child: new Icon(
                                  Icons.domain
                              )
                          ),
                          new Container(
                            width: ScreenUtil.getInstance().setWidth(550),
                            child: new Text('${widget.partners.contact}',
                              style: new TextStyle(
                                  fontSize: ScreenUtil(allowFontScaling: true).setSp(31)
                              ),
                            ),
                          )
                        ],
                      )
                  )
              ),
              new Center (
                  child: new Container(
                      padding: new EdgeInsets.only(top: 30.0, bottom: 30.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: new BoxDecoration(
                          border: new Border(
                              bottom: new BorderSide(
                                width: 1.0,
                                style: BorderStyle.solid,
                                color: Color.fromRGBO(192, 192, 192, 1),
                              )
                          )
                      ),
                      child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Container(
                              padding: new EdgeInsets.only(left: 30.0, right: 30.0),
                              child: new Icon(
                                  Icons.description
                              )
                          ),
                          new Container(
                            width: ScreenUtil.getInstance().setWidth(550),
                            child: new Text('${widget.partners.briefProfile}',
                              style: new TextStyle(
                                  fontSize: ScreenUtil(allowFontScaling: true).setSp(32)
                              ),
                            ),
                          )
                        ],
                      )
                  )
              ),
              widget.partners.text == null ?
              new Center() :
              new Center (
                  child: new Container(
                      padding: new EdgeInsets.only(top: 30.0, bottom: 30.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: new BoxDecoration(
                          border: new Border(
                              bottom: new BorderSide(
                                width: 1.0,
                                style: BorderStyle.solid,
                                color: Color.fromRGBO(192, 192, 192, 1),
                              )
                          )
                      ),
                      child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Container(
                              padding: new EdgeInsets.only(left: 30.0, right: 30.0),
                              child: new Icon(
                                  Icons.description
                              )
                          ),
                          new Container(
                            width: ScreenUtil.getInstance().setWidth(550),
                            child: new Text('${widget.partners.text}',
                              style: new TextStyle(
                                  fontSize: ScreenUtil(allowFontScaling: true).setSp(32)
                              ),
                            ),
                          )
                        ],
                      )
                  )
              ),
            ],
          ),
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
            MaterialPageRoute(builder: (context) => EditProfile(data: widget.data, password: widget.password))
        );
      }
    }
    else if (choice == Constants.Settings){
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Settings(data: widget.data, password: widget.password))
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
