import 'package:flutter/material.dart';
import 'package:icps/AttendeeJson.dart';
import 'package:icps/MessagesJson.dart';
import 'package:icps/UsersInfo.dart';
import 'package:icps/Constants.dart';
import 'package:icps/app_screens/Register.dart';
import 'package:icps/app_screens/drawer/Login.dart';

import 'package:icps/app_screens/popupMenu/Dashboard.dart';
import 'package:icps/app_screens/popupMenu/EditProfile.dart';
import 'package:icps/app_screens/popupMenu/Settings.dart';

//import 'dart:async';
import 'package:dio/dio.dart';
import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

void main() async {
//  var to = new List();
//
//  List<JoinAttendeeList> toed = [];
////
//  to.add(toed);
//
//  print("Got here as "+to.toString());
//
////  print()
//
////  JoinAttendeeList firstTo = toed.first;
//
//  String getUrl = 'http://icps19.com:6060/icps/icps/19/jal';
//
//  var res = await http.get(getUrl);
//  var jsonStr = res.body;
//
////   for (JoinAttendeeList ss in firstTo){
////     print(ss.usersInfo.userinfoid);
////   }
//
//
// // var currentToSelected = firstTo.usersInfo.userinfoid.toString();
////   var currentToSelected = "Test...";
//   var currentToSelected;
//  var toe = to.first;
//  print ('To ${toe.surname}');
  runApp(MaterialApp (
//    debugShowCheckedModeBanner: false,
    home: ComposeMessage(),
  )
  );
}





class ComposeMessage extends StatefulWidget {

  Data data; MyMessages myMessages; var to; TextEditingController toFilter; String password;

  ComposeMessage({this.data, this.myMessages, this.to, this.toFilter, this.password}) {

    to = myMessages !=  null ? "${myMessages.usersInfo.title} ${myMessages.usersInfo.surname} ${myMessages.usersInfo.firstname}" : "";

    toFilter = new TextEditingController(text: to);
  }

  @override
  _ComposeMessageState createState() => _ComposeMessageState();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
  signedInSpeaker
}

//var toe = _getAttendees();

//Future<List<JoinAttendeeList>> _getAttendees() async {
//
//  String getUrl = 'http://icps19.com:6060/icps/icps/19/jal';
//
//  var res = await http.get(getUrl);
//  var jsonStr = res.body;
//  var parsedUserList =  jsonDecode(jsonStr);
//  var userList = <JoinAttendeeList>[];
//  parsedUserList.forEach((parsedUser) {
//    userList.add(
//        new JoinAttendeeList.fromJson(parsedUser)
//    );
//  });
//  return userList;
//}

//Future<List<JoinAttendeeList>> _getAttendees() async {
//
////    String getUrl = 'http://icps19.com:6060/icps/icps/19/jal';
//
//  String getUrl = 'http://icps19.com:6060/icps/icps/19/jal';
//
//  var attendeeData = await http.get(getUrl);
//
//  var jsonData = attendeeData.body;
//  print(jsonData);
////    print('get');
//  List <JoinAttendeeList> joinAttendee = joinAttendeeListFromJson(jsonData);
////    print('get2');
//  List <JoinAttendeeList> attendee = [];
//
//  JoinAttendeeList attendeeList;
//
//
//  try
//  {
//    for (JoinAttendeeList ss in joinAttendee)
//    {
//      //String timeFormat = DateFormat('HH, mm').format(ss.messagedate);
//      //DateTime time = DateTime.parse(timeFormat);
//
//
//      attendeeList = JoinAttendeeList (
//          usersInfo: ss.usersInfo
//      );
//
//      attendee.add(attendeeList);
//
//
//    }
//  }
//  catch(e)
//  {
//    print('Error: $e');
//  }
//
//  print(attendee.length);
//
////  var listNow = new List();
////
////  listNow.add(attendeeList.usersInfo);
//
//  return attendee;
//}

class _ComposeMessageState extends State<ComposeMessage> {

  AuthStatus _authStatus = AuthStatus.notSignedIn;

  final formKey = new GlobalKey<FormState>();

  final global = GlobalKey();

//  final TextEditingController _toFilter = new TextEditingController(text: widget.to);

  final TextEditingController _messageFilter = new TextEditingController();

  final FocusNode _toFocus = FocusNode();
  final FocusNode _messageFocus = FocusNode();

  String _to = "";
  String _message = "";

  var currentToSelected;

//  var to = new List();

//  var to[] = _getAttendees();

//  var _currentTo = to[0];

//  var _currentToSelected = UsersInfo(
//      companysector: '',
//      conferenceId: '',
//      country: '',
//      email: '',
//      facebookId: '',
//      firstname: '',
//      instagramId: '',
//      loginstatus: '',
//      moderatorYn: false,
//      organisation: '',
//      participantType: '',
//      password: '',
//      shortProfile: '',
//      speakerYn: false,
//      surname: '',
//      title: '',
//      twitterId: '',
//      userinfoid: 0,
//      username: '',
//      website: '',
//      workPosition: ''
//  );

  final String url = 'http://icps19.com:6060/icps/icps/19/jal';
  List data = List();

  Future<String> _getAttendees() async {


    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      data = resBody;
    });

    print(resBody);

    return "Success";
  }

  ComposeMessage() {
    widget.toFilter.addListener(_toListen);
    _messageFilter.addListener(_messageListen);
  }

  void _toListen() {
    if (widget.toFilter.text.isEmpty) {
      _to = "";
    } else {
      _to = widget.toFilter.text;
    }
  }

  void _messageListen() {
    if (_messageFilter.text.isEmpty) {
      _message = "";
    } else {
      _message = _messageFilter.text;
    }
  }

  @override
  void initState() {
    super.initState();

    widget.data = widget.data ?? Data();

    _authStatus = ((widget.data.surname == '')) ? AuthStatus.notSignedIn : (widget.data.speaker && widget.data.surname != '') ? AuthStatus.signedInSpeaker : AuthStatus.signedIn;

    widget.myMessages = widget.myMessages ?? MyMessages(
        id: 0,
        mFrom: 0,
        mMessage: '',
        mTo: 0,
        messagedate: '',
        messageread: false,
        sentToInfo: UsersInfo(
            companysector: "",
            conferenceId: "",
            country: "",
            email: "",
            facebookId: "",
            firstname: "",
            instagramId: "",
            loginstatus: "",
            moderatorYn: false,
            organisation: "",
            participantType: "",
            password: "",
            shortProfile: "",
            speakerYn: false,
            surname: "",
            title: "",
            twitterId: "",
            userinfoid: 0,
            username: "",
            website: "",
            workPosition: ""
        ),
        userinfoid: 0,
        usersInfo: UsersInfo(
            companysector: "",
            conferenceId: "",
            country: "",
            email: "",
            facebookId: "",
            firstname: "",
            instagramId: "",
            loginstatus: "",
            moderatorYn: false,
            organisation: "",
            participantType: "",
            password: "",
            shortProfile: "",
            speakerYn: false,
            surname: "",
            title: "",
            twitterId: "",
            userinfoid: 0,
            username: "",
            website: "",
            workPosition: ""
        ),
        messageType: ''
    );


//    widget.myMessages != null ? currentToSelected = widget.myMessages.usersInfo;

    //    refreshList();

//    to.add(_currentToSelected);

//    to.add(widget.toed);

    this._getAttendees();

//    var firstTo = to.first;
//
//    _currentToSelected = firstTo.userinfoid.toString();
//    print(_currentToSelected.surname);

//    setState(() {
//      to.add(_getAttendees());
//    });
//
//    _currentToSelected = to[0];

//    controller = new ScrollController()..addListener(_scrollListener);
  }

//   _getAttendees() async {
//
////    String getUrl = 'http://icps19.com:6060/icps/icps/19/jal';
//
//    String getUrl = 'http://icps19.com:6060/icps/icps/19/jal';
//
//    var attendeeData = await http.get(getUrl);
//
//    var jsonData = attendeeData.body;
//    print(jsonData);
////    print('get');
//    List <JoinAttendeeList> joinAttendee = joinAttendeeListFromJson(jsonData);
////    print('get2');
//    List <JoinAttendeeList> attendee = [];
//
//    JoinAttendeeList attendeeList;
//
//
//    try
//    {
//      for (JoinAttendeeList ss in joinAttendee)
//      {
//        //String timeFormat = DateFormat('HH, mm').format(ss.messagedate);
//        //DateTime time = DateTime.parse(timeFormat);
//
//
//        attendeeList = JoinAttendeeList (
//            datetimejoined: ss.datetimejoined,
//            id: ss.id,
//            userinfoid: ss.userinfoid,
//            usersInfo: ss.usersInfo
//        );
//
//        attendee.add(attendeeList);
//
//
//      }
//    }
//    catch(e)
//    {
//      print('Error: $e');
//    }
//
//    print(attendee.length);
//
//
//    return attendeeList.usersInfo;
//  }

  @override
  Widget build(BuildContext context) {
//    final json = JsonDecoder().convert(widget.jsonStr);
//    widget.toed = (json).map<JoinAttendeeList>((item) => JoinAttendeeList.fromJson(item)).toList();
//    widget.currentToSelected = widget.toed[0].usersInfo.userinfoid.toString();
//    print ('this: ${widget.myMessages.usersInfo.userinfoid}');
    return Scaffold(
      key: global,
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(152, 160, 87, 1),
        title: new Text("New Message"),
        leading: Builder(
          builder: (context) =>
              IconButton(
                icon: new Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
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
              padding: new EdgeInsets.only(top: 20.0, bottom: 20.0, left: 15.0, right: 15.0),
              child: new Form(
                key: formKey,
                child: new Column(
                  children: <Widget>[
                    new Container(
                      margin: new EdgeInsets.all(10.0),
                      width: MediaQuery.of(context).size.width,
                      child: new InputDecorator(
                          decoration: InputDecoration(
                              labelText: 'To*',
                              prefixIcon: Padding(
                                  padding: EdgeInsets.all(0.0),
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.grey,
                                  )
                              )
                          ),
//                                    alignedDropdown: true,
                          child: DropdownButtonHideUnderline(
//                                        child: new Container(
//                                          decoration: ShapeDecoration(
//                                            shape: RoundedRectangleBorder(
//                                              side: BorderSide(
//                                                  width: 1.0,
//                                                  style: BorderStyle.solid
//                                              ),
//                                              borderRadius: BorderRadius.all(
//                                                  Radius.circular(5.0)
//                                              ),
//                                            ),
//                                          ),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              isDense: true,
//                              hint: new Text('To*'),
                              items: data.map((item) {
                                return DropdownMenuItem<String> (
                                  value: item['usersInfo'] == null ? (){var ff = Data(); return ff.userinfoid.toString();}() : item['usersInfo']['userinfoid'].toString(),
                                  child: Text(item['usersInfo'] == null ? 'No other participant has joined attendee list yet'

                                      : item['usersInfo']['userinfoid'] != widget.data.id ?
                                  '${item['usersInfo']['title']} ${item['usersInfo']['surname']} ${item['usersInfo']['firstname']}' : ''),
                                );
                              }).toList(),
                              onChanged: (String newValueSelected) {
                                setState(() {
                                  currentToSelected = newValueSelected;
                                });
                                print(currentToSelected);
                              },
                              value: currentToSelected,
                            ),
                          )
                      ),
//                                  )
                    ),

                    new Container(
                      margin: new EdgeInsets.only(bottom: 15.0),
                      child: new TextFormField(
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.done,
                        focusNode: _messageFocus,
                        controller: _messageFilter,
                        decoration: new InputDecoration(
                            labelText: 'Message*',
                            prefixIcon: Padding(
                                padding: EdgeInsets.all(0.0),
                                child: Icon(
                                  Icons.message,
                                  color: Colors.grey,
                                )
                            )
//                          border: new OutlineInputBorder(
//                              borderSide: new BorderSide(
//                                  color: Color.fromRGBO(53, 182, 134, 1),
//                                  width: 1.0
//                              ),
//                              borderRadius: BorderRadius.circular(5.0)
//                          ),
                        ),
                        validator: (value) => value.isEmpty ? 'Message can\'t be empty' : null,
                        onSaved: (value) => _message = value,
//                        autovalidate: _validate,
                        onFieldSubmitted: (term){
                          _messageFocus.unfocus();
                          validateAndSubmit();
                        },
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.all(11.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: new BoxDecoration(
                          color: Color.fromRGBO(53, 182, 134, 1),
                          borderRadius: new BorderRadius.circular(5.0)
                      ),
                      child: new FlatButton(
                          child: new Text('Send',
                            style: new TextStyle(
                                color: Colors.white,
                                fontSize: 16.0
                            ),
                          ),
                          onPressed: () async {
//                            Response response;
//                            _showDialog(context);
                            validateAndSubmit();
//                            Navigator.pop(context, (response.statusCode == 200 || response.statusCode == 401));
                          }
                      ),
                    ),
                  ],
                )
              ),
            )
          ],
        ),
      ),
    );
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  bool validateAndSave () {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    }

    return false;
  }

  void validateAndSubmit () async {
//    print ('this: ${widget.myMessages.usersInfo.userinfoid}');
    if (validateAndSave())
    {
      try
      {
        _showDialog(context);

        final String url = 'http://icps19.com:6060/icps/icps/19/msg';

        var currentId = int.parse(currentToSelected);
        assert(currentId is int);

//        int myMessageId = widget.myMessages.usersInfo.userinfoid;

        int mToId = widget.myMessages != null ? widget.myMessages.usersInfo.userinfoid : currentId;

//        print ('this: ${widget.myMessages.usersInfo.userinfoid}');

        Response response;
        Dio dio = new Dio();
        response = await dio.post(url, queryParameters: {"m_from":widget.data.id,"m_to": mToId,"m_message":_message, "userinfoid": widget.data.id,"messageread":false},
            options: Options(
              headers: {HttpHeaders.contentTypeHeader: 'application/json',"accept": "application/json"},)
        );

        print(response.statusCode);

        Navigator.pop(context, (response.statusCode == 200 || response.statusCode == 401 || response.statusCode == 111));

        if(response.statusCode == 200){

          print(_to);
          print(_message);
          print(widget.data.surname);

          Fluttertoast.showToast(
              msg: "Message Sent",
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

  void _showDialog (BuildContext context)
  {
    var alertDialog = AlertDialog(
//      title: new Text('Downloading'),
      contentPadding: EdgeInsets.all(0.0),
      backgroundColor: Colors.transparent,
      content: Container(
        height: 120.0,
        width: 200.0,
        child: Card(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(
                height: 10.0,
              ),
              Text ('Message Sending',
                style: new TextStyle (
                    color: Colors.white
                ),
              )
            ],
          ),
        ),
      ),
//      ),
//      actions: <Widget>[
//
//      ],
    );

    showDialog(
        context: global.currentContext,
        builder: (BuildContext context) {
//       if (progressString != '100%') {
          return alertDialog;

//       }
        },
        barrierDismissible: false
    );


  }

  void _onDropDownToSelected (String newValueSelected)
  {
    setState(() {
      this.currentToSelected = newValueSelected;
    });
  }
}
