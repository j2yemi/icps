import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icps/Constants.dart';
import 'package:icps/UsersInfo.dart';
import 'package:icps/app_screens/Register.dart';
import 'package:icps/app_screens/drawer/Login.dart';

import 'package:icps/app_screens/popupMenu/Dashboard.dart';
//import 'package:icps/app_screens/popupMenu/EditProfile.dart';
import 'package:icps/app_screens/popupMenu/Settings.dart';

import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
//import 'package:path/path.dart';
//import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:cached_network_image/cached_network_image.dart';
import 'package:icps/app_screens/popupMenu/editProfile/UpdateProfile.dart';

class EditProfile extends StatefulWidget {

  Data data; String password;

  EditProfile({this.data, this.password,});

  @override
  _EditProfileState createState() => _EditProfileState();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
  signedInSpeaker
}

class _EditProfileState extends State<EditProfile> {

  AuthStatus _authStatus = AuthStatus.notSignedIn;

  String url = 'http://icps19.com:6060/icps/resources/conferencepresentations/profilepics/';

  var user = Data();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.data = widget.data ?? Data();

    _authStatus = ((widget.data.surname == '')) ? AuthStatus.notSignedIn : (widget.data.speaker && widget.data.surname != '') ? AuthStatus.signedInSpeaker : AuthStatus.signedIn;

    _getProfile();

  }

  @override
  Widget build(BuildContext context) {
//    _getProfile();
    print('this:' + widget.data.surname);
    print('this this: ${widget.password}');
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334, allowFontScaling: true)..init(context);
    print('$url${user.picId}');
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(152, 160, 87, 1),
        title: new Text("Edit Profile"),
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
            new Center(
              child: new Column(
                children: <Widget>[
                  new Container(
                    padding: new EdgeInsets.only(bottom: 50.0, top: 50.0),
                    color: Color.fromRGBO(180, 188, 151, 1),
                    child: new Center(
//                      child: new Container(
//                        margin: new EdgeInsets.only(top: 50.0),
//                        width: 110.0,
//                        height: 110.0,
//                        decoration: new BoxDecoration(
//                          image: new DecorationImage (
//                            image: new AssetImage (
//                                'assets/images/logo/icpslogo3.png'
//                            ),
//                            fit: BoxFit.cover,
//                          ),
//                          borderRadius: new BorderRadius.circular(70.0),
//                        ),
//                      ),
                      child: new Stack(
                        children: <Widget>[
                          user.picId == null
                              ? new CircleAvatar(
                            radius: 50.0,
                            child: new Text('${user.surname.substring(0, 1)}'
                                '${user.firstname.substring(0, 1)}',
                              style: new TextStyle(
                                fontSize: 43.0
                              ),
                            ),
                          )
                              : CircleAvatar(
                            radius: 50.0,
                            backgroundImage: NetworkImage(url + user.picId),
                            backgroundColor: Colors.transparent,
                          ),
                          new Positioned(
                            bottom: 0.0,
                            right: 0.0,
                            child: new CircleAvatar(
                              backgroundColor: Color.fromRGBO(152, 160, 87, 1),
                              child: new IconButton(
                                icon: new Icon(
                                    Icons.add_photo_alternate,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => UpdatePic(data: widget.data, password: widget.password,))
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      )
                    ),
                  ),
                  new Container(
                    margin: new EdgeInsets.all(30.0),
                    child: new Column(
                      children: <Widget>[
                        new Container(
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Container(
                                  child: new Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Container(
                                        padding: new EdgeInsets.only(right: 30.0),
                                        child: new Icon(
                                            Icons.person
                                        ),
                                      ),
                                      new Container (
                                          width: ScreenUtil.getInstance().setWidth(445),
                                          child: new Text('${user.title} ${user.surname} '
                                          '${user.firstname}',
                                            style: new TextStyle(
                                              fontSize: ScreenUtil(allowFontScaling: true)
                                                  .setSp(31),
                                            ),
                                          )
                                      ),
                                    ],
                                  )
                              ),
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => UpdateName(user: user, password: widget.password, data: widget.data,))
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                        new Container(
                          padding: new EdgeInsets.only(top: 15.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Container(
                                  child: new Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Container(
                                        padding: new EdgeInsets.only(right: 30.0),
                                        child: new Icon(
                                            Icons.card_membership
                                        ),
                                      ),
                                      new Container (
                                          width: ScreenUtil.getInstance().setWidth(445),
                                          child: new Text('${user.conferenceId}',
                                            style: new TextStyle(
                                              fontSize: ScreenUtil(allowFontScaling: true)
                                                  .setSp(31),
                                            ),
                                          )
                                      ),
                                    ],
                                  )
                              ),
//                              IconButton(
//                                icon: Icon(Icons.edit),
//                                onPressed: () {
//                                  Navigator.push(context,
//                                      MaterialPageRoute(builder: (context) => UpdateName(user: user, password: widget.password, data: widget.data,))
//                                  );
//                                },
//                              )
                            ],
                          ),
                        ),
                        new Container(
                          padding: new EdgeInsets.only(top: 15.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Container(
                                  child: new Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Container(
                                        padding: new EdgeInsets.only(right: 30.0),
                                        child: new Icon(
                                            Icons.person
                                        ),
                                      ),
                                      new Container (
                                          child: new Text('${user.username}',
                                            style: new TextStyle(
                                              fontSize: ScreenUtil(allowFontScaling: true)
                                                  .setSp(31),
                                            ),
                                          )
                                      ),
                                    ],
                                  )
                              ),
//                              IconButton(
//                                icon: Icon(Icons.edit),
//                                onPressed: () {
//                                  Navigator.push(context,
//                                      MaterialPageRoute(builder: (context) => UpdateUsername(user: user, password: widget.password, data: widget.data,))
//                                  );
//                                },
//                              )
                            ],
                          ),
                        ),
                        new Container(
                          padding: new EdgeInsets.only(top: 15.0, bottom: 10.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Container(
                                  child: new Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Container(
                                        padding: new EdgeInsets.only(right: 30.0),
                                        child: new Icon(
                                            Icons.email
                                        ),
                                      ),
                                      new Container (
                                          child: new Text('${user.email}',
                                            style: new TextStyle(
                                              fontSize: ScreenUtil(allowFontScaling: true)
                                                  .setSp(31),
                                            ),
                                          )
                                      ),
                                    ],
                                  )
                              ),
//                              IconButton(
//                                icon: Icon(Icons.edit),
//                                onPressed: () {},
//                              )
                            ],
                          ),
                        ),
                        new Container(
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Container(
                                  child: new Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Container(
                                        padding: new EdgeInsets.only(right: 30.0),
                                        child: new Icon(
                                            Icons.phone
                                        ),
                                      ),
                                      new Container (
                                          child: new Text('${user.phone}',
                                            style: new TextStyle(
                                              fontSize: ScreenUtil(allowFontScaling: true)
                                                  .setSp(31),
                                            ),
                                          )
                                      ),
                                    ],
                                  )
                              ),
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => UpdatePhone(user: user, password: widget.password, data: widget.data,))
                                  );
                                },
                              )
                            ],
                          ),
                        ),
//                        new Container(
//                          child: new Row(
//                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                            children: <Widget>[
//                              new Container(
//                                  child: new Row(
//                                    children: <Widget>[
//                                      new Container(
//                                        padding: new EdgeInsets.only(right: 30.0),
//                                        child: new Icon(
//                                            Icons.lock
//                                        ),
//                                      ),
//                                      new Container (
//                                          child: new Text('Hidden',
//                                            style: new TextStyle(
//                                              fontSize: ScreenUtil(allowFontScaling: true)
//                                                  .setSp(31),
//                                              color: Colors.redAccent
//                                            ),
//                                          )
//                                      ),
//                                    ],
//                                  )
//                              ),
//                              IconButton(
//                                icon: Icon(Icons.edit),
//                                onPressed: () {},
//                              )
//                            ],
//                          ),
//                        ),
                        new Container(
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Container(
                                  child: new Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Container(
                                        padding: new EdgeInsets.only(right: 30.0),
                                        child: new Icon(
                                            Icons.domain
                                        ),
                                      ),
                                      new Container (
                                          width: ScreenUtil.getInstance().setWidth(445),
                                          child: new Text('${user.organisation}',
                                            style: new TextStyle(
                                              fontSize: ScreenUtil(allowFontScaling: true)
                                                  .setSp(31),
                                            ),
                                          )
                                      ),
                                    ],
                                  )
                              ),
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => UpdateOrganisation(user: user, password: widget.password, data: widget.data,))
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                        new Container(
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Container(
                                  child: new Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Container(
                                        padding: new EdgeInsets.only(right: 30.0),
                                        child: new Icon(
                                            Icons.business_center
                                        ),
                                      ),
                                      new Container (
                                          width: ScreenUtil.getInstance().setWidth(445),
                                          child: new Text('${user.workPosition}',
                                            style: new TextStyle(
                                              fontSize: ScreenUtil(allowFontScaling: true)
                                                  .setSp(31),
                                            ),
                                          )
                                      ),
                                    ],
                                  )
                              ),
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => UpdateWorkPosition(user: user, password: widget.password, data: widget.data,))
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                        new Container(
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Container(
                                  child: new Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Container(
                                        padding: new EdgeInsets.only(right: 30.0),
                                        child: new Icon(
                                            Icons.domain
                                        ),
                                      ),
                                      new Container (
                                          width: ScreenUtil.getInstance().setWidth(445),
                                          child: new Text('${user.companysector}',
                                            style: new TextStyle(
                                              fontSize: ScreenUtil(allowFontScaling: true)
                                                  .setSp(31),
                                            ),
                                          )
                                      ),
                                    ],
                                  )
                              ),
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => UpdateCompanySector(user: user, password: widget.password, data: widget.data,))
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                        new Container(
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Container(
                                  child: new Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Container(
                                        padding: new EdgeInsets.only(right: 30.0),
                                        child: new Icon(
                                            Icons.public
                                        ),
                                      ),
                                      new Container (
                                          width: ScreenUtil.getInstance().setWidth(445),
                                          child: new Text('${user.country}',
                                            style: new TextStyle(
                                              fontSize: ScreenUtil(allowFontScaling: true)
                                                  .setSp(31),
                                            ),
                                          )
                                      ),
                                    ],
                                  )
                              ),
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => UpdateCountry(user: user, password: widget.password, data: widget.data,))
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                        new Container(
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Container(
                                  child: new Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Container(
                                        padding: new EdgeInsets.only(right: 30.0),
                                        child: new Icon(
                                            FontAwesomeIcons.facebook
                                        ),
                                      ),
                                      new Container (
                                          width: ScreenUtil.getInstance().setWidth(445),
                                          child: new Text('${user.facebookId}',
                                            style: new TextStyle(
                                              fontSize: ScreenUtil(allowFontScaling: true)
                                                  .setSp(31),
                                            ),
                                          )
                                      ),
                                    ],
                                  )
                              ),
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => UpdateFacebook(user: user, password: widget.password, data: widget.data,))
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                        new Container(
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Container(
                                  child: new Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Container(
                                        padding: new EdgeInsets.only(right: 30.0),
                                        child: new Icon(
                                            FontAwesomeIcons.twitter
                                        ),
                                      ),
                                      new Container (
                                          width: ScreenUtil.getInstance().setWidth(445),
                                          child: new Text('${user.twitterId}',
                                            style: new TextStyle(
                                              fontSize: ScreenUtil(allowFontScaling: true)
                                                  .setSp(31),
                                            ),
                                          )
                                      ),
                                    ],
                                  )
                              ),
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => UpdateTwitter(user: user, password: widget.password, data: widget.data,))
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                        new Container(
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Container(
                                  child: new Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Container(
                                        padding: new EdgeInsets.only(right: 30.0),
                                        child: new Icon(
                                            Icons.web
                                        ),
                                      ),
                                      new Container (
                                          child: new Text('${user.website}',
                                            style: new TextStyle(
                                              fontSize: ScreenUtil(allowFontScaling: true)
                                                  .setSp(31),
                                            ),
                                          )
                                      ),
                                    ],
                                  )
                              ),
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => UpdateWebsite(user: user, password: widget.password, data: widget.data,))
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                        new Container(
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Container(
                                  child: new Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Container(
                                        padding: new EdgeInsets.only(right: 30.0),
                                        child: new Icon(
                                            Icons.description
                                        ),
                                      ),
                                      new Container (
                                          width: ScreenUtil.getInstance().setWidth(445),
                                          child: new Text('${user.shortProfile}',
                                            style: new TextStyle(
                                              fontSize: ScreenUtil(allowFontScaling: true)
                                                  .setSp(31),
                                            ),
                                          )
                                      ),
                                    ],
                                  )
                              ),
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => UpdateShortProfile(user: user, password: widget.password, data: widget.data,))
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ],
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

  void _getProfile() async {

    String findUrl ='http://icps19.com:6060/icps/i/icps/19/urp';

    try {
      Response response;
      Dio dio = new Dio();

      response = await dio.get(findUrl,
          queryParameters: {"username": widget.data.username, "password": widget.password});
      print(response.statusCode);

      if (response.statusCode == 200) {
        print(UsersInfo
            .fromJson(response.data)
            .surname);
        print(UsersInfo
            .fromJson(response.data)
            .speakerYn);
        print(UsersInfo
            .fromJson(response.data)
            .workPosition);

//            userSurname = UsersInfo.fromJson(response.data).surname;
//
//            userFirstname = UsersInfo.fromJson(response.data).firstname;
//
//            var data = Data (
//              surname: userSurname,
//              firstname: userFirstname
//            );

        setState(() {
          user = Data.fromUsersInfo(UsersInfo.fromJson(response.data));
        });

      }
    }
    catch(e) {
      print('Error: $e');
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
//        Navigator.push(context,
//            MaterialPageRoute(builder: (context) => EditProfile())
//        );
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

