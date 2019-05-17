import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:icps/SpeakersJson.dart';
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
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:fluttertoast/fluttertoast.dart';

class NewSpeakers extends StatefulWidget {

  Data data;

  NewSpeakers({this.data});

  @override
  _NewSpeakersState createState() => _NewSpeakersState();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
  signedInSpeaker
}

class _NewSpeakersState extends State<NewSpeakers> {

  AuthStatus _authStatus = AuthStatus.notSignedIn;

  ScrollController controller;

  String url = 'http://icps19.com:6060/icps/resources/conferencepresentations/profilepics/';

  Future <List<ConferenceSpeaker>> _getSpeakers() async {
    String getUrl = 'http://icps19.com:6060/icps/icps/19/spe';

    var speakerData = await http.get(getUrl);

    var jsonData = speakerData.body;
    print(jsonData);

    List <ConferenceSpeaker> conferenceSpeaker = conferenceSpeakerFromJson(jsonData);

    List <ConferenceSpeaker> speaker = [];

    try
    {
      for (ConferenceSpeaker ss in conferenceSpeaker)
      {
        ConferenceSpeaker listSpeakers = ConferenceSpeaker (
          companysector: ss.companysector,
          conferenceId: ss.conferenceId,
          country: ss.country,
          email: ss.email,
          facebookId: ss.facebookId,
          firstname: ss.firstname,
          instagramId: ss.instagramId,
          loginstatus: ss.loginstatus,
          moderatorYn: ss.moderatorYn,
          organisation: ss.organisation,
          participantType: ss.participantType,
          phone: ss.phone,
          pic_id: ss.pic_id,
          shortProfile: ss.shortProfile,
          speakerYn: ss.speakerYn,
          surname: ss.surname,
          title: ss.title,
          twitterId: ss.twitterId,
          userinfoid: ss.userinfoid,
          username: ss.username,
          website: ss.website,
          workPosition: ss.workPosition
        );

        speaker.add(listSpeakers);

//        print(timeFormat);
      }
    }
    catch(e)
    {
      print('Error: $e');
    }

    print(speaker.length);

//    question..sort((a, b) => b.countvote.compareTo(a.countvote));

//    question..sort((a, b) => a.datetimeasked.compareTo(b.datetimeasked));

//    List <QuestionVote> questionsReversed = question.reversed.toList();

    return speaker;
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
        title: new Text("Speakers"),
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
                  future: _getSpeakers(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return new Container(
                        padding: new EdgeInsets.only(top: 225.0),
                        child: new Center(
                          child: CircularProgressIndicator(),
                        ),
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
                              (MediaQuery.of(context).size.height - 70),
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return new Card(
                            child: new GestureDetector(
//                              padding: new EdgeInsets.only(left: 5.0, right: 5.0),
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => SpeakersProfile(snapshot.data[index], widget.data))
                                );
                              },
                              child: new Column(
                                children: <Widget>[
                                  new Container(
                                    child: snapshot.data[index].pic_id == null ?
                                    new Stack(
                                      children: <Widget>[
                                        new Container(
                                          padding: new EdgeInsets.only(bottom: 53.0),
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
                                          child: new CircleAvatar(
                                            radius: 50.0,
                                            child: new Text('${snapshot.data[index].surname.substring(0, 1)}'
                                                '${snapshot.data[index].firstname.substring(0, 1)}',
                                              style: new TextStyle(
                                                  fontSize: 43.0
                                              ),
                                            ),
                                          )
                                        ),
                                        new Container(
                                          width: MediaQuery.of(context).size.width,
                                          height: ScreenUtil.getInstance().setHeight(301),
                                          color: Color.fromRGBO(180, 188, 151, 0.7),
                                        ),

                                        new Positioned(
                                          top: 50.0,
                                          left: 41.0,
                                          child: new CircleAvatar(
                                            radius: 50.0,
                                            child: new Text('${snapshot.data[index].surname.substring(0, 1)}'
                                                            '${snapshot.data[index].firstname.substring(0, 1)}',
                                              style: new TextStyle(
                                                fontSize: 43.0
                                              ),
                                            ),
                                          )
                                        )
//                                        new Positioned(
//                                          top: 8.0,
//                                          left: 24.0,
//                                          child: new CircleAvatar(
//                                            radius: 70.0,
//                                            backgroundImage: NetworkImage(url + snapshot.data[index].pic_id),
//                                            backgroundColor: Colors.transparent,
//                                          ),
//                                        ),
                                      ],
                                    ) :
                                    new Container(
                                      padding: new EdgeInsets.only(bottom: 53.0),
                                      width: MediaQuery.of(context).size.width,
                                      height: ScreenUtil.getInstance().setHeight(351),
                                      decoration: new BoxDecoration(
                                        image: new DecorationImage(
                                            image: new NetworkImage(url + snapshot.data[index].pic_id),
                                            fit: BoxFit.cover
                                        ),
                                      ),
                                    ),
                                  ),
                                  new Container(
                                    padding: new EdgeInsets.only(top: 10.0),
                                    child: new Column(
                                      children: <Widget>[
                                        new Container(
                                          padding: new EdgeInsets.only(bottom: 5.0),
                                          child: new Text(snapshot.data[index].title + ' ' +
                                                          snapshot.data[index].surname + ' ' +
                                                          snapshot.data[index].firstname,
                                            style: new TextStyle(
                                              fontSize: ScreenUtil(allowFontScaling: true).setSp(31),
                                            ),
                                          ),
                                        ),
                                        new Container(
                                            padding: new EdgeInsets.only(bottom: 3.0),
                                          child: new Text('${snapshot.data[index].workPosition}, ${snapshot.data[index].organisation}')
                                        ),
                                        snapshot.data[index].facebookId == null ?
                                        new Container() :
                                        new Container(
                                          padding: new EdgeInsets.only(bottom: 3.0),
                                          child: new Text('${snapshot.data[index].facebookId}'),
                                        ),
                                        snapshot.data[index].twitterId == null ?
                                        new Container() :
                                        new Container(
                                          padding: new EdgeInsets.only(bottom: 3.0),
                                          child: new Text('${snapshot.data[index].twitterId}'),
                                        ),
//                                        new Container(
//                                          padding: new EdgeInsets.only(bottom: 3.0),
//                                          child: new Text('Instagram Id'),
//                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          );
                        }
                    );
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _scrollListener() {
    print(controller.position.extentAfter);
    if (controller.position.extentAfter < 500) {
      setState(() {
        _getSpeakers();
      });
    }
  }

  void choiceAction (String choice)
  {
    if (choice == Constants.Dashboard){
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Dashboard())
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
            MaterialPageRoute(builder: (context) => EditProfile())
        );
      }
    }
    else if (choice == Constants.Settings){
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Settings())
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

class SpeakersProfile extends StatefulWidget {

  final ConferenceSpeaker conferenceSpeaker; Data data;

  SpeakersProfile(this.conferenceSpeaker, this.data);

  @override
  _SpeakersProfileState createState() => _SpeakersProfileState();
}

class _SpeakersProfileState extends State<SpeakersProfile> {

  AuthStatus _authStatus = AuthStatus.notSignedIn;

  String url = 'http://icps19.com:6060/icps/resources/conferencepresentations/profilepics/';

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
        title: new Text('${widget.conferenceSpeaker.surname} ${widget.conferenceSpeaker.firstname}'),
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
              new Stack(
                children: <Widget>[
                  new Container(
                    child: new Column(
                      children: <Widget>[
                        widget.conferenceSpeaker.pic_id == null ?
                        new Container(
                          decoration: new BoxDecoration(
                            image: new DecorationImage(image: new AssetImage('assets/images/splash/SplashBg.jpg'),
                              fit: BoxFit.cover,
                            ),
//                  color: Color.fromRGBO(180, 188, 151, 0.8),
                          ),
                          child: new Container(
                            padding: new EdgeInsets.only(top: 50.0, bottom: 50.0),
                            color: Color.fromRGBO(180, 188, 151, 0.8),
                            child: new Center(
                                child: new CircleAvatar(
                                  radius: 50.0,
                                  child: new Text('${widget.conferenceSpeaker.surname.substring(0, 1)}'
                                      '${widget.conferenceSpeaker.firstname.substring(0, 1)}',
                                    style: new TextStyle(
                                        fontSize: 43.0
                                    ),
                                  ),
                                )
//                        : CircleAvatar(
//                      radius: 50.0,
//                      backgroundImage: NetworkImage(url + widget.conferenceSpeaker.pic_id),
//                      backgroundColor: Colors.transparent,
//                    ),
                            ),
                          ),
                        ) :
                        new Container(
                          width: MediaQuery.of(context).size.width,
                          height: ScreenUtil.getInstance().setHeight(735),
                          decoration: new BoxDecoration(
                            image: new DecorationImage(
                              image: new NetworkImage(url + widget.conferenceSpeaker.pic_id),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.vertical(bottom: Radius.circular(50.0))
//                  color: Color.fromRGBO(180, 188, 151, 0.8),
                          ),
                        ),
                        new SizedBox(
                          height: ScreenUtil.getInstance().setHeight(435),
                        )
                      ],
                    ),
                  ),
                  new Positioned(
                    top: 220.0,
                    left: 20.0,
                    child: new Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: new Container(
                        padding: new EdgeInsets.all(25.0),
                        width: ScreenUtil.getInstance().setWidth(680),
//                        decoration: new BoxDecoration(
//                          color: Colors.white,
//                          borderRadius: new BorderRadius.circular(20.0),
//                        ),
                        child: new Column(
                          children: <Widget>[
                            new Container(
                              child: new Text('${widget.conferenceSpeaker.title} ${widget.conferenceSpeaker.surname} ${widget.conferenceSpeaker.firstname}',
                                style: new TextStyle(
                                    fontSize: ScreenUtil(allowFontScaling: true).setSp(46),
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            widget.conferenceSpeaker.shortProfile == null ?
                            new Center() :
                            new Container(
                              padding: new EdgeInsets.only(top: 18.0, bottom: 15.0),
                              width: ScreenUtil.getInstance().setWidth(550),
                              child: new Text('${widget.conferenceSpeaker.shortProfile}',
                                style: new TextStyle(
                                    fontSize: ScreenUtil(allowFontScaling: true).setSp(28),
                                    color: Colors.grey
                                ),
                              ),
                            ),
                            new Center (
                                child: new Container(
//                                  padding: new EdgeInsets.only(top: 30.0, bottom: 30.0),
                                    width: MediaQuery.of(context).size.width,
//                                  decoration: new BoxDecoration(
//                                      border: new Border(
//                                          bottom: new BorderSide(
//                                            width: 1.0,
//                                            style: BorderStyle.solid,
//                                            color: Color.fromRGBO(192, 192, 192, 1),
//                                          )
//                                      )
//                                  ),
                                    child: new Row(
//                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        new Container(
                                          padding: new EdgeInsets.only(left: 9.0, right: 10.0),
                                            child: new Icon(
                                                Icons.business_center
                                            )
                                        ),
                                        new Container(
                                          width: ScreenUtil.getInstance().setWidth(500),
                                          child: new Text('${widget.conferenceSpeaker.workPosition}, ${widget.conferenceSpeaker.organisation}',
                                            style: new TextStyle(
                                                fontSize: ScreenUtil(allowFontScaling: true).setSp(27)
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                )
                            ),
                            widget.conferenceSpeaker.facebookId == null ?
                            new Center() :
                            new Center (
                                child: new Container(
                                    padding: new EdgeInsets.only(top: 10.0, bottom: 10.0),
                                    width: MediaQuery.of(context).size.width,
//                                    decoration: new BoxDecoration(
//                                        border: new Border(
//                                            bottom: new BorderSide(
//                                              width: 1.0,
//                                              style: BorderStyle.solid,
//                                              color: Color.fromRGBO(192, 192, 192, 1),
//                                            )
//                                        )
//                                    ),
                                    child: new Row(
//                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        new Container(
                                            padding: new EdgeInsets.only(left: 9.0, right: 10.0),
                                            child: new Icon(
                                                FontAwesomeIcons.facebook
                                            )
                                        ),
                                        new Container(
                                          width: ScreenUtil.getInstance().setWidth(500),
                                          child: new Text('${widget.conferenceSpeaker.facebookId}',
                                            style: new TextStyle(
                                                fontSize: ScreenUtil(allowFontScaling: true).setSp(27)
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                )
                            ),
                            widget.conferenceSpeaker.twitterId == null ?
                            new Center() :
                            new Center (
                                child: new Container(
//                                    padding: new EdgeInsets.only(top: 30.0, bottom: 30.0),
                                    width: MediaQuery.of(context).size.width,
//                                    decoration: new BoxDecoration(
//                                        border: new Border(
//                                            bottom: new BorderSide(
//                                              width: 1.0,
//                                              style: BorderStyle.solid,
//                                              color: Color.fromRGBO(192, 192, 192, 1),
//                                            )
//                                        )
//                                    ),
                                    child: new Row(
//                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        new Container(
                                            padding: new EdgeInsets.only(left: 9.0, right: 10.0),
                                            child: new Icon(
                                                FontAwesomeIcons.twitter
                                            )
                                        ),
                                        new Container(
                                          width: ScreenUtil.getInstance().setWidth(500),
                                          child: new Text('${widget.conferenceSpeaker.twitterId}',
                                            style: new TextStyle(
                                                fontSize: ScreenUtil(allowFontScaling: true).setSp(27)
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
                  ),
                ],
              ),
//              new Center (
//                  child: new Container(
//                      padding: new EdgeInsets.only(top: 30.0, bottom: 30.0),
//                      width: MediaQuery.of(context).size.width,
//                      decoration: new BoxDecoration(
//                          border: new Border(
//                              bottom: new BorderSide(
//                                width: 1.0,
//                                style: BorderStyle.solid,
//                                color: Color.fromRGBO(192, 192, 192, 1),
//                              )
//                          )
//                      ),
//                      child: new Row(
//                        children: <Widget>[
//                          new Container(
//                              padding: new EdgeInsets.only(left: 30.0, right: 30.0),
//                              child: new Icon(
//                                  Icons.person
//                              )
//                          ),
//                          new Container(
//                            child: new Text('${widget.conferenceSpeaker.title} ${widget.conferenceSpeaker.surname} ${widget.conferenceSpeaker.firstname}',
//                              style: new TextStyle(
//                                  fontSize: ScreenUtil(allowFontScaling: true).setSp(36)
//                              ),
//                            ),
//                          )
//                        ],
//                      )
//                  )
//              ),
//              new Center (
//                  child: new Container(
//                      padding: new EdgeInsets.only(top: 30.0, bottom: 30.0),
//                      width: MediaQuery.of(context).size.width,
//                      decoration: new BoxDecoration(
//                          border: new Border(
//                              bottom: new BorderSide(
//                                width: 1.0,
//                                style: BorderStyle.solid,
//                                color: Color.fromRGBO(192, 192, 192, 1),
//                              )
//                          )
//                      ),
//                      child: new Row(
//                        children: <Widget>[
//                          new Container(
//                              padding: new EdgeInsets.only(left: 30.0, right: 30.0),
//                              child: new Icon(
//                                  Icons.business_center
//                              )
//                          ),
//                          new Container(
//                            width: ScreenUtil.getInstance().setWidth(550),
//                            child: new Text('${widget.conferenceSpeaker.workPosition}, ${widget.conferenceSpeaker.organisation}',
//                              style: new TextStyle(
//                                  fontSize: ScreenUtil(allowFontScaling: true).setSp(36)
//                              ),
//                            ),
//                          )
//                        ],
//                      )
//                  )
//              ),
//              widget.conferenceSpeaker.facebookId == null ?
//              new Center() :
//              new Center (
//                  child: new Container(
//                      padding: new EdgeInsets.only(top: 30.0, bottom: 30.0),
//                      width: MediaQuery.of(context).size.width,
//                      decoration: new BoxDecoration(
//                          border: new Border(
//                              bottom: new BorderSide(
//                                width: 1.0,
//                                style: BorderStyle.solid,
//                                color: Color.fromRGBO(192, 192, 192, 1),
//                              )
//                          )
//                      ),
//                      child: new Row(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          new Container(
//                              padding: new EdgeInsets.only(left: 30.0, right: 30.0),
//                              child: new Icon(
//                                  FontAwesomeIcons.facebook
//                              )
//                          ),
//                          new Container(
//                            width: ScreenUtil.getInstance().setWidth(550),
//                            child: new Text('${widget.conferenceSpeaker.facebookId}',
//                              style: new TextStyle(
//                                  fontSize: ScreenUtil(allowFontScaling: true).setSp(31)
//                              ),
//                            ),
//                          )
//                        ],
//                      )
//                  )
//              ),
//              widget.conferenceSpeaker.twitterId == null ?
//              new Center() :
//              new Center (
//                  child: new Container(
//                      padding: new EdgeInsets.only(top: 30.0, bottom: 30.0),
//                      width: MediaQuery.of(context).size.width,
//                      decoration: new BoxDecoration(
//                          border: new Border(
//                              bottom: new BorderSide(
//                                width: 1.0,
//                                style: BorderStyle.solid,
//                                color: Color.fromRGBO(192, 192, 192, 1),
//                              )
//                          )
//                      ),
//                      child: new Row(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          new Container(
//                              padding: new EdgeInsets.only(left: 30.0, right: 30.0),
//                              child: new Icon(
//                                  FontAwesomeIcons.twitter
//                              )
//                          ),
//                          new Container(
//                            width: ScreenUtil.getInstance().setWidth(550),
//                            child: new Text('${widget.conferenceSpeaker.twitterId}',
//                              style: new TextStyle(
//                                  fontSize: ScreenUtil(allowFontScaling: true).setSp(31)
//                              ),
//                            ),
//                          )
//                        ],
//                      )
//                  )
//              ),
//              widget.conferenceSpeaker.shortProfile == null ?
//              new Center() :
//              new Center (
//                  child: new Container(
//                      padding: new EdgeInsets.only(top: 30.0, bottom: 30.0),
//                      width: MediaQuery.of(context).size.width,
//                      decoration: new BoxDecoration(
//                          border: new Border(
//                              bottom: new BorderSide(
//                                width: 1.0,
//                                style: BorderStyle.solid,
//                                color: Color.fromRGBO(192, 192, 192, 1),
//                              )
//                          )
//                      ),
//                      child: new Row(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          new Container(
//                              padding: new EdgeInsets.only(left: 30.0, right: 30.0),
//                              child: new Icon(
//                                  Icons.person_pin
//                              )
//                          ),
//                          new Container(
//                            width: ScreenUtil.getInstance().setWidth(550),
//                            child: new Text('${widget.conferenceSpeaker.shortProfile}',
//                              style: new TextStyle(
//                                  fontSize: ScreenUtil(allowFontScaling: true).setSp(32)
//                              ),
//                            ),
//                          )
//                        ],
//                      )
//                  )
//              ),
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
          MaterialPageRoute(builder: (context) => Dashboard())
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
            MaterialPageRoute(builder: (context) => EditProfile())
        );
      }
    }
    else if (choice == Constants.Settings){
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Settings())
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

