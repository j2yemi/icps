//import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:icps/Constants.dart';
import 'package:icps/app_screens/Centrifuge.dart';
import 'package:icps/app_screens/NewExhibitions.dart';
import 'package:icps/app_screens/NewMessages.dart';
import 'package:icps/app_screens/NewPartners.dart';
import 'package:icps/app_screens/gallery/PhotoSpeak.dart';
import 'package:icps/app_screens/popupMenu/Dashboard.dart';
import 'package:icps/app_screens/popupMenu/EditProfile.dart';
import 'package:icps/app_screens/popupMenu/Settings.dart';

import 'package:icps/UsersInfo.dart';

import 'package:icps/app_screens/Register.dart';
import 'package:icps/app_screens/drawer/Login.dart';
//import 'package:icps/app_screens/drawer/MySchedule.dart';
//import 'package:icps/app_screens/drawer/MyMessages.dart';
//import 'package:icps/app_screens/drawer/MyContacts.dart';
//import 'package:icps/app_screens/drawer/MyNotes.dart';
import 'package:icps/app_screens/drawer/UploadPresentation.dart';
import 'package:icps/app_screens/Agenda.dart';
import 'package:icps/app_screens/Locations.dart';
//import 'package:icps/app_screens/Speakers.dart';
//import 'package:icps/app_screens/Exhibitions.dart';
import 'package:icps/app_screens/ActivityFeed.dart';
import 'package:icps/app_screens/Attendees.dart';
import 'package:icps/app_screens/Conference.dart';
//import 'package:icps/app_screens/ConferenceSurvey.dart';
//import 'package:icps/app_screens/Partners.dart';
//import 'package:icps/app_screens/Gallery.dart';
import 'package:icps/app_screens/Faq.dart';
import 'package:icps/app_screens/ExtraActivities.dart';
import 'package:icps/app_screens/conference/ConferencePaper.dart';
//import 'package:icps/app_screens/Register.dart';
//import 'package:icps/app_screens/agenda/NewAgendaOne.dart';

//import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fab_menu/fab_menu.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icps/app_screens/speakers/NewSpeakers.dart';
import 'package:dio/dio.dart';
//import 'package:text_view/text_view.dart';
//import 'package:page_indicator/page_indicator.dart';
//import './menu/MenuOne.dart';
//import './menu/MenuTwo.dart';

void main() {
  runApp(
    MaterialApp (
      home: HomePage(),
      theme: ThemeData(
        fontFamily: 'Montserrat',
      )
    )
  );
}

class HomePage extends StatefulWidget {

  Data data; String password; DataTwo data2;
//  DataTwo data2;

//  final VoidCallback onSignedIn;

  HomePage ({this.data, this.password, this.data2});


  @override
  _HomePageState createState() => _HomePageState ();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
  signedInSpeaker
}

class _HomePageState extends State<HomePage> {

  AuthStatus _authStatus = AuthStatus.notSignedIn;

  List<MenuData> menuDataList;

  String url = 'http://icps19.com:6060/icps/resources/conferencepresentations/profilepics/';

  var user = Data();

  @override
  initState() {
    super.initState();

    menuDataList = [
      new MenuData(FontAwesomeIcons.signInAlt, (context, menuData) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Login())
        );
      },labelText: 'Login'),
      new MenuData(FontAwesomeIcons.signOutAlt, (context, menuData) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Register())
        );
      },labelText: 'Register')
    ];

    widget.data = widget.data == null && widget.data2 != null ? widget.data2 : widget.data == null && widget.data2 == null ? Data() : widget.data;
   _authStatus = ((widget.data.surname == '')) ? AuthStatus.notSignedIn : (widget.data.speaker && widget.data.surname != '') ? AuthStatus.signedInSpeaker : AuthStatus.signedIn;

   _getProfile();
  }

  Drawer _buildDrawer (context) {
//    _getProfile();
    switch (_authStatus) {
      case AuthStatus.notSignedIn:
        return new Drawer(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Expanded(
                child: new ListView(
                  children: <Widget>[
                    new Container(
                      width: MediaQuery.of(context).size.width,
                      child: new DrawerHeader(
                          decoration: new BoxDecoration(
                              color: Color.fromRGBO(0, 0, 0, 0.8)
                          ),
                          child: new Container (
                            child: new Column(
                              children: <Widget>[
                                new Container(
                                  width: 90.0,
                                  height: 90.0,
                                  decoration: new BoxDecoration(
                                    image: new DecorationImage(
                                        image: new AssetImage(
                                            'assets/images/logo/icpslogo3.png'
                                        )
                                    ),
//                              borderRadius: new BorderRadius.circular(70.0)
                                  ),
                                ),
                                new Container(
                                  padding: new EdgeInsets.only(top: 10.0),
                                  child: new Text('Conference Participant',
                                    style: new TextStyle(
                                        color: Colors.white
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                      ),
                    ),
                    new Container(
//                height: MediaQuery.of(context).size.height,
                      child: new Column(
                        children: <Widget> [
                          new ListTile(
                            leading: Builder(
                                builder: (context) => Icon(Icons.person)
                            ),
                            title: new Text('Log in for more features!'),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(context,
                                  new MaterialPageRoute(
                                      builder: (context) => new Login()
                                  )
                              );
                            },
                          ),
                          new ListTile(
                            leading: Builder(
                                builder: (context) => Icon(Icons.add_photo_alternate)
                            ),
                            title: new Text('Photo Speak'),
                            onTap: () {
//                            Navigator.pop(context);
//                            Navigator.push(context,
//                                new MaterialPageRoute(
//                                    builder: (context) => new MySchedule()
//                                )
//                            );
                              _showDialog(context);
                            },
                          ),
                          new ListTile(
                            leading: Builder(
                                builder: (context) => Icon(Icons.people)
                            ),
                            title: new Text('Attendees'),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(context,
                                  new MaterialPageRoute(
                                      builder: (context) => new Attendees(data: widget.data, password: widget.password)
                                  )
                              );
                            },
                          ),
//                        new ListTile(
//                          leading: Builder(
//                              builder: (context) => Icon(Icons.photo)
//                          ),
//                          title: new Text('Gallery'),
//                          onTap: () {
//                            Navigator.pop(context);
//                            Navigator.push(context,
//                                new MaterialPageRoute(
//                                    builder: (context) => new Gallery()
//                                )
//                            );
//                          },
//                        ),
                          new ListTile(
                            leading: Builder(
                                builder: (context) => Icon(Icons.sentiment_satisfied)
                            ),
                            title: new Text('Extra Activities'),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(context,
                                  new MaterialPageRoute(
                                      builder: (context) => new ExtraActivities(data: widget.data, password: widget.password)
                                  )
                              );
                            },
                          ),
                          new ListTile(
                            leading: Builder(
                                builder: (context) => Icon(Icons.slideshow)
                            ),
                            title: new Text('Papers/Publications'),
                            onTap: () {
//                              Navigator.pop(context);
//                              Navigator.push(context,
//                                  new MaterialPageRoute(
//                                      builder: (context) => new ConferencePaper()
//                                  )
//                              );
                              _showDialog(context);
                            },
                          ),
                        ]
                      )
                    )
                  ],
                ),
              ),
              new Container(
//                          height: MediaQuery.of(context).size.height - 280,
                child: new Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: new Column(
                    children: <Widget>[
                      Divider(),
//                      new Container(
//                        padding: new EdgeInsets.only(left: 45.0, top: 10.0, bottom: 17.0),
//                        child: new Row(
//                          children: <Widget>[
//                            new Container(
//                              child: new Text('Technology: ',
//                                style: new TextStyle(
//                                  fontWeight: FontWeight.bold,
//                                  color: Colors.grey
//                                ),
//                              ),
//                            ),
//                            new Container(
//                              child: new Text('Java, DevOps',
//                                style: new TextStyle(
//                                  color: Colors.grey,
//                                )
//                              ),
//                            ),
//                          ],
//                        ),
//                      ),
                      new Container(
                        padding: new EdgeInsets.only(left: 29.0),
                        child: new Align(
                            alignment: FractionalOffset.topLeft,
                            child: new FlatButton(
                              child: new Text('Technology: Java, DevOps',
                                  style: new TextStyle(
                                      color: Colors.grey
                                  )
                              ),
                              onPressed: () {
                                Navigator.push(context,
                                    new MaterialPageRoute(
                                        builder: (context) => new Centrifuge(data: widget.data, password: widget.password)
                                    )
                                );
                              },
                            )
                        ),
                      ),
                      new Container(
                        padding: new EdgeInsets.only(left: 29.0),
                        child: new Align(
                            alignment: FractionalOffset.topLeft,
                            child: new FlatButton(
                              child: new Text('Credits: Central Bank of Nigeria',
                                  style: new TextStyle(
                                      color: Colors.grey
                                  )
                              ),
                              onPressed: () {
                                Navigator.push(context,
                                    new MaterialPageRoute(
                                        builder: (context) => new Centrifuge(data: widget.data, password: widget.password)
                                    )
                                );
                              },
                            )
                        ),
                      ),
//                      new Container(
//                        padding: new EdgeInsets.only(left: 44.0, bottom: 0.0),
//                        child: new Row(
//                          children: <Widget>[
//                            new Container(
//                              child: new Text('Credits: ',
//                                style: new TextStyle(
//                                    fontWeight: FontWeight.bold,
//                                    color: Colors.grey
//                                ),
//                              ),
//                            ),
//                            new Container(
//                              child: new Text('Central Bank of Nigeria',
//                                style: new TextStyle(
//                                  color: Colors.grey
//                                )
//                              ),
//                            ),
//                          ],
//                        ),
//                      ),
                      new Container(
                        padding: new EdgeInsets.only(left: 29.0),
                        child: new Align(
                          alignment: FractionalOffset.topLeft,
                            child: new FlatButton(
                              child: new Text('Developer: Centrifuge Group',
                                  style: new TextStyle(
                                      color: Colors.grey
                                  )
                              ),
                              onPressed: () {
                                Navigator.push(context,
                                    new MaterialPageRoute(
                                        builder: (context) => new Centrifuge(data: widget.data, password: widget.password)
                                    )
                                );
                              },
                            )
                        ),
                      ),
                    ],
                  ),
                ),
              ),
//                        new ListTile(
//                          leading: Builder(
//                              builder: (context) => Icon(Icons.message)
//                          ),
//                          title: new Text('My Messages'),
//                          onTap: () {
//                            Navigator.pop(context);
//                            Navigator.push(context,
//                                new MaterialPageRoute(
//                                    builder: (context) => new MyMessages()
//                                )
//                            );
//                          },
//                        ),
//                        new ListTile(
//                          leading: Builder(
//                              builder: (context) => Icon(Icons.contacts)
//                          ),
//                          title: new Text('My Contacts'),
//                          onTap: () {
//                            Navigator.pop(context);
//                            Navigator.push(context,
//                                new MaterialPageRoute(
//                                    builder: (context) => new MyContacts()
//                                )
//                            );
//                          },
//                        ),
//                        new ListTile(
//                          leading: Builder(
//                              builder: (context) => Icon(Icons.book)
//                          ),
//                          title: new Text('My Notes'),
//                          onTap: () {
//                            Navigator.pop(context);
//                            Navigator.push(context,
//                                new MaterialPageRoute(
//                                    builder: (context) => new MyNotes()
//                                )
//                            );
//                          },
//                        ),
//                        new ListTile(
//                          leading: Builder(
//                              builder: (context) => Icon(Icons.exit_to_app)
//                          ),
//                          title: new Text('Log out'),
//                          onTap: () {
//                            Navigator.pop(context);
//                            Navigator.push(context,
//                                new MaterialPageRoute(
//                                    builder: (context) => new Login()
//                                )
//                            );
//                          },
//                        ),

          ],
        ),
      );
      case AuthStatus.signedIn:
        return new Drawer(
          child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Expanded(
                  child: new ListView(
                  children: <Widget>[
                    new Container(
                        width: MediaQuery.of(context).size.width,
                      child: new DrawerHeader(
                        decoration: new BoxDecoration(
                            color: Color.fromRGBO(0, 0, 0, 0.8)
                        ),
                        child: new GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => EditProfile(data: widget.data, password: widget.password))
                            );
                          },
                          child: new Container (
                            child: new Column(
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
                                new Container(
                                  padding: new EdgeInsets.only(top: 10.0),
                                  child: new Text(user.surname + ' ' + user.firstname,
                                    style: new TextStyle(
                                        color: Colors.white
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        )
                    ),
                  ),
                    new Container(
                        child: new Column(
                            children: <Widget> [
//                        new ListTile(
//                          leading: Builder(
//                              builder: (context) => Icon(Icons.person)
//                          ),
//                          title: new Text('Log in for more features!'),
//                          onTap: () {
//                            Navigator.pop(context);
//                            Navigator.push(context,
//                                new MaterialPageRoute(
//                                    builder: (context) => new Login()
//                                )
//                            );
//                          },
//                        ),
                              new ListTile(
                                leading: Builder(
                                    builder: (context) => Icon(Icons.add_photo_alternate)
                                ),
                                title: new Text('Photo Speak'),
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.push(context,
                                      new MaterialPageRoute(
                                          builder: (context) => new PhotoSpeak(data: widget.data, password: widget.password)
                                      )
                                  );
                                },
                              ),
                              new ListTile(
                                leading: Builder(
                                    builder: (context) => Icon(Icons.people)
                                ),
                                title: new Text('Attendees'),
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.push(context,
                                      new MaterialPageRoute(
                                          builder: (context) => new Attendees(data: widget.data, password: widget.password)
                                      )
                                  );
                                },
                              ),
//                        new ListTile(
//                          leading: Builder(
//                              builder: (context) => Icon(Icons.photo)
//                          ),
//                          title: new Text('Gallery'),
//                          onTap: () {
//                            Navigator.pop(context);
//                            Navigator.push(context,
//                                new MaterialPageRoute(
//                                    builder: (context) => new Gallery()
//                                )
//                            );
//                          },
//                        ),
                              new ListTile(
                                leading: Builder(
                                    builder: (context) => Icon(Icons.sentiment_satisfied)
                                ),
                                title: new Text('Extra Activities'),
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.push(context,
                                      new MaterialPageRoute(
                                          builder: (context) => new ExtraActivities(data: widget.data, password: widget.password)
                                      )
                                  );
                                },
                              ),
                              new ListTile(
                                leading: Builder(
                                    builder: (context) => Icon(Icons.slideshow)
                                ),
                                title: new Text('Papers/Publications'),
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.push(context,
                                      new MaterialPageRoute(
                                          builder: (context) => new ConferencePaper(data: widget.data, password: widget.password)
                                      )
                                  );
                                },
                              ),
//                        new ListTile(
//                          leading: Builder(
//                              builder: (context) => Icon(Icons.message)
//                          ),
//                          title: new Text('My Messages'),
//                          onTap: () {
//                            Navigator.pop(context);
//                            Navigator.push(context,
//                                new MaterialPageRoute(
//                                    builder: (context) => new MyMessages()
//                                )
//                            );
//                          },
//                        ),
//                        new ListTile(
//                          leading: Builder(
//                              builder: (context) => Icon(Icons.contacts)
//                          ),
//                          title: new Text('My Contacts'),
//                          onTap: () {
//                            Navigator.pop(context);
//                            Navigator.push(context,
//                                new MaterialPageRoute(
//                                    builder: (context) => new MyContacts()
//                                )
//                            );
//                          },
//                        ),
//                        new ListTile(
//                          leading: Builder(
//                              builder: (context) => Icon(Icons.book)
//                          ),
//                          title: new Text('My Notes'),
//                          onTap: () {
//                            Navigator.pop(context);
//                            Navigator.push(context,
//                                new MaterialPageRoute(
//                                    builder: (context) => new MyNotes()
//                                )
//                            );
//                          },
//                        ),
                              new ListTile(
                                leading: Builder(
                                    builder: (context) => Icon(Icons.exit_to_app)
                                ),
                                title: new Text('Log out'),
                                onTap: () {
                                  setState(() {
                                    _authStatus = AuthStatus.notSignedIn;
                                  });
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => HomePage())
                                  );
                                },
                              ),
                            ]
                        )
                    )
                ]
              )
            ),
            new Container(
              child: new Align(
                alignment: FractionalOffset.bottomCenter,
                child: new Column(
                  children: <Widget>[
                    Divider(),
//                      new Container(
//                        padding: new EdgeInsets.only(left: 45.0, top: 10.0, bottom: 17.0),
//                        child: new Row(
//                          children: <Widget>[
//                            new Container(
//                              child: new Text('Technology: ',
//                                style: new TextStyle(
//                                  fontWeight: FontWeight.bold,
//                                  color: Colors.grey
//                                ),
//                              ),
//                            ),
//                            new Container(
//                              child: new Text('Java, DevOps',
//                                style: new TextStyle(
//                                  color: Colors.grey,
//                                )
//                              ),
//                            ),
//                          ],
//                        ),
//                      ),
                    new Container(
                      padding: new EdgeInsets.only(left: 29.0),
                      child: new Align(
                          alignment: FractionalOffset.topLeft,
                          child: new FlatButton(
                            child: new Text('Technology: Java, DevOps',
                                style: new TextStyle(
                                    color: Colors.grey
                                )
                            ),
                            onPressed: () {
                              Navigator.push(context,
                                  new MaterialPageRoute(
                                      builder: (context) => new Centrifuge(data: widget.data, password: widget.password)
                                  )
                              );
                            },
                          )
                      ),
                    ),
                    new Container(
                      padding: new EdgeInsets.only(left: 29.0),
                      child: new Align(
                          alignment: FractionalOffset.topLeft,
                          child: new FlatButton(
                            child: new Text('Credits: Central Bank of Nigeria',
                                style: new TextStyle(
                                    color: Colors.grey
                                )
                            ),
                            onPressed: () {
                              Navigator.push(context,
                                  new MaterialPageRoute(
                                      builder: (context) => new Centrifuge(data: widget.data, password: widget.password)
                                  )
                              );
                            },
                          )
                      ),
                    ),
//                      new Container(
//                        padding: new EdgeInsets.only(left: 44.0, bottom: 0.0),
//                        child: new Row(
//                          children: <Widget>[
//                            new Container(
//                              child: new Text('Credits: ',
//                                style: new TextStyle(
//                                    fontWeight: FontWeight.bold,
//                                    color: Colors.grey
//                                ),
//                              ),
//                            ),
//                            new Container(
//                              child: new Text('Central Bank of Nigeria',
//                                style: new TextStyle(
//                                  color: Colors.grey
//                                )
//                              ),
//                            ),
//                          ],
//                        ),
//                      ),
                    new Container(
                      padding: new EdgeInsets.only(left: 29.0),
                      child: new Align(
                          alignment: FractionalOffset.topLeft,
                          child: new FlatButton(
                            child: new Text('Developer: Centrifuge Group',
                                style: new TextStyle(
                                    color: Colors.grey
                                )
                            ),
                            onPressed: () {
                              Navigator.push(context,
                                  new MaterialPageRoute(
                                      builder: (context) => new Centrifuge(data: widget.data, password: widget.password)
                                  )
                              );
                            },
                          )
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]
        )
      );
      case AuthStatus.signedInSpeaker:
        return new Drawer(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Expanded(
                child: new ListView(
                children: <Widget>[
                  new Container(
                    width: MediaQuery.of(context).size.width,
                    child: new DrawerHeader(
                    decoration: new BoxDecoration(
                        color: Color.fromRGBO(0, 0, 0, 0.8)
                    ),
                    child: new GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => EditProfile(data: widget.data, password: widget.password))
                        );
                      },
                      child: new Container (
                        child: new Column(
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
                            new Container(
                              padding: new EdgeInsets.only(top: 10.0),
                              child: new Text(user.surname + ' ' + user.firstname,
                                style: new TextStyle(
                                    color: Colors.white
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    )
                  ),
                ),
                new Container(
                    child: new Column(
                        children: <Widget> [
//                        new ListTile(
//                          leading: Builder(
//                              builder: (context) => Icon(Icons.person)
//                          ),
//                          title: new Text('Log in for more features!'),
//                          onTap: () {
//                            Navigator.pop(context);
//                            Navigator.push(context,
//                                new MaterialPageRoute(
//                                    builder: (context) => new Login()
//                                )
//                            );
//                          },
//                        ),
                          new ListTile(
                            leading: Builder(
                                builder: (context) => Icon(Icons.add_photo_alternate)
                            ),
                            title: new Text('Photo Speak'),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(context,
                                  new MaterialPageRoute(
                                      builder: (context) => new PhotoSpeak(data: widget.data, password: widget.password)
                                  )
                              );
                            },
                          ),
                          new ListTile(
                            leading: Builder(
                                builder: (context) => Icon(Icons.people)
                            ),
                            title: new Text('Attendees'),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(context,
                                  new MaterialPageRoute(
                                      builder: (context) => new Attendees(data: widget.data, password: widget.password)
                                  )
                              );
                            },
                          ),
//                        new ListTile(
//                          leading: Builder(
//                              builder: (context) => Icon(Icons.photo)
//                          ),
//                          title: new Text('Gallery'),
//                          onTap: () {
//                            Navigator.pop(context);
//                            Navigator.push(context,
//                                new MaterialPageRoute(
//                                    builder: (context) => new Gallery()
//                                )
//                            );
//                          },
//                        ),
                          new ListTile(
                            leading: Builder(
                                builder: (context) => Icon(Icons.sentiment_satisfied)
                            ),
                            title: new Text('Extra Activities'),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(context,
                                  new MaterialPageRoute(
                                      builder: (context) => new ExtraActivities(data: widget.data, password: widget.password)
                                  )
                              );
                            },
                          ),
                          new ListTile(
                            leading: Builder(
                                builder: (context) => Icon(Icons.slideshow)
                            ),
                            title: new Text('Papers/Publications'),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(context,
                                  new MaterialPageRoute(
                                      builder: (context) => new ConferencePaper(data: widget.data, password: widget.password)
                                  )
                              );
                            },
                          ),
//                        new ListTile(
//                          leading: Builder(
//                              builder: (context) => Icon(Icons.message)
//                          ),
//                          title: new Text('My Messages'),
//                          onTap: () {
//                            Navigator.pop(context);
//                            Navigator.push(context,
//                                new MaterialPageRoute(
//                                    builder: (context) => new MyMessages()
//                                )
//                            );
//                          },
//                        ),
//                        new ListTile(
//                          leading: Builder(
//                              builder: (context) => Icon(Icons.contacts)
//                          ),
//                          title: new Text('My Contacts'),
//                          onTap: () {
//                            Navigator.pop(context);
//                            Navigator.push(context,
//                                new MaterialPageRoute(
//                                    builder: (context) => new MyContacts()
//                                )
//                            );
//                          },
//                        ),
//                        new ListTile(
//                          leading: Builder(
//                              builder: (context) => Icon(Icons.book)
//                          ),
//                          title: new Text('My Notes'),
//                          onTap: () {
//                            Navigator.pop(context);
//                            Navigator.push(context,
//                                new MaterialPageRoute(
//                                    builder: (context) => new MyNotes()
//                                )
//                            );
//                          },
//                        ),
                          new ListTile(
                            leading: Builder(
                                builder: (context) => Icon(Icons.slideshow)
                            ),
                            title: new Text('Upload Presentation'),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(context,
                                  new MaterialPageRoute(
                                      builder: (context) => new UploadPresentation(widget.data)
                                  )
                              );
                            },
                          ),
                          new ListTile(
                            leading: Builder(
                                builder: (context) => Icon(Icons.exit_to_app)
                            ),
                            title: new Text('Log out'),
                            onTap: () {
                              setState(() {
                                _authStatus = AuthStatus.notSignedIn;
                              });
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => HomePage())
                              );
                            },
                          ),
                        ]
                      )
                    ),
                  ]
                )
              ),
              new Container(
                child: new Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: new Column(
                    children: <Widget>[
                      Divider(),
//                      new Container(
//                        padding: new EdgeInsets.only(left: 45.0, top: 10.0, bottom: 17.0),
//                        child: new Row(
//                          children: <Widget>[
//                            new Container(
//                              child: new Text('Technology: ',
//                                style: new TextStyle(
//                                  fontWeight: FontWeight.bold,
//                                  color: Colors.grey
//                                ),
//                              ),
//                            ),
//                            new Container(
//                              child: new Text('Java, DevOps',
//                                style: new TextStyle(
//                                  color: Colors.grey,
//                                )
//                              ),
//                            ),
//                          ],
//                        ),
//                      ),
                      new Container(
                        padding: new EdgeInsets.only(left: 29.0),
                        child: new Align(
                            alignment: FractionalOffset.topLeft,
                            child: new FlatButton(
                              child: new Text('Technology: Java, DevOps',
                                  style: new TextStyle(
                                      color: Colors.grey
                                  )
                              ),
                              onPressed: () {
                                Navigator.push(context,
                                    new MaterialPageRoute(
                                        builder: (context) => new Centrifuge(data: widget.data, password: widget.password)
                                    )
                                );
                              },
                            )
                        ),
                      ),
                      new Container(
                        padding: new EdgeInsets.only(left: 29.0),
                        child: new Align(
                            alignment: FractionalOffset.topLeft,
                            child: new FlatButton(
                              child: new Text('Credits: Central Bank of Nigeria',
                                  style: new TextStyle(
                                      color: Colors.grey
                                  )
                              ),
                              onPressed: () {
                                Navigator.push(context,
                                    new MaterialPageRoute(
                                        builder: (context) => new Centrifuge(data: widget.data, password: widget.password)
                                    )
                                );
                              },
                            )
                        ),
                      ),
//                      new Container(
//                        padding: new EdgeInsets.only(left: 44.0, bottom: 0.0),
//                        child: new Row(
//                          children: <Widget>[
//                            new Container(
//                              child: new Text('Credits: ',
//                                style: new TextStyle(
//                                    fontWeight: FontWeight.bold,
//                                    color: Colors.grey
//                                ),
//                              ),
//                            ),
//                            new Container(
//                              child: new Text('Central Bank of Nigeria',
//                                style: new TextStyle(
//                                  color: Colors.grey
//                                )
//                              ),
//                            ),
//                          ],
//                        ),
//                      ),
                      new Container(
                        padding: new EdgeInsets.only(left: 29.0),
                        child: new Align(
                            alignment: FractionalOffset.topLeft,
                            child: new FlatButton(
                              child: new Text('Developer: Centrifuge Group',
                                  style: new TextStyle(
                                      color: Colors.grey
                                  )
                              ),
                              onPressed: () {
                                Navigator.push(context,
                                    new MaterialPageRoute(
                                        builder: (context) => new Centrifuge(data: widget.data, password: widget.password)
                                    )
                                );
                              },
                            )
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      );
    }
  }

//  List<Widget> myMenu = [MenuOne(), MenuTwo()];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334, allowFontScaling: true)..init(context);
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Color.fromRGBO(152, 160, 87, 1),
          title: new Text("ICPS 2019"),
          actions: <Widget>[
//            IconButton(icon: Icon(
//              Icons.search
//            ),
//              onPressed: () {},
//            ),
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
        floatingActionButton: _buildFab (context),
      floatingActionButtonLocation: fabMenuLocation,
        body: Center(
          child: new SingleChildScrollView(
            child: new Column (
              children: <Widget>[
//                new Expanded(
//                  child: new SizedBox(
//                    child: new Column(
//                      children: <Widget>[
                        Padding (padding: EdgeInsets.only(top: 42.0)),
                        new Row (
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            new GestureDetector (
                              onTap: () {
                                Navigator.push (context,
                                    MaterialPageRoute(builder: (context) => Agenda(data: widget.data, password: widget.password,))
                                );
                              },
                              child: new Column (
                                children: <Widget> [
                                  new Container(
                                    width: ScreenUtil.getInstance().setWidth(135),
                                    height: ScreenUtil.getInstance().setHeight(135),
                                    decoration: BoxDecoration(
                                        image: new DecorationImage(
                                            image: new AssetImage(
                                                'assets/images/icons/calendarTwo.png'
                                            )
                                        )

                                    ),
//                            child: new Center (
//                              child: new Icon(Icons.event_available ),
//                            ),
                                  ),
                                  Padding (padding: EdgeInsets.only(top: 6.0)),
                                  new Container(
                                      child: Text("Agenda")

                                  ),
                                ],
                              ),
                            ),
                            new GestureDetector (
                              onTap: () {
                                Navigator.push (context,
                                    MaterialPageRoute(builder: (context) => Locations(data: widget.data, password: widget.password,))
                                );
                              },
                              child: new Column (
                                children: <Widget> [
                                  new Container(
                                    width: ScreenUtil.getInstance().setWidth(135),
                                    height: ScreenUtil.getInstance().setHeight(135),
                                    decoration: BoxDecoration(
                                        image: new DecorationImage(
                                            image: new AssetImage(
                                                'assets/images/icons/mapTwo.png'
                                            )
                                        )
                                    ),
//                            child: new Center (
//                              child: new Icon(Icons.location_on ),
//                            ),
                                  ),
                                  Padding (padding: EdgeInsets.only(top: 6.0)),
                                  new Container(
                                      child: Text("Location")
                                  ),
                                ],
                              ),
                            ),
                            new GestureDetector (
                              onTap: () {Navigator.push (
                                  context,
                                  MaterialPageRoute(builder: (context) => NewSpeakers(data: widget.data, password: widget.password)));},
                              child: new Column (
                                children: <Widget> [
                                  new Container(
                                    width: ScreenUtil.getInstance().setWidth(135),
                                    height: ScreenUtil.getInstance().setHeight(135),
                                    decoration: BoxDecoration(
                                        image: new DecorationImage(
                                            image: new AssetImage(
                                                'assets/images/icons/megaphoneTwo.png'
                                            )
                                        )
                                    ),
//                            child: new Center (
//                              child: new Icon(Icons.mic),
//                            ),
                                  ),
                                  Padding (padding: EdgeInsets.only(top: 6.0)),
                                  new Container(
                                      child: Text("Speakers")
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding (padding: EdgeInsets.only(top: 76.0)),
                        new Row (
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            new GestureDetector (
                              onTap: () {
                                Navigator.push (context,
                                    MaterialPageRoute(builder: (context) => NewExhibitions(data: widget.data, password: widget.password))
                                );
                              },
                              child: new Column (
                                children: <Widget> [
                                  new Container(
                                    width: ScreenUtil.getInstance().setWidth(135),
                                    height: ScreenUtil.getInstance().setHeight(135),
                                    decoration: BoxDecoration(
                                        image: new DecorationImage(
                                            image: new AssetImage(
                                                'assets/images/icons/exhibitionTwo.png'
                                            )
                                        )
                                    ),
//                            child: new Center (
//                              child: new Icon(Icons.card_membership ),
//                            ),
                                  ),
                                  Padding (padding: EdgeInsets.only(top: 6.0)),
                                  new Container(
                                      child: Text("Exhibitions")
                                  ),
                                ],
                              ),
                            ),
                            new GestureDetector (
                              onTap: () {
                                Navigator.push (context,
                                    MaterialPageRoute(builder: (context) => ActivityFeed(data: widget.data, password: widget.password))
                                );
                              },
                              child: new Column (
                                children: <Widget> [
                                  new Container(
                                    width: ScreenUtil.getInstance().setWidth(135),
                                    height: ScreenUtil.getInstance().setHeight(135),
                                    decoration: BoxDecoration(
                                        image: new DecorationImage(
                                            image: new AssetImage(
                                                'assets/images/icons/discussionTwo.png'
                                            )
                                        )
                                    ),
//                            child: new Center (
//                              child: new Icon(Icons.chat ),
//                            ),
                                  ),
                                  Padding (padding: EdgeInsets.only(top: 6.0)),
                                  new Container(
                                      child: Text("Chatter Forum")
                                  ),
                                ],
                              ),
                            ),
                            new GestureDetector (
                              onTap: () {Navigator.push (context,
                                  MaterialPageRoute(builder: (context) => NewPartners(data: widget.data, password: widget.password)));},
                              child: new Column (
                                children: <Widget> [
                                  new Container(
                                    width: ScreenUtil.getInstance().setWidth(135),
                                    height: ScreenUtil.getInstance().setHeight(135),
                                    decoration: BoxDecoration(
                                        image: new DecorationImage(
                                            image: new AssetImage(
                                                'assets/images/icons/meetingTwo.png'
                                            )
                                        )

                                    ),
//                            child: new Center (
//                              child: new Icon(Icons.person),
//                            ),
                                  ),
                                  Padding (padding: EdgeInsets.only(top: 6.0)),
                                  new Container(
                                      child: Text("Partners")
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding (padding: EdgeInsets.only(top: 76.0)),
                        new Row (
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            new GestureDetector (
                              onTap: () {
                                Navigator.push (context,
                                    MaterialPageRoute(builder: (context) => Conference(data: widget.data, password: widget.password))
                                );
                              },
                              child: new Column (
                                children: <Widget> [
                                  new Container(
                                    width: ScreenUtil.getInstance().setWidth(135),
                                    height: ScreenUtil.getInstance().setHeight(135),
                                    decoration: new BoxDecoration(
                                        image: new DecorationImage(
                                            image: new AssetImage(
                                                'assets/images/icons/presentationTwo.png'
                                            )
                                        )
                                    ),
//                            child: new Center (
//                              child: new Icon(Icons.info ),
//                            ),
                                  ),
                                  Padding (padding: EdgeInsets.only(top: 6.0)),
                                  new Container(
                                      child: Text("Conference")
                                  ),
                                ],
                              ),
                            ),
                            new GestureDetector (
                              onTap: () {
                                if (_authStatus == AuthStatus.notSignedIn) {
                                  _showDialog(context);
                                }
                                else {
                                  Navigator.push (
                                      context,
                                      MaterialPageRoute(builder: (context) => NewMessages(data: widget.data, password: widget.password))
                                  );
                                }
                              },
                              child: new Column (
                                children: <Widget> [
                                  new Container(
                                    width: ScreenUtil.getInstance().setWidth(135),
                                    height: ScreenUtil.getInstance().setHeight(135),
                                    decoration: BoxDecoration(
                                        image: new DecorationImage(
                                            image: new AssetImage(
                                                'assets/images/icons/messages.png'
                                            )
                                        )

                                    ),
//                            child: new Center (
//                              child: new Icon(Icons.feedback ),
//                            ),
                                  ),
                                  Padding (padding: EdgeInsets.only(top: 6.0)),
                                  new Container(
                                      child: Text("My Messages")
                                  ),
                                ],
                              ),
                            ),
                            new GestureDetector (
                              onTap: () {
                                Navigator.push (context,
                                    MaterialPageRoute(builder: (context) => Faq(data: widget.data, password: widget.password))
                                );
                              },
                              child: new Column (
                                children: <Widget> [
                                  new Container(
                                    width: ScreenUtil.getInstance().setWidth(135),
                                    height: ScreenUtil.getInstance().setHeight(135),
                                    decoration: BoxDecoration(
                                        image: new DecorationImage(
                                            image: new AssetImage(
                                                'assets/images/icons/faq.png'
                                            )
                                        )
                                    ),
//                            child: new Center (
//                              child: new Icon(Icons.thumb_up),
//                            ),
                                  ),
                                  Padding (padding: EdgeInsets.only(top: 6.0)),
                                  new Container(
                                      child: Text("FAQ")
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
//                Padding (padding: EdgeInsets.only(top: 46.0)),
//                new Row (
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  mainAxisAlignment: MainAxisAlignment.spaceAround,
//                  children: <Widget>[
//                    new GestureDetector (
//                      onTap: () {
//                        Navigator.push (context,
//                            MaterialPageRoute(builder: (context) => Gallery())
//                        );
//                      },
//                      child: new Column (
//                        children: <Widget> [
//                          new Container(
//                            width: ScreenUtil.getInstance().setWidth(135),
//                            height: ScreenUtil.getInstance().setHeight(135),
//                            decoration: BoxDecoration(
//                              image: new DecorationImage(
//                                image: new AssetImage(
//                                  'assets/images/icons/gallery.png'
//                                )
//                              )
//
//                            ),
////                            child: new Center (
////                              child: new Icon(Icons.photo ),
////                            ),
//                          ),
//                          Padding (padding: EdgeInsets.only(top: 6.0)),
//                          new Container(
//                              child: Text("Gallery")
//                          ),
//                        ],
//                      ),
//                    ),
//                    new GestureDetector (
//                      onTap: () {
//                        Navigator.push (context,
//                            MaterialPageRoute(builder: (context) => ExtraActivities())
//                        );
//                      },
//                      child: new Column (
//                        children: <Widget> [
//                          new Container(
//                            width: ScreenUtil.getInstance().setWidth(135),
//                            height: ScreenUtil.getInstance().setHeight(135),
//                            decoration: BoxDecoration(
//                              image: new DecorationImage(
//                                image: new AssetImage(
//                                  'assets/images/icons/businessman.png'
//                                )
//                              )
//
//                            ),
////                            child: new Center (
////                              child: new Icon(Icons.add_to_queue),
////                            ),
//                          ),
//                          Padding (padding: EdgeInsets.only(top: 6.0)),
//                          new Container(
//                              child: Text("Extra Activities")
//                          ),
//                        ],
//                      ),
//                    ),
//                    new GestureDetector (
//                      onTap: () {
//                        Navigator.push (context,
//                            MaterialPageRoute(builder: (context) => ConferencePaper())
//                        );
//                      },
//                      child: new Column (
//                        children: <Widget> [
////                          new Container(
////                            width: ScreenUtil.getInstance().setWidth(135),
////                            height: ScreenUtil.getInstance().setHeight(135),
////                            decoration: BoxDecoration(
////                                image: new DecorationImage(
////                                    image: new AssetImage(
////                                        'assets/images/icons/elevator.png'
////                                    )
////                                )
////
////                            ),
//////                            child: new Center (
//////                              child: new Icon(Icons.person_add ),
//////                            ),
////                          ),
////                          Padding (padding: EdgeInsets.only(top: 6.0)),
////                          new Container(
////                              child: Text("Register Now")
////                          ),
//                          new Container(
//                            width: ScreenUtil.getInstance().setWidth(135),
//                            height: ScreenUtil.getInstance().setHeight(135),
//                            decoration: BoxDecoration(
//                                image: new DecorationImage(
//                                    image: new AssetImage(
//                                        'assets/images/icons/file.png'
//                                    )
//                                )
//
//                            ),
////                            child: new Center (
////                              child: new Icon(Icons.person_add ),
////                            ),
//                          ),
//                          Padding (padding: EdgeInsets.only(top: 6.0)),
//                          new Container(
//                            width: ScreenUtil.getInstance().setWidth(149),
//                              child: Text("Papers / Publications")
//                          ),
//                        ],
//                      ),
//                    ),
//                  ],
//                ),
//                      ],
//                    ),
//                  ),
//                ),
                new Container(
                  padding: EdgeInsets.only(top: 36.0),
//                  height: MediaQuery.of(context).devicePixelRatio,
                  child: new Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: new Text("Powered by Central Bank of Nigeria",
                        style: TextStyle(color: Color.fromRGBO(192, 192, 192, 1))),
                  )

                )
              ],
            ),
          ),
        ),
  //      PageIndicatorContainer(
  //        pageView: PageView(
  //          children: <Widget>[
  //            MenuOne(),
  //            MenuTwo(),
  //          ],
  //          controller: new PageController(),
  //        ),
  //        align: IndicatorAlign.bottom, // your indicator align with container
  //        length: 2, // indicator count
  //        indicatorColor: Color.fromRGBO(192, 192, 192, 1), // unselected indicator color
  //        indicatorSelectorColor: Color.fromRGBO(25, 110, 42, 1), // selected indicator color
  //        padding: EdgeInsets.only(bottom: 5.0), // padding with bottom .when align top you should use properties `top:10.0`
  //        size: 15.0, // indicator size.
  //        indicatorSpace: 10.0, // space between circles
  //      ),
        drawer: _buildDrawer(context),
    );
  }

  Widget _buildFab (BuildContext context) {
    if (_authStatus == AuthStatus.signedIn)
    {
//      return FloatingActionButton(
//        child: new Icon(Icons.exit_to_app),
//        onPressed: () {
//          _authStatus = AuthStatus.notSignedIn;
//        },
//      );
      return new FabMenu(
        menus: [new MenuData(Icons.photo, (context, menuData) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PhotoSpeak(data: widget.data, password: widget.password))
          );
        },labelText: 'Photo Speak'),
          new MenuData(Icons.people, (context, menuData) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Attendees(data: widget.data, password: widget.password))
            );
          },labelText: 'Join Attendee List'),
          new MenuData(Icons.videocam, (context, menuData) {
//            Navigator.push(context,
//                MaterialPageRoute(builder: (context) => Attendees())
//            );
          },labelText: 'Join via LiveCam'),
          new MenuData(Icons.forum, (context, menuData) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ActivityFeed(data: widget.data, password: widget.password))
            );
          },labelText: 'Chatter Forum'),
          new MenuData(Icons.exit_to_app, (context, menuData) {
            setState(() {
              _authStatus = AuthStatus.notSignedIn;
            });
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => HomePage())
            );
          },labelText: 'Logout'),
        ],
        maskColor: Colors.black,
        mainButtonBackgroundColor: Color.fromRGBO(152, 160, 87, 1),
        menuButtonBackgroundColor: Color.fromRGBO(152, 160, 87, 1),
        labelBackgroundColor: Color.fromRGBO(152, 160, 87, 1),
        menuButtonColor: Colors.white,
        labelTextColor: Colors.white,
      );
    }
    else if (_authStatus == AuthStatus.signedInSpeaker)
    {
//      return FloatingActionButton(
//        child: new Icon(Icons.exit_to_app),
//        onPressed: () {
//          _authStatus = AuthStatus.notSignedIn;
//        },
//      );
      return new FabMenu(
        menus: [new MenuData(Icons.photo, (context, menuData) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PhotoSpeak(data: widget.data, password: widget.password))
          );
        },labelText: 'Photo Speak'),
          new MenuData(Icons.people, (context, menuData) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Attendees(data: widget.data, password: widget.password))
            );
          },labelText: 'Join Attendee List'),
          new MenuData(Icons.videocam, (context, menuData) {
//            Navigator.push(context,
//                MaterialPageRoute(builder: (context) => Attendees())
//            );
          },labelText: 'Join via LiveCam'),
          new MenuData(Icons.forum, (context, menuData) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ActivityFeed(data: widget.data, password: widget.password))
            );
          },labelText: 'Chatter Forum'),
          new MenuData(Icons.exit_to_app, (context, menuData) {
            setState(() {
              _authStatus = AuthStatus.notSignedIn;
            });
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => HomePage())
            );
          },labelText: 'Logout'),
        ],
        maskColor: Colors.black,
        mainButtonBackgroundColor: Color.fromRGBO(152, 160, 87, 1),
        menuButtonBackgroundColor: Color.fromRGBO(152, 160, 87, 1),
        labelBackgroundColor: Color.fromRGBO(152, 160, 87, 1),
        menuButtonColor: Colors.white,
        labelTextColor: Colors.white,
      );
    }
    else
    {
      return new FabMenu(
        menus: [new MenuData(Icons.vpn_key, (context, menuData) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Login())
          );
        },labelText: 'Login'),
        new MenuData(Icons.person_add, (context, menuData) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Register())
          );
        },labelText: 'Register')
        ],
        maskColor: Colors.black,
        mainButtonBackgroundColor: Color.fromRGBO(152, 160, 87, 1),
        menuButtonBackgroundColor: Color.fromRGBO(152, 160, 87, 1),
        labelBackgroundColor: Color.fromRGBO(152, 160, 87, 1),
        menuButtonColor: Colors.white,
        labelTextColor: Colors.white,
      );
    }
  }

//  void _showDialog (BuildContext context)
//  {
//    var alertDialog = AlertDialog(
//      content: new Text('Choose option'),
//      actions: <Widget>[
//        new FlatButton(
//          child: new Text('Login'),
//          onPressed: () {
//            Navigator.push (context, MaterialPageRoute(builder: (context) => Login()));
//          },
//        ),
//        new FlatButton(
//          child: new Text('Register'),
//          onPressed: () {
//            Navigator.push (context, MaterialPageRoute(builder: (context) => Login()));
//          },
//        ),
//      ],
//    );
//
//    showDialog(
//        context: context,
//        builder: (BuildContext context) {
////       if (progressString != '100%') {
//          return alertDialog;
//
////       }
//        },
////        barrierDismissible: false
//    );
//  }

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
            MaterialPageRoute(builder: (context) => EditProfile(data: widget.data, password: widget.password))
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

