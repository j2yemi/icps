import 'dart:math';

import 'package:flutter/material.dart';
import 'package:icps/CocktailJson.dart';
import 'package:icps/Constants.dart';
import 'package:icps/app_screens/Register.dart';
import 'package:icps/app_screens/drawer/Login.dart';

import 'package:icps/app_screens/popupMenu/Dashboard.dart';
import 'package:icps/app_screens/popupMenu/EditProfile.dart';
import 'package:icps/app_screens/popupMenu/Settings.dart';

import 'dart:async';
import 'dart:convert';
import 'package:icps/UsersInfo.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:icps/app_screens/activity_feed/NewFeed.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class Cocktail extends StatefulWidget {

  Data data; String password;

  Cocktail({this.data, this.password});

  @override
  _CocktailState createState() => _CocktailState();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
  signedInSpeaker
}

class _CocktailState extends State<Cocktail> {

  AuthStatus _authStatus = AuthStatus.notSignedIn;

  ScrollController controller;

  var confirmationCode = '';

  String url = 'http://icps19.com:6060/icps/resources/conferencepresentations/profilepics/';
  List data = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getCocktail();

    widget.data = widget.data ?? Data();

    _authStatus = ((widget.data.surname == '')) ? AuthStatus.notSignedIn : (widget.data.speaker && widget.data.surname != '') ? AuthStatus.signedInSpeaker : AuthStatus.signedIn;

    controller = new ScrollController()..addListener(_scrollListener);

  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  Future <List<GalaNight>> _getCocktail() async {

    String getUrl = 'http://icps19.com:6060/icps/icps/19/gal';

    var cocktailData = await http
        .get(Uri.encodeFull(getUrl), headers: {"Accept": "application/json"});

    var jsonData = cocktailData.body;
    print(jsonData);

    var resBody = json.decode(jsonData);

    setState(() {
      data = resBody;
    });

    print(resBody);

    List <GalaNight> galanightList = galaNightFromJson(jsonData);

    List <GalaNight> galaNight = [];

    try
    {
      for (GalaNight ss in galanightList)
      {
        ss.datetimejoined = '${ss.datetimejoined.substring(0, 10)} ${ss.datetimejoined.substring(11, 19)}';

        print(ss.datetimejoined);

        DateTime dated = DateTime.parse(ss.datetimejoined);

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

        if (widget.data.id == ss.userinfoid)
        {
          GalaNight joinGalaNight = GalaNight (
              attendingYn: ss.attendingYn,
              datetimejoined: time,
              gnCode: ss.gnCode,
              id: ss.id,
              userinfoid: ss.userinfoid,
              usersInfo: ss.usersInfo
          );

          galaNight.add(joinGalaNight);
        }

//        print(timeFormat);
      }
    }
    catch(e)
    {
      print('Error: $e');
    }

    print('Cocktail Length: ${galaNight.length}');

    print ('this this: ${data.map((f) => f['usersInfo'])}');

//    attendee..sort((a, b) => a.id.compareTo(b.id));

    return galaNight;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: new AppBar (
        backgroundColor: Color.fromRGBO (152, 160, 87, 1),
        title: new Text ("Cocktail"),
        actions: <Widget> [
//          IconButton (icon: Icon (
//              Icons.search
//          ),
//            onPressed: () {
//              Navigator.pop (context);
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
        child: Column(
          children: <Widget>[
           _buildGalaNight()
          ],
        ),
      ),
    );
  }

  void _scrollListener() {
    print(controller.position.extentAfter);
    if (controller.position.extentAfter < 500) {
      setState(() {
        _getCocktail();
      });
    }
  }

  bool searchById() {
    var isId = data.where((id) => id['usersInfo'] == null ? (){var ff = Data(); return ff.userinfoid == widget.data.id;}() : id["usersInfo"]["userinfoid"] == widget.data.id);
    print(isId.length);

    if (isId.length > 0) {
      return true;
    }
    else {
      return false;
    }
  }

  Widget _buildGalaNight() {
    if (searchById()) {
//      print(widget.data.phone);
      return new Container(
          margin: new EdgeInsets.only(
              top: 20.0, left: 10.0, right: 10.0, bottom: 20.0),
          child: new FutureBuilder(
              future: _getCocktail(),
              builder: (BuildContext context,
                  AsyncSnapshot snapshot) {
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
                        child: new Text('No one has joined cocktail list yet',
                          style: new TextStyle(
                            fontSize: ScreenUtil(
                                allowFontScaling: true)
                                .setSp(31),
                          ),
                        ),
                      )
                  );
                }
                else {
                  return ListView.builder(
                      controller: controller,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context,
                          int index) {
                        return new Card(
                          child: new GestureDetector(
                            onTap: () {
                              Navigator.push (context,
                                  MaterialPageRoute(builder: (context) => AttendeeProfile(joinCocktail: snapshot.data[index], data: widget.data))
                              );
                            },
                            child: new Container(
                                padding: new EdgeInsets.all(10.0),
                                child: new Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      new Container(
                                        child: new Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            new Container(
                                              padding: new EdgeInsets.only(right: 20.0),
                                              child: snapshot.data[index].usersInfo.picId == null
                                                  ? new CircleAvatar(
                                                child: new Text('${snapshot.data[index].usersInfo.surname.substring(0, 1)}'
                                                    '${snapshot.data[index].usersInfo.firstname.substring(0, 1)}'
                                                ),
                                              )
                                                  : CircleAvatar(
                                                backgroundImage: NetworkImage(url + snapshot.data[index].usersInfo.picId),
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
                                                  padding: new EdgeInsets.only(bottom: 5.0),
                                                  child: new Row(
                                                    children: <Widget>[
                                                      new Container(
                                                        child: new Text('Cocktail Code: ',
                                                          style: new TextStyle(
                                                            fontWeight: FontWeight.bold
                                                          ),
                                                        ),
                                                      ),
                                                      new Container(
                                                        child: new Text('${snapshot.data[index].gnCode}',
                                                          style: new TextStyle(
                                                              fontSize: 20.0,
                                                              fontWeight: FontWeight.bold
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                new Container(
                                                  padding: new EdgeInsets.only(bottom: 5.0),
                                                  child: new Row(
                                                    children: <Widget>[
                                                      new Container(
                                                        child: new Text('Dress code: ',
                                                          style: new TextStyle(
                                                              fontWeight: FontWeight.bold
                                                          ),
                                                        ),
                                                      ),
                                                      new Container(
                                                        child: new Text('Evening Gown/Tuxedo',
                                                          style: new TextStyle(
                                                              fontSize: 20.0,
                                                              fontWeight: FontWeight.bold
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                new Container(
                                                  padding: new EdgeInsets.only(bottom: 5.0),
                                                  child: new Row(
                                                    children: <Widget>[
                                                      new Container(
                                                        child: new Text('Location: ',
                                                          style: new TextStyle(
                                                              fontWeight: FontWeight.bold
                                                          ),
                                                        ),
                                                      ),
                                                      new Container(
                                                        child: new Text('Congress Hall',
                                                          style: new TextStyle(
                                                              fontSize: 20.0,
                                                              fontWeight: FontWeight.bold
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                new Container(
                                                  child: new Text('Joined ${snapshot.data[index].datetimejoined}',
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
                                    ]
                                )
                            ),
                          ),
                        );
                      }
                  );
                }
              }
          )
      );
    }
    else {
      return  new Container(
          padding: new EdgeInsets.only(top: 13.0),
          child: new Center(
            child: Column(
              children: <Widget>[
                new Container(
                  child: new Icon(
                      Icons.access_time,
                      size: 73.0,
                      color: Colors.grey
                  ),
                ),
                new Container(
                  child: new Text('Register for Cocktail',
                    style: new TextStyle(
                        color: Colors.grey,
                        fontSize: 20.0
                    ),
                  ),
                ),
                new Container(
                  padding: new EdgeInsets.only(top: 13.0, left: 64.0, right: 64.0),
                  child: new Text('Log in to join cocktail and interact with others at the event.',
                    style: new TextStyle(
                        color: Colors.grey,
                        fontSize: 18.0
                    ),
                  ),
                ),
                new Container(
                  margin: new EdgeInsets.only(top: 23.0),
                  color: Color.fromRGBO(152, 160, 87, 1),
                  child: new FlatButton(
                      onPressed: () {
                        if (_authStatus == AuthStatus.notSignedIn) {
                          _showDialogTwo(context);
                        }
                        else {
                          _joinGalanight();
                        }
                      },
                      child: new Text('JOIN COCKTAIL',
                        style: new TextStyle(
                            color: Colors.white
                        ),
                      )
                  ),
                )
              ],
            ),
          )
      );
    }
  }

  void _generateConfirmationCode() {

    String phoneCharacter = widget.data.phone.trim().substring(widget.data.phone.length - 2, widget.data.phone.length - 1);

    var rng = new Random();

    String rnd = '';

    for (var i = 0; i < 3; i++) {

      print(rng.nextInt(9));

      rnd = rng.nextInt(9).toString() + rng.nextInt(9).toString();
    }

    setState(() {
      confirmationCode = rnd + phoneCharacter;
    });
  }

  void _joinGalanight () async {
    final String url = 'http://icps19.com:6060/icps/icps/19/gad';

    try {
      Response response;
      Dio dio = new Dio();

      _generateConfirmationCode();

      print ('code:' + confirmationCode);

      response = await dio.post(url, queryParameters: {"userinfoid": widget.data.id,"attending_yn": 'Y',"gn_code": confirmationCode},
          options: Options(
            headers: {HttpHeaders.contentTypeHeader: 'application/json',"accept": "application/json"},)
      );



      print('Got response here as $response\n response status code ${response.statusCode}');

      if(response.statusCode == 200){

//      print(_to);
//      print(_message);
        print(widget.data.id);

        _getCocktail();

        Fluttertoast.showToast(
            msg: "Joined Cocktail List Successfully",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 6,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
      else {
        Fluttertoast.showToast(
            msg: "Oops, something went wrong, try again.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    }
    catch(e)
    {
      print('Error: $e');
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
        _showDialogTwo(context);
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

  void _showDialogTwo (BuildContext context)
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


class AttendeeProfile extends StatefulWidget {

  final GalaNight joinCocktail; Data data;

  AttendeeProfile({this.joinCocktail, this.data});

  @override
  _AttendeeProfileState createState() => _AttendeeProfileState();
}

class _AttendeeProfileState extends State<AttendeeProfile> {

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
        title: new Text("Attendees"),
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
                    child: widget.joinCocktail.usersInfo.picId == null
                        ? new CircleAvatar(
                      radius: 50.0,
                      child: new Text('${widget.joinCocktail.usersInfo.surname.substring(0, 1)}'
                          '${widget.joinCocktail.usersInfo.firstname.substring(0, 1)}',
                        style: new TextStyle(
                            fontSize: 43.0
                        ),
                      ),
                    )
                        : CircleAvatar(
                      radius: 50.0,
                      backgroundImage: NetworkImage(url + widget.joinCocktail.usersInfo.picId),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
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
                                  Icons.person
                              )
                          ),
                          new Container(
                            child: new Text('${widget.joinCocktail.usersInfo.title} ${widget.joinCocktail.usersInfo.surname} ${widget.joinCocktail.usersInfo.firstname}',
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
                                  Icons.business_center
                              )
                          ),
                          new Container(
                            width: ScreenUtil.getInstance().setWidth(550),
                            child: new Text('${widget.joinCocktail.usersInfo.workPosition}, ${widget.joinCocktail.usersInfo.organisation}',
                              style: new TextStyle(
                                  fontSize: ScreenUtil(allowFontScaling: true).setSp(36)
                              ),
                            ),
                          )
                        ],
                      )
                  )
              ),
              widget.joinCocktail.usersInfo.facebookId == null ?
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
                                  FontAwesomeIcons.facebook
                              )
                          ),
                          new Container(
                            width: ScreenUtil.getInstance().setWidth(550),
                            child: new Text('${widget.joinCocktail.usersInfo.facebookId}',
                              style: new TextStyle(
                                  fontSize: ScreenUtil(allowFontScaling: true).setSp(31)
                              ),
                            ),
                          )
                        ],
                      )
                  )
              ),
              widget.joinCocktail.usersInfo.twitterId == null ?
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
                                  FontAwesomeIcons.twitter
                              )
                          ),
                          new Container(
                            width: ScreenUtil.getInstance().setWidth(550),
                            child: new Text('${widget.joinCocktail.usersInfo.twitterId}',
                              style: new TextStyle(
                                  fontSize: ScreenUtil(allowFontScaling: true).setSp(31)
                              ),
                            ),
                          )
                        ],
                      )
                  )
              ),
              widget.joinCocktail.usersInfo.shortProfile == null ?
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
                                  Icons.person_pin
                              )
                          ),
                          new Container(
                            width: ScreenUtil.getInstance().setWidth(550),
                            child: new Text('${widget.joinCocktail.usersInfo.shortProfile}',
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
          MaterialPageRoute(builder: (context) => Dashboard())
      );
    }
    else if (choice == Constants.EditProfile){
      if (_authStatus == AuthStatus.notSignedIn)
      {
        _showDialogTwo(context);
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

  void _showDialogTwo (BuildContext context)
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