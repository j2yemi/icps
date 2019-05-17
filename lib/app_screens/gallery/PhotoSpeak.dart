import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icps/app_screens/HomePage.dart';
import 'package:icps/app_screens/gallery/PhotoSpeak/SharePic.dart';
import 'package:icps/PhotoSpeakJson.dart';
import 'package:icps/Constants.dart';
import 'package:icps/app_screens/Register.dart';
import 'package:icps/app_screens/drawer/Login.dart';

import 'package:icps/app_screens/popupMenu/Dashboard.dart';
import 'package:icps/app_screens/popupMenu/EditProfile.dart';
import 'package:icps/app_screens/popupMenu/Settings.dart';

import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class PhotoSpeak extends StatefulWidget {

  Data data; String password;

  PhotoSpeak({this.data, this.password});

  @override
  _PhotoSpeakState createState() => _PhotoSpeakState();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
  signedInSpeaker
}

class _PhotoSpeakState extends State<PhotoSpeak> {

  ScrollController controller;

  AuthStatus _authStatus = AuthStatus.notSignedIn;

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  String url = 'http://icps19.com:6060/icps/resources/conferencepresentations/mediasharing/';

  String profileUrl = 'http://icps19.com:6060/icps/resources/conferencepresentations/profilepics/';

  Future <List<PhotoSpeakk>> _getPhotoSpeak() async {
    String getUrl = 'http://icps19.com:6060/icps/icps/19/shl';

    var photoData = await http.get(getUrl);

    var jsonData = photoData.body;
    print(jsonData);
    print('get');
    List <PhotoSpeakk> photoSpeakLoad = photoSpeakFromJson(jsonData);
    print('get');
    List <PhotoSpeakk> photo = [];

    try
    {

      for (PhotoSpeakk ss in photoSpeakLoad)
      {

        ss.createdDateTime = '${ss.createdDateTime.substring(0, 10)} ${ss.createdDateTime.substring(11, 19)}';

        print(ss.createdDateTime);

        DateTime dated = DateTime.parse(ss.createdDateTime);

        DateTime timeNow = new DateTime.now();

        print (dated.year);

        var timeAsked = DateTime(dated.year, dated.month, dated.day, dated.hour, dated.minute, dated.second);

        var differenceTimeAsked = timeNow.difference(timeAsked);

        var time;

        print (differenceTimeAsked);

        if (differenceTimeAsked.inHours > 24)
        {
          if (differenceTimeAsked.inHours * 24 < 2)
          {
            time = '${differenceTimeAsked.inHours.round().toString()} day ago';
          }
          else if (differenceTimeAsked.inHours * 24 == 2)
          {
            time = '${differenceTimeAsked.inHours.round().toString()} days ago';
          }
          else
          {
            time = DateFormat('EEEE, MMM d, ''yyyy').format(dated);
          }
        }
        else if (((differenceTimeAsked.inMinutes) - 60 > 60) && (differenceTimeAsked.inHours < 24)) {
          if (differenceTimeAsked.inHours < 2)
          {
            time = '${differenceTimeAsked.inHours.round().toString()} hour ago';
          }
          else
          {
            time = '${differenceTimeAsked.inHours.round().toString()} hours ago';
          }
        }
        else if ((differenceTimeAsked.inSeconds) - (60 * 60) - 60 > 60 && (differenceTimeAsked.inMinutes) - 60 < 60)
        {
          if ((differenceTimeAsked.inMinutes) - 60 < 2)
          {
            time = '${((differenceTimeAsked.inMinutes) - 60).round().toString()} min ago';
          }
          else
          {
            time = '${((differenceTimeAsked.inMinutes) - 60).round().toString()} mins ago';
          }
        }
        else
        {
          time = 'Just Now';
        }

        print (time);

        PhotoSpeakk listPhoto = PhotoSpeakk(
            createdDate: ss.createdDate,
            createdDateTime: time,
            id: ss.id,
            mediaFileId: ss.mediaFileId,
            text: ss.text,
            userinfoid: ss.userinfoid,
            usersInfo: ss.usersInfo
        );

        photo.add(listPhoto);

//        print(timeFormat);
      }
    }
    catch(e)
    {
      print('Error: $e');
    }

    print(photo.length);
    print(photo);

    photo..sort((a, b) => b.id.compareTo(a.id));

//    question..sort((a, b) => b.countvote.compareTo(a.countvote));

//    question..sort((a, b) => a.datetimeasked.compareTo(b.datetimeasked));

//    List <QuestionVote> questionsReversed = question.reversed.toList();

    return photo;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.data = widget.data ?? Data();

    _authStatus = ((widget.data.surname == '')) ? AuthStatus.notSignedIn : (widget.data.speaker && widget.data.surname != '') ? AuthStatus.signedInSpeaker : AuthStatus.signedIn;

    controller = new ScrollController()..addListener(_scrollListener);

    refreshList();
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show();
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _getPhotoSpeak();
    });

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(152, 160, 87, 1),
        title: new Text("Photo Speak"),
        leading: Builder(
          builder: (context) => IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
//              Navigator.push(context,
//                  MaterialPageRoute(builder: (context) => HomePage())
//              );
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
      floatingActionButton: FloatingActionButton(
        child: new Icon(Icons.add_photo_alternate),
        backgroundColor: Color.fromRGBO(152, 160, 87, 1),
        onPressed: () {
//          _authStatus = AuthStatus.notSignedIn;
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SharePic(data: widget.data,))
          );
        },
      ),
      body: new RefreshIndicator(
        onRefresh: refreshList,
        child: new SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              new Container(
                margin: new EdgeInsets.only(top: 20.0, bottom: 20.0, left: 15.0, right: 15.0),
                child: new FutureBuilder(
                    future: _getPhotoSpeak(),
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
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: snapshot.data.length,
                          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: MediaQuery.of(context).size.width /
                                (MediaQuery.of(context).size.height + 55),
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            print(url + snapshot.data[index].mediaFileId);
                            return new Card(
                              child: new Container(
                                  margin: new EdgeInsets.only(right: 0.0),
                                  child: new Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Container (
                                        padding: new EdgeInsets.only(top: 13.0, bottom: 20.0, left: 20.0),
                                        child: new Row(
                                          children: <Widget>[
                                            new Container(
                                              padding: new EdgeInsets.only(right: 10.0),
                                              child: snapshot.data[index].usersInfo.picId == null
                                                  ? new CircleAvatar(
                                                child: new Text('${snapshot.data[index].usersInfo.surname.substring(0, 1)}'
                                                    '${snapshot.data[index].usersInfo.firstname.substring(0, 1)}'
                                                ),
                                              )
                                                  : CircleAvatar(
                                                backgroundImage: NetworkImage(profileUrl + snapshot.data[index].usersInfo.picId),
                                                backgroundColor: Colors.transparent,
                                              ),
                                            ),
                                            new Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                new Container(
                                                  padding: new EdgeInsets.only(bottom: 5.0),
                                                  child: new Text('${snapshot.data[index].usersInfo.title} ${snapshot.data[index].usersInfo.surname} ${snapshot.data[index].usersInfo.firstname}',
                                                    style: new TextStyle(
                                                        fontSize: ScreenUtil(allowFontScaling: true).setSp(31),
                                                        fontWeight: FontWeight.bold
                                                    ),
                                                  ),
                                                ),
                                                new Container(
                                                  child: new Text(snapshot.data[index].createdDateTime,
                                                    style: new TextStyle(
                                                        fontSize: ScreenUtil(allowFontScaling: true).setSp(29),
                                                        color: Colors.grey
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      new Container(
                                        padding: new EdgeInsets.only(top: 0.0, bottom: 20.0, left: 20.0),
                                        child: new Text('${snapshot.data[index].text}',
                                          style: new TextStyle(
                                              fontSize: ScreenUtil(allowFontScaling: true).setSp(31),
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
//                                      new Container(
//                                        width: MediaQuery.of(context).size.width,
//                                        height: MediaQuery.of(context).size.height - 175,
//                                        decoration: new BoxDecoration(
//                                          image: new DecorationImage (
//                                            image: new NetworkImage(url + snapshot.data[index].mediaFileId),
//                                            fit: BoxFit.cover,
//                                          ),
//                                          //                          borderRadius: new BorderRadius.circular(70.0),
//                                        ),
//                                      ),
                                      new CachedNetworkImage(
                                        imageUrl: url + snapshot.data[index].mediaFileId,
                                        placeholder: (context, url) => new CircularProgressIndicator(),
                                        errorWidget: (context, url, error) => new Icon(Icons.error),
                                        width: MediaQuery.of(context).size.width,
                                        height: MediaQuery.of(context).size.height - 175,
                                        fit: BoxFit.cover,
                                      ),
                                      new Container(
                                        child: new Row(
                                          children: <Widget>[
                                            new Container(
                                              child: new IconButton(
                                                icon: new Icon(
                                                    FontAwesomeIcons.heart
                                                ),
                                              ),
                                            ),
                                            new Container(
                                              child: new IconButton(
                                                icon: new Icon(
                                                    Icons.comment
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                            );
                          }
                      );
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _scrollListener() {
    print(controller.position.extentAfter);
    if (controller.position.extentAfter < 11) {
      setState(() {
        _getPhotoSpeak();
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
