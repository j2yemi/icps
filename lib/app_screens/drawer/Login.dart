import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;

import 'package:icps/icps_19_json.dart';
import 'package:icps/app_screens/HomePage.dart';

//import 'package:toast/toast.dart';
//import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter_email_sender/flutter_email_sender.dart';
//import 'package:mailer/mailer.dart';
//import 'package:mailer/smtp_server.dart';
//import 'package:mailer/smtp_server/mailgun.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icps/UsersInfo.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'dart:async';

void main() {
  runApp(MaterialApp (
    debugShowCheckedModeBanner: false,
    home: Login(),
  )
  );
}

class Login extends StatefulWidget {

  @override
  _LoginState createState() => new _LoginState();
}

enum FormType {
  login,
  register,
  registerSocial,
  registerCode
}

class _LoginState extends State<Login> {

  final formKey = new GlobalKey<FormState>();

  final global = GlobalKey();

  bool _autoValidate = false;

//  var userSurname = '';
//  var userFirstname = '';

  String signUpType;

//  CrudMethods crudObj = new CrudMethods();

  final TextEditingController _emailFilter = new TextEditingController();
//  final TextEditingController _passwordFilter = new TextEditingController();
//  final TextEditingController _cPasswordFilter = new TextEditingController();
  final TextEditingController _phoneFilter = new TextEditingController();
  final TextEditingController _surnameFilter = new TextEditingController();
  final TextEditingController _firstnameFilter = new TextEditingController();
  final TextEditingController _usernameFilter = new TextEditingController();
  final TextEditingController _passwordFilter = new TextEditingController();
  final TextEditingController _organizationFilter = new TextEditingController();
  final TextEditingController _jobTitleFilter = new TextEditingController();
  final TextEditingController _facebookFilter = new TextEditingController();
  final TextEditingController _twitterFilter = new TextEditingController();
  final TextEditingController _websiteFilter = new TextEditingController();
  final TextEditingController _shortProfileFilter = new TextEditingController();
  final TextEditingController _codeFilter = new TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _surnameFocus = FocusNode();
  final FocusNode _firstnameFocus = FocusNode();
  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _organisationFocus = FocusNode();
  final FocusNode _jobTitleFocus = FocusNode();
  final FocusNode _facebookFocus = FocusNode();
  final FocusNode _twitterFocus = FocusNode();
  final FocusNode _websiteFocus = FocusNode();
  final FocusNode _shortProfileFocus = FocusNode();

  String _email = "";
//  String _password = "";
  String _phone = "";
  String _surname = "";
  String _firstname = "";
  String _username = "";
  String _password = "";
  var _title = ['Alh.', 'Bar.', 'Dr.', 'Engr.', 'Fr.', 'Haj.', 'Mal.', 'Miss', 'Mr.', 'Mrs.', 'Pharm.', 'Prof.', 'Sis.'];
  var _companySector = ['Finance', 'Agriculture', 'Oil and Gas', 'Services', 'Transport', 'Tourism', 'Mining', 'Energy', 'Data',
  'Electricity', 'Overseas remittances', 'Real Estate/Construction', 'Consumer Goods', 'Healthcare', 'Industrial Goods',
  'Information and Communications Technology ICT', 'Natural Resources', 'Utilities', 'Manufacturing Industry', 'Chemical Industry', 'Consumer Electronics',
  'Steel Production', 'Aerospace Industry', 'Brewing Industry', 'Textile Industry', 'Metal Working', 'Computer Industry', 'Defense Industry',
  'Education Industry', 'Entertainment Industry', 'Food Industry', 'Hospitality Industry', 'Mass media', 'Telecommunications Industry', 'Water Industry'];

  var _country = ["Afghanistan", "Albania", "Algeria", "American Samoa", "Andorra", "Angola", "Anguilla", "Antarctica",
  "Antigua and Barbuda", "Argentina", "Armenia", "Aruba", "Australia", "Austria", "Azerbaijan", "Bahamas", "Bahrain",
  "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin", "Bermuda", "Bhutan", "Bolivia", "Bosnia and Herzegowina",
  "Botswana", "Bouvet Island", "Brazil", "British Indian Ocean Territory", "Brunei Darussalam", "Bulgaria", "Burkina Faso",
  "Burundi", "Cambodia", "Cameroon", "Canada", "Cape Verde", "Cayman Islands", "Central African Republic", "Chad", "Chile",
  "China", "Christmas Island", "Cocos (Keeling) Islands", "Colombia", "Comoros", "Congo", "Congo, the Democratic Republic of the",
  "Cook Islands", "Costa Rica", "Cote d'Ivoire", "Croatia (Hrvatska)", "Cuba", "Cyprus", "Czech Republic", "Denmark", "Djibouti",
  "Dominica", "Dominican Republic", "East Timor", "Ecuador", "Egypt", "El Salvador", "Equatorial Guinea", "Eritrea", "Estonia",
  "Ethiopia", "Falkland Islands (Malvinas)", "Faroe Islands", "Fiji", "Finland", "France", "France Metropolitan", "French Guiana",
  "French Polynesia", "French Southern Territories", "Gabon", "Gambia", "Georgia", "Germany", "Ghana", "Gibraltar", "Greece",
  "Greenland", "Grenada", "Guadeloupe", "Guam", "Guatemala", "Guinea", "Guinea-Bissau", "Guyana", "Haiti", "Heard and Mc Donald Islands",
  "Holy See (Vatican City State)", "Honduras", "Hong Kong", "Hungary", "Iceland", "India", "Indonesia", "Iran (Islamic Republic of)",
  "Iraq", "Ireland", "Israel", "Italy", "Jamaica", "Japan", "Jordan", "Kazakhstan", "Kenya", "Kiribati", "Korea, Democratic People's Republic of",
  "Korea, Republic of", "Kuwait", "Kyrgyzstan", "Lao, People's Democratic Republic", "Latvia", "Lebanon", "Lesotho", "Liberia",
  "Libyan Arab Jamahiriya", "Liechtenstein", "Lithuania", "Luxembourg", "Macau", "Macedonia, The Former Yugoslav Republic of",
  "Madagascar", "Malawi", "Malaysia", "Maldives", "Mali", "Malta", "Marshall Islands", "Martinique", "Mauritania", "Mauritius",
  "Mayotte", "Mexico", "Micronesia, Federated States of", "Moldova, Republic of", "Monaco", "Mongolia", "Montserrat", "Morocco",
  "Mozambique", "Myanmar", "Namibia", "Nauru", "Nepal", "Netherlands", "Netherlands Antilles", "New Caledonia", "New Zealand",
  "Nicaragua", "Niger", "Nigeria", "Niue", "Norfolk Island", "Northern Mariana Islands", "Norway", "Oman", "Pakistan", "Palau",
  "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines", "Pitcairn", "Poland", "Portugal", "Puerto Rico", "Qatar",
  "Reunion", "Romania", "Russian Federation", "Rwanda", "Saint Kitts and Nevis", "Saint Lucia", "Saint Vincent and the Grenadines",
  "Samoa", "San Marino", "Sao Tome and Principe", "Saudi Arabia", "Senegal", "Seychelles", "Sierra Leone", "Singapore",
  "Slovakia (Slovak Republic)", "Slovenia", "Solomon Islands", "Somalia", "South Africa", "South Georgia and the South Sandwich Islands",
  "Spain", "Sri Lanka", "St. Helena", "St. Pierre and Miquelon", "Sudan", "Suriname", "Svalbard and Jan Mayen Islands", "Swaziland",
  "Sweden", "Switzerland", "Syrian Arab Republic", "Taiwan, Province of China", "Tajikistan", "Tanzania, United Republic of",
  "Thailand", "Togo", "Tokelau", "Tonga", "Trinidad and Tobago", "Tunisia", "Turkey", "Turkmenistan", "Turks and Caicos Islands",
  "Tuvalu", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom", "United States", "United States Minor Outlying Islands",
  "Uruguay", "Uzbekistan", "Vanuatu", "Venezuela", "Vietnam", "Virgin Islands (British)", "Virgin Islands (U.S.)", "Wallis and Futuna Islands",
  "Western Sahara", "Yemen", "Yugoslavia", "Zambia", "Zimbabwe"];

  String _organization = "";
  String _jobTitle = "";
  String _website = "";

  String _facebookId = "";
  String _twitterId = "";
  String _shortProfile = "";

  String confirmationCode = '';
  String _code = "";

  FormType _form = FormType.login;
  var _currentTitleSelected = 'Alh.';
  var _currentCompanySectorSelected = 'Finance';
  var _currentCountrySelected = 'Nigeria';

  LoginState() {
    _emailFilter.addListener(_emailListen);
    _passwordFilter.addListener(_passwordListen);
    _phoneFilter.addListener(_phoneListen);
    _surnameFilter.addListener(_surnameListen);
    _firstnameFilter.addListener(_firstnameListen);
    _usernameFilter.addListener(_usernameListen);
    _organizationFilter.addListener(_organizationListen);
    _jobTitleFilter.addListener(_jobTitleListen);
    _facebookFilter.addListener(_facebookListen);
    _twitterFilter.addListener(_twitterListen);
    _websiteFilter.addListener(_websiteListen);
    _shortProfileFilter.addListener(_shortProfileListen);
    _codeFilter.addListener(_codeListen);
  }

  void _emailListen() {
    if (_emailFilter.text.isEmpty) {
      _email = "";
    } else {
      _email = _emailFilter.text;
    }
  }

  void _passwordListen() {
    if (_passwordFilter.text.isEmpty) {
      _password = "";
    } else {
      _password = _passwordFilter.text;
    }
  }

  void _phoneListen() {
    if (_phoneFilter.text.isEmpty) {
      _phone = "";
    } else {
      _phone = _phoneFilter.text;
    }
  }

  void _surnameListen() {
    if (_surnameFilter.text.isEmpty) {
      _surname = "";
    } else {
      _surname = _surnameFilter.text;
    }
  }

  void _firstnameListen() {
    if (_firstnameFilter.text.isEmpty) {
      _firstname = "";
    } else {
      _firstname = _firstnameFilter.text;
    }
  }

  void _usernameListen() {
    if (_usernameFilter.text.isEmpty) {
      _username = "";
    } else {
      _username = _usernameFilter.text;
    }
  }

  void _organizationListen() {
    if (_organizationFilter.text.isEmpty) {
      _organization = "";
    } else {
      _organization = _organizationFilter.text;
    }
  }

  void _jobTitleListen() {
    if (_jobTitleFilter.text.isEmpty) {
      _jobTitle = "";
    } else {
      _jobTitle = _jobTitleFilter.text;
    }
  }

  void _facebookListen() {
    if (_facebookFilter.text.isEmpty) {
      _facebookId = "";
    } else {
      _facebookId = _facebookFilter.text;
    }
  }

  void _twitterListen() {
    if (_twitterFilter.text.isEmpty) {
      _twitterId = "";
    } else {
      _twitterId = _twitterFilter.text;
    }
  }

  void _websiteListen() {
    if (_websiteFilter.text.isEmpty) {
      _website = "";
    } else {
      _website = _websiteFilter.text;
    }
  }

  void _shortProfileListen() {
    if (_shortProfileFilter.text.isEmpty) {
      _shortProfile = "";
    } else {
      _shortProfile = _shortProfileFilter.text;
    }
  }

  void _codeListen() {
    if (_codeFilter.text.isEmpty) {
      _code = "";
    } else {
      _code = _codeFilter.text;
    }
  }

// Swap in between our two forms, registering and logging in
  void _formChange () async {
    setState(() {
      if (_form == FormType.register) {
        formKey.currentState.reset();
        _form = FormType.login;
      } else if (_form == FormType.registerSocial) {
        formKey.currentState.reset();
        _form = FormType.login;
      }
      else {
        formKey.currentState.reset();
        _form = FormType.register;
      }
    });
  }

  @override
  void initState()
  {
    super.initState();

    signUpType = 'Individual';
  }

  setSignUpType(String val) {
    setState(() {
      signUpType = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334, allowFontScaling: true)..init(context);
    return Scaffold(
      key: global,
        appBar: _buildBar(context),
        body: new SingleChildScrollView(
          child: new Container(
//            margin: new EdgeInsets.all(5.0),
//            padding: EdgeInsets.all(16.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildTextFields(),
//                _buildButtons(),
              ],
            ),
          ),
        )
    );
  }

  Widget _buildBar(BuildContext context) {
    if (_form == FormType.login) {
      return new AppBar(
        backgroundColor: Color.fromRGBO(152, 160, 87, 1),
        title: new Text("Login"),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(
                Icons.check,
              color: Colors.white,
            ),
            onPressed: () {
              validateAndSubmit(context);
            },
          )
        ],
      );
    }
    else if (_form == FormType.register) {
      return new AppBar(
        backgroundColor: Color.fromRGBO(152, 160, 87, 1),
        title: new Text("Sign Up"),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(
              Icons.skip_next,
              color: Colors.white,
            ),
            onPressed: () {
              validateAndSave();
              setState(() {
                _form = FormType.registerSocial;
              });
            },
          )
        ],
      );
    }
    else if (_form == FormType.registerSocial){
      return new AppBar(
        backgroundColor: Color.fromRGBO(152, 160, 87, 1),
        title: new Text("Sign Up"),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(
              Icons.skip_previous,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _form = FormType.register;
              });
            },
          ),
          new IconButton(
            icon: new Icon(
              Icons.check,
              color: Colors.white,
            ),
            onPressed: () {
              validateAndSubmit(context);
            },
          ),
        ],
      );
    }
    else
    {
      return AppBar(
        backgroundColor: Color.fromRGBO(152, 160, 87, 1),
        title: new Text("Sign Up"),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(
              Icons.check,
              color: Colors.white,
            ),
            onPressed: () {
              _register();
            },
          ),
        ],
      );
    }
  }


  // Login and registration form
  Widget _buildTextFields() {
    if (_form == FormType.login) {
      return new Form(
        key: formKey,
        autovalidate: _autoValidate,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              height: MediaQuery.of(context).size.height,
              decoration: new BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment(0.8, 1.9), // 10% of the width, so there are ten blinds.
                  colors: [Colors.white, const Color.fromRGBO(180, 188, 151, 0.8)], // whitish to gray
                  tileMode: TileMode.repeated, // repeats the gradient over the canvas
                ),
              ),
              child: new Column(
                children: <Widget>[
                  new Container(
                    width: ScreenUtil.getInstance().setWidth(323),
                    height: ScreenUtil.getInstance().setWidth(323),
                    decoration: new BoxDecoration(
                        image: new DecorationImage(
                            image: new AssetImage(
                                'assets/images/logo/icpslogoTwo.png'
                            )
                        )
                    ),
                  ),
                  new Container(
                    margin: new EdgeInsets.all(10.0),
                    padding: new EdgeInsets.all(10.0),
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.circular(15.0)
                    ),
                    child: Column(
                      children: <Widget>[
                        new Container(
                          margin: new EdgeInsets.all(10.0),
                          child: new TextFormField(
                            focusNode: _usernameFocus,
                            textInputAction: TextInputAction.next,
                            controller: _usernameFilter,
                            decoration: new InputDecoration(
                              labelText: 'Username',
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(0.0),
                                child: Icon(
                                    Icons.person,
                                    color: Colors.grey,
                                )
                              )
//                              border: new OutlineInputBorder(
//                                  borderSide: new BorderSide(
//                                      color: Color.fromRGBO(53, 182, 134, 1),
//                                      width: 1.0
//                                  ),
//                                  borderRadius: BorderRadius.circular(5.0)
//                              ),
                            ),
                            autovalidate: _autoValidate,
                            validator: (value) => value.isEmpty ? 'Username can\'t be empty' : null,
                            onSaved: (value) => _username = value,
                            onFieldSubmitted: (term){
                              _fieldFocusChange(
                                  context, _usernameFocus, _passwordFocus);
                            },
                          ),
                        ),
                        new Container(
                          margin: new EdgeInsets.all(10.0),
                          child: new TextFormField(
                            focusNode: _passwordFocus,
                            textInputAction: TextInputAction.done,
                            controller: _passwordFilter,
                            decoration: new InputDecoration(
                              labelText: 'Password',
                                prefixIcon: Padding(
                                    padding: EdgeInsets.all(0.0),
                                    child: Icon(
                                      Icons.lock,
                                      color: Colors.grey,
                                    )
                                )
//                              border: new OutlineInputBorder(
//                                  borderSide: new BorderSide(
//                                      color: Color.fromRGBO(53, 182, 134, 1),
//                                      width: 1.0
//                                  ),
//                                  borderRadius: BorderRadius.circular(5.0)
//                              ),
                            ),
                            validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
                            obscureText: true,
                            onSaved: (value) => _password = value,
                            onFieldSubmitted: (term){
                              _passwordFocus.unfocus();
                              validateAndSubmit(context);
                            },
                          ),
                        ),
                        new Container(
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Container (
                                margin: new EdgeInsets.all(11.0),
                                width: MediaQuery.of(context).size.width,
                                decoration: new BoxDecoration(
                                    color: Color.fromRGBO(53, 182, 134, 1),
                                    borderRadius: new BorderRadius.circular(5.0)
                                ),
                                child: new FlatButton(
                                  child: new Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Icon(
                                        Icons.lock,
                                        color: Colors.white,
                                      ),
                                      new Text('Secure Login',
                                        style: new TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0
                                        ),
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                    validateAndSubmit(context);
                                  }
                                ),
                                alignment: Alignment.center,
                              ),
                              new FlatButton(
                                child: new Text('Don\'t have an account? Tap here to register.'),
                                onPressed: _formChange,
                              ),
                              new FlatButton(
                                child: new Text('Forgot Password?'),
                                onPressed: _passwordReset,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    } else if (_form == FormType.register) {
      return new Form(
        key: formKey,
        autovalidate: _autoValidate,
        child: new Column(
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(0.8, 1.9), // 10% of the width, so there are ten blinds.
                colors: [Colors.white, const Color.fromRGBO(180, 188, 151, 0.8)], // whitish to gray
                tileMode: TileMode.repeated, // repeats the gradient over the canvas
              ),
            ),
            child: new Column(
                children: <Widget>[
//                  new Container(
//                  width: ScreenUtil.getInstance().setWidth(123),
//                  height: ScreenUtil.getInstance().setWidth(123),
//                  decoration: new BoxDecoration(
//                      image: new DecorationImage(
//                          image: new AssetImage(
//                              'assets/images/logo/icpslogo.png'
//                          )
//                      )
//                  ),
//                ),
                  new Container (
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new Row(
                            children: <Widget>[
                              new Radio(
                                value: 'Individual',
                                groupValue: signUpType,
                                onChanged: (val) {
                                  setSignUpType(val);
                                },
                                activeColor: Color.fromRGBO(152, 160, 87, 1),

                              ),
                              new Text('Individual'),
                            ],
                          ),
                          new Row(
                            children: <Widget>[
                              new Radio(
                                value: 'Corporate Organization',
                                groupValue: signUpType,
                                onChanged: (val) {
                                  setSignUpType(val);
                                },
                                activeColor: Color.fromRGBO(152, 160, 87, 1),
                              ),
                              new Text('Corporate Organization'),
                            ],
                          ),
                        ],
                      )
                  ),
                  _chooseSignUpType (signUpType)
            ]
          )
        )

          ],
        ),
      );
    }
    else if (_form == FormType.registerSocial) {
      return new Form(
        key: formKey,
        autovalidate: _autoValidate,
        child: new Container(
          margin: new EdgeInsets.all(10.0),
          padding: new EdgeInsets.all(10.0),
          decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.circular(15.0)
          ),
          child: Column(
            children: <Widget>[
              new Container(
                margin: new EdgeInsets.all(10.0),
                child: new TextFormField(
                  focusNode: _facebookFocus,
                  textInputAction: TextInputAction.next,
                  controller: _facebookFilter,
                  decoration: new InputDecoration(
                      labelText: 'Facebook',
                      prefixIcon: Padding(
                          padding: EdgeInsets.all(0.0),
                          child: Icon(
                            FontAwesomeIcons.facebook,
                            color: Colors.grey,
                          )
                      )
//                              border: new OutlineInputBorder(
//                                  borderSide: new BorderSide(
//                                      color: Color.fromRGBO(53, 182, 134, 1),
//                                      width: 1.0
//                                  ),
//                                  borderRadius: BorderRadius.circular(5.0)
//                              ),
                  ),
//                  validator: (value) => value.isEmpty ? 'Facebook can\'t be empty' : null,
                  onSaved: (value) => _facebookId = value,
                  onFieldSubmitted: (term){
                    _fieldFocusChange(
                        context, _facebookFocus, _twitterFocus);
                  },
                ),
              ),
              new Container(
                margin: new EdgeInsets.all(10.0),
                child: new TextFormField(
                  focusNode: _twitterFocus,
                  textInputAction: TextInputAction.next,
                  controller: _twitterFilter,
                  decoration: new InputDecoration(
                      labelText: 'Twitter',
                      prefixIcon: Padding(
                          padding: EdgeInsets.all(0.0),
                          child: Icon(
                            FontAwesomeIcons.twitter,
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
//                  validator: (value) => value.isEmpty ? 'Organization Website can\'t be empty' : null,
                  onSaved: (value) => _twitterId = value,
                  onFieldSubmitted: (term){
                    _fieldFocusChange(
                        context, _twitterFocus, _websiteFocus);
                  },
                ),
              ),
              new Container(
                margin: new EdgeInsets.all(10.0),
                child: new TextFormField(
                  focusNode: _websiteFocus,
                  textInputAction: TextInputAction.next,
                  controller: _websiteFilter,
                  decoration: new InputDecoration(
                      labelText: 'Website',
                      prefixIcon: Padding(
                          padding: EdgeInsets.all(0.0),
                          child: Icon(
                            Icons.web,
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
//                  validator: (value) => value.isEmpty ? 'Organization Website can\'t be empty' : null,
                  onSaved: (value) => _website = value,
                  onFieldSubmitted: (term){
                    _fieldFocusChange(
                        context, _websiteFocus, _websiteFocus);
                  },
                ),
              ),
              new Container(
                margin: new EdgeInsets.all(10.0),
                child: new TextFormField(
                  focusNode: _shortProfileFocus,
                  textInputAction: TextInputAction.done,
                  controller: _shortProfileFilter,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: new InputDecoration(
                      labelText: 'Brief Profile',
                      prefixIcon: Padding(
                          padding: EdgeInsets.all(0.0),
                          child: Icon(
                            Icons.description,
                            color: Colors.grey,
                          )
                      )
//                              border: new OutlineInputBorder(
//                                  borderSide: new BorderSide(
//                                      color: Color.fromRGBO(53, 182, 134, 1),
//                                      width: 1.0
//                                  ),
//                                  borderRadius: BorderRadius.circular(5.0)
//                              ),
                  ),
                  validator: (value) => value.isEmpty ? 'Brief Profile can\'t be empty' : null,
                  onSaved: (value) => _shortProfile = value,
                  onFieldSubmitted: (term){
                    _shortProfileFocus.unfocus();
                    validateAndSubmit(context);
                  },
                ),
              ),
              new Container(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Container(
                      margin: new EdgeInsets.all(11.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: new BoxDecoration(
                          color: Color.fromRGBO(53, 182, 134, 1),
                          borderRadius: new BorderRadius.circular(5.0)
                      ),
                      child: new FlatButton(
                          child: new Text('Create an Account',
                            style: new TextStyle(
                                color: Colors.white,
                                fontSize: 16.0
                            ),
                          ),
                          onPressed: () {
                            validateAndSubmit(context);
                          }
                      ),
                    ),
                    new FlatButton(
                      child: new Text('Have an account? Click here to login.'),
                      onPressed: _formChange,
                    ),
//                    new FlatButton(
//                      child: new Text('Forgot Password?'),
//                      onPressed: _passwordReset,
//                    )
                    new Container(
                      padding: new EdgeInsets.only(left: 17.0, bottom: 3.0),
                      child: new Text('You must print confirmation ID to the event.'),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      );
    }
    else {
      return new Form(
        key: formKey,
        autovalidate: _autoValidate,
        child: new Column(
          children: <Widget>[
            new Container(
              margin: new EdgeInsets.all(10.0),
              child: new TextFormField(
//          focusNode: _jobTitleFocus,
                controller: _codeFilter,
                decoration: new InputDecoration(

                  labelText: 'Enter code here',
//              prefixIcon: Padding(
//                  padding: EdgeInsets.all(0.0),
//                  child: Icon(
//                    Icons.domain,
//                    color: Colors.grey,
//                  )
//              ),
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(
                          color: Color.fromRGBO(53, 182, 134, 1),
                          width: 1.0
                      ),
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                ),
//          autovalidate: _autoValidate,
                validator: validationCode,
                onSaved: (value) => _code = value,
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
                  child: new Text('Create an Account',
                    style: new TextStyle(
                        color: Colors.white,
                        fontSize: 16.0
                    ),
                  ),
                  onPressed: () {
                   _register();
                  }
              ),
            ),
            new FlatButton(
              child: new Text('Resend'),
              onPressed: () {
                _authenticate();
              },
            )
          ],
        )
      );
    }
  }

//  Widget _buildButtons() {
//    if (_form == FormType.login) {
//
//    } else {
//      return new Container(
//        child: new Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//            new Container(
//              margin: new EdgeInsets.all(11.0),
//              width: MediaQuery.of(context).size.width,
//              decoration: new BoxDecoration(
//                  color: Color.fromRGBO(53, 182, 134, 1),
//                  borderRadius: new BorderRadius.circular(5.0)
//              ),
//              child: new FlatButton(
//                child: new Text('Create an Account',
//                  style: new TextStyle(
//                      color: Colors.white,
//                      fontSize: 16.0
//                  ),
//                ),
//                onPressed: validateAndSubmit,
//              ),
//            ),
//            new FlatButton(
//              child: new Text('Have an account? Click here to login.'),
//              onPressed: _formChange,
//            )
//          ],
//        ),
//      );
//    }
//  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  String validationSurname (String value) {
    Pattern pattern = r'(^[a-zA-Z -]{1,})$';

    RegExp regex = new RegExp(pattern);

    if (value.length == 0)
      return 'Surname is Required';
    else if (!regex.hasMatch(value))
      return 'Enter Valid Surname';
    else
      return null;
  }

  String validationFirstName (String value) {
    Pattern pattern = r'(^[a-zA-Z -]{1,})$';

    RegExp regex = new RegExp(pattern);

    if (value.length == 0)
      return 'First Name is Required';
    else if (!regex.hasMatch(value))
      return 'Enter Valid First Name';
    else
      return null;
  }

  String validationUsername (String value) {
    Pattern pattern = r'(^[a-zA-Z0-9]+([a-zA-Z0-9](_|-| )[a-zA-Z0-9])*[a-zA-Z0-9])+$';

    RegExp regex = new RegExp(pattern);

    if (value.length == 0)
      return 'Username is Required';
    else if (!regex.hasMatch(value))
      return 'Enter Valid Username';
    else
      return null;
  }

  String validationEmail (String value) {
    Pattern pattern = r'(^(([^<>()[\]\\.,;:'
        r'\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]'
        r'{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+'
        r'[a-zA-Z]{2,})))$';

    RegExp regex = new RegExp(pattern);

    if (value.length == 0)
      return 'Email is Required';
    else if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  String validationPhone (String value) {
    Pattern pattern = r'(^(?:(?:\(?(?:00|\+)([1-4]\d\d|[1-9]\d?)\)?)?[\-\.\ '
        r'\\\/]?)?((?:\(?\d{1,}\)?[\-\.\ \\\/]?){0,})(?:[\-\.\ \\\/]?(?:#|ext\'
        r'.?|extension|x)[\-\.\ \\\/]?(\d+)))?$';

    RegExp regex = new RegExp(pattern);

    if (value.length == 0)
      return 'Phone Number is Required';
    else if (!regex.hasMatch(value))
      return 'Enter Valid Phone Number';
    else
      return null;
  }

  String validationOrganisation (String value) {
    Pattern pattern = r'(^[a-zA-Z -]{1,})$';

    RegExp regex = new RegExp(pattern);

    if (value.length == 0)
      return 'Organisation is Required';
    else if (!regex.hasMatch(value))
      return 'Enter Valid Organisation';
    else
      return null;
  }

  String validationJobTitle (String value) {
    Pattern pattern = r'(^[a-zA-Z -]{1,})$';

    RegExp regex = new RegExp(pattern);

    if (value.length == 0)
      return 'Job Title is Required';
    else if (!regex.hasMatch(value))
      return 'Enter Valid Job Title';
    else
      return null;
  }

  String validationCode (String value) {
//    Pattern pattern = r'(^[a-zA-Z ])*$';

//    RegExp regex = new RegExp(pattern);

    if (value.length == 0)
      return 'Confirmation Code is Required';
    else if (confirmationCode != value)
      return 'Enter Valid Confirmation Code';
    else
      return null;
  }

  bool validateAndSave () {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    else {
      setState(() {
        _autoValidate = true;
      });
      return false;
    }
  }

//  void _signedIn () {}
//
//  _launchURL(String toMailId, String subject, String body) async {
//    var url = 'mailto:$toMailId?subject=$subject&body=$body';
//    if (await canLaunch(url)) {
//      await launch(url);
//    } else {
//      throw 'Could not launch $url';
//    }
//  }

  void _generateConfirmationCode() {

    String phoneCharacter = _phone.trim().substring(_phone.length - 2, _phone.length - 1);

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

  void validateAndSubmit (BuildContext context) async {
    String sendUrl ='http://icps19.com:6060/icps/i/icps/19/urg';
    String findUrl ='http://icps19.com:6060/icps/i/icps/19/urp';
    //print('Form submitted');
    if (validateAndSave()) {
      try {
        Response response;
        Dio dio = new Dio();

        if (_form == FormType.login)
        {

          _showDialog(context, 'Logging In');

          Response response;
          Dio dio = new Dio();
          dio.options.connectTimeout = 500000;
          response = await dio.get(findUrl, queryParameters: {"username": _username, "password": _password});
          print(response.statusCode);

          Navigator.pop(context, (response.statusCode == 200 || response.statusCode == 401));

          if(response.statusCode == 200){
            print(UsersInfo.fromJson(response.data).surname);
            print(UsersInfo.fromJson(response.data).speakerYn);
            print(UsersInfo.fromJson(response.data).workPosition);

//            userSurname = UsersInfo.fromJson(response.data).surname;
//
//            userFirstname = UsersInfo.fromJson(response.data).firstname;
//
//            var data = Data (
//              surname: userSurname,
//              firstname: userFirstname
//            );

            var data = Data.fromUsersInfo(UsersInfo.fromJson(response.data));

            Fluttertoast.showToast(
                msg: "Login successful, please wait",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos: 6,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0
            );

            Future.delayed (Duration(seconds: 3),
                    () async {
                      Fluttertoast.showToast(
                          msg: "Redirecting",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIos: 6,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );

                      Future.delayed (Duration(seconds: 2),
                              () async {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => HomePage(data: data, password: _password))
                            );
                            print('5 seconds');
                          }
                      );
                }
            );
          }
          else if(response.statusCode == 401)
          {
            print('Something went wrong ${response.statusCode}');

            Fluttertoast.showToast(
                msg: "Something went wrong ${response.statusCode}",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos: 1,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0
            );

//            Toast.show("Something went wrong $response.statusCode", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
          }
//          print('Got response from server as $pp');
          //print(UsersInfo.fromJson(pp.data).surname);
        }
        else
        {
//          _authenticate();

          _register();

//          _showDialog(context, 'Registering');
//
//          response = await dio.post(sendUrl, queryParameters: {
//            "companysector": _currentCompanySectorSelected,
//            "conference_id": '',
//            "country": _currentCountrySelected,
//            "email": _email,
//            "facebook_id": _facebookId,
//            "firstname": _firstname,
//            "instagram_id": '',
//            "loginstatus": 'A',
//            "moderator_yn": false,
//            "organisation": _organization,
//            "participant_type": signUpType,
//            "password": _password,
//            "phone": _phone,
//            "pic_id": null,
//            "short_profile": _shortProfile,
//            "speaker_yn": false,
//            "surname": _surname,
//            "title": _currentTitleSelected,
//            "twitter_id": _twitterId,
////            "userinfoid": widget.user.id,
//            "username": _username,
//            "website": _website,
//            "work_position": _jobTitle,
//          },
//              options: Options(
//                headers: {
//                  HttpHeaders.contentTypeHeader: 'application/json',
//                  "accept": "application/json"
//                },)
//          );
//          print(response.statusCode);
//
//          Navigator.pop(context, (response.statusCode == 200 || response.statusCode == 401));
//
//          if (response.statusCode == 401)
//          {
//            Fluttertoast.showToast(
//                msg: "Oops, something went wrong, try again.",
//                toastLength: Toast.LENGTH_LONG,
//                gravity: ToastGravity.BOTTOM,
//                timeInSecForIos: 1,
//                backgroundColor: Colors.black,
//                textColor: Colors.white,
//                fontSize: 16.0
//            );
////            Toast.show("Oops, something went wrong, try again.", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
//          }
//          else
//          {
//            Fluttertoast.showToast(
//                msg: "Account created successfully, please wait",
//                toastLength: Toast.LENGTH_LONG,
//                gravity: ToastGravity.BOTTOM,
//                timeInSecForIos: 1,
//                backgroundColor: Colors.black,
//                textColor: Colors.white,
//                fontSize: 16.0
//            );
//
//            Future.delayed (Duration(seconds: 3),
//                    () async {
//                  Fluttertoast.showToast(
//                      msg: "Redirecting",
//                      toastLength: Toast.LENGTH_SHORT,
//                      gravity: ToastGravity.BOTTOM,
//                      timeInSecForIos: 6,
//                      backgroundColor: Colors.black,
//                      textColor: Colors.white,
//                      fontSize: 16.0
//                  );
//
//                  Future.delayed (Duration(seconds: 2),
//                          () async {
//                        Navigator.push(context,
//                            MaterialPageRoute(builder: (context) => HomePage())
//                        );
//                        print('5 seconds');
//                      }
//                  );
//                }
//            );
//          }
        }
//        widget.onSignedIn;
      }
      catch(e) {
        print('Error: $e');
      }
    }
  }

  _authenticate() async {
    _sendingCode(context);

    _generateConfirmationCode();

//    _launchURL(_email, 'ICPS 19 : Confirmation Code', 'Hey $_currentTitleSelected $_surname $_firstname,\n'
//        'We have received your application on our app.\nPlease enter this confirmation code to complete your registration\n'
//        'Confirmation code:\n $confirmationCode');

    String eusername = 'icps@centrifugegroup.com';
    String epassword = 'Precious@123';

//    final smtpServer = mailgun(eusername, epassword);

    // Create our message.


    String subject = 'ICPS 19 : Confirmation Code';

//    String body = 'Hey $_currentTitleSelected $_surname $_firstname,\n'
//        'We have received your application on our app.\nPlease enter this confirmation code to complete your registration process\n'
//        'Confirmation code:\n $confirmationCode';

//    final message = new Message()
//      ..from = new Address(eusername, 'ICPS 19')
//      ..recipients.add(new Address(_email))
////      ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
////      ..bccRecipients.add(new Address('bccAddress@example.com'))
//      ..subject = '$subject:: ${new DateTime.now()}'
////      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
//      ..html = "<h1>Hey $_currentTitleSelected $_surname $_firstname</h1>\n<p>We have received your application on our app</p>"
//          "<p>Please enter this confirmation code to complete your registration process</p> "
//          "<p>Confirmation code:\n <span style='color: #98A057;'>$confirmationCode</span></p>";
//
//    final sendReports = await send(message, smtpServer).then((message) => print('Email sent!'))
//        .catchError((e) => print('Error occurred: $e'));

    Future.delayed (Duration(seconds: 3),
            () async {
          Navigator.pop(context);
          print('Sending: 4 seconds');

          Future.delayed (Duration(seconds: 2),
                  () async {
                Fluttertoast.showToast(
                    msg: "Confirmation code sent, check your email.",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIos: 1,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
                print('5 seconds');
              }
          );

          Future.delayed (Duration(seconds: 2),
                  () async {
                setState(() {
                  _form = FormType.registerCode;
                });
                print('5 seconds');
              }
          );
        }
    );

//    Email email = Email(
//      body: body,
//      subject: subject,
//      recipients: [_email],
////      cc: ['cc@example.com'],
////      bcc: ['bcc@example.com'],
////      attachmentPath: '/path/to/attachment.zip',
//    );

//    await FlutterEmailSender.send(email);

  }

  Widget _chooseSignUpType (signUpType){
    if (signUpType == 'Individual'){
      return new Container(
          margin: new EdgeInsets.all(10.0),
          padding: new EdgeInsets.all(10.0),
          decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.circular(15.0)
          ),
          child: Column(
              children: <Widget>[
                new Container(
                    child: new Column (
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget> [
//                              new Container(
//                                margin: new EdgeInsets.only(top: 15.0, left: 20.0),
//                                child: new Text('Title',
//                                  style: new TextStyle(
//                                      fontSize: 16.0
//                                  ),
//                                ),
//                              ),
                          new Container(
                            margin: new EdgeInsets.all(10.0),
                            width: MediaQuery.of(context).size.width,
                            child: new InputDecorator(
                                decoration: InputDecoration(
                                    labelText: 'Title',
                                    prefixIcon: Padding(
                                        padding: EdgeInsets.all(0.0),
                                        child: Icon(
                                          Icons.title,
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
                                    hint: new Text('Title*'),
                                    items: _title.map((String dropDownStringItem) {
                                      return DropdownMenuItem<String> (
                                        value: dropDownStringItem,
                                        child: Text(dropDownStringItem),
                                      );
                                    }).toList(),
                                    onChanged: (String newValueSelected) {
                                      _onDropDownTitleSelected (newValueSelected);
                                    },
                                    value: _currentTitleSelected,
                                  ),
                                )
                            ),
//                                  )
                          ),
                        ]
                    )
                ),
                new Container(
                  margin: new EdgeInsets.all(10.0),
                  child: new TextFormField(
                    focusNode: _surnameFocus,
                    textInputAction: TextInputAction.next,
                    controller: _surnameFilter,
                    decoration: new InputDecoration(
                        labelText: 'Surname*',
                        prefixIcon: Padding(
                            padding: EdgeInsets.all(0.0),
                            child: Icon(
                              Icons.person,
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
                    autovalidate: _autoValidate,
                    validator: validationSurname,
                    onSaved: (value) => _surname = value,
                    onFieldSubmitted: (term){
                      _fieldFocusChange(
                          context, _surnameFocus, _firstnameFocus);
                    },
                  ),
                ),
                new Container(
                  margin: new EdgeInsets.all(10.0),
                  child: new TextFormField(
                    focusNode: _firstnameFocus,
                    textInputAction: TextInputAction.next,
                    controller: _firstnameFilter,
                    decoration: new InputDecoration(
                        labelText: 'First Name*',
                        prefixIcon: Padding(
                            padding: EdgeInsets.all(0.0),
                            child: Icon(
                              Icons.person,
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
                    autovalidate: _autoValidate,
                    validator: validationFirstName,
                    onSaved: (value) => _firstname = value,
                    onFieldSubmitted: (term){
                      _fieldFocusChange(
                          context, _firstnameFocus, _usernameFocus);
                    },
                  ),
                ),
                new Container(
                  margin: new EdgeInsets.all(10.0),
                  child: new TextFormField(
                    focusNode: _usernameFocus,
                    textInputAction: TextInputAction.next,
                    controller: _usernameFilter,
                    decoration: new InputDecoration(
                        labelText: 'Username*',
                        prefixIcon: Padding(
                            padding: EdgeInsets.all(0.0),
                            child: Icon(
                              Icons.person,
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
                    autovalidate: _autoValidate,
                    validator: (value) => value.isEmpty ? 'Username can\'t be empty' : null,
                    onSaved: (value) => _username = value,
                    onFieldSubmitted: (term){
                      _fieldFocusChange(
                          context, _usernameFocus, _emailFocus);
                    },
                  ),
                ),
                new Container(
                  margin: new EdgeInsets.all(10.0),
                  child: new TextFormField(
                    focusNode: _emailFocus,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailFilter,
                    decoration: new InputDecoration(
                        labelText: 'Your Email*',
                        prefixIcon: Padding(
                            padding: EdgeInsets.all(0.0),
                            child: Icon(
                              Icons.email,
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
                    autovalidate: _autoValidate,
                    validator: validationEmail,
                    onSaved: (value) => _email = value,
                    onFieldSubmitted: (term){
                      _fieldFocusChange(
                          context, _emailFocus, _phoneFocus);
                    },
                  ),
                ),
                new Container(
                  margin: new EdgeInsets.all(10.0),
                  child: new TextFormField(
                    focusNode: _phoneFocus,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    controller: _phoneFilter,
                    decoration: new InputDecoration(
                        labelText: 'Phone number*',
                        prefixIcon: Padding(
                            padding: EdgeInsets.all(0.0),
                            child: Icon(
                              Icons.phone,
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
                    autovalidate: _autoValidate,
                    validator: validationPhone,
                    onSaved: (value) => _phone = value,
                    onFieldSubmitted: (term){
                      _fieldFocusChange(
                          context, _phoneFocus, _passwordFocus);
                    },
                  ),
                ),
                new Container(
                  margin: new EdgeInsets.all(10.0),
                  child: new TextFormField(
                    focusNode: _passwordFocus,
                    textInputAction: TextInputAction.next,
                    controller: _passwordFilter,
                    decoration: new InputDecoration(
                        labelText: 'Password*',
                        prefixIcon: Padding(
                            padding: EdgeInsets.all(0.0),
                            child: Icon(
                              Icons.lock,
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
                    validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
                    obscureText: true,
                    onSaved: (value) => _password = value,
                    onFieldSubmitted: (term){
                      _fieldFocusChange(
                          context, _passwordFocus, _organisationFocus);
                    },
                  ),
                ),
                new Container(
                  margin: new EdgeInsets.all(10.0),
                  child: new TextFormField(
                    focusNode: _organisationFocus,
                    textInputAction: TextInputAction.next,
                    controller: _organizationFilter,
                    decoration: new InputDecoration(
                        labelText: 'Organization*',
                        prefixIcon: Padding(
                            padding: EdgeInsets.all(0.0),
                            child: Icon(
                              Icons.domain,
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
                    autovalidate: _autoValidate,
                    validator: validationOrganisation,
                    onSaved: (value) => _organization = value,
                    onFieldSubmitted: (term){
                      _fieldFocusChange(
                          context, _organisationFocus, _jobTitleFocus);
                    },
                  ),
                ),
                new Container(
                  margin: new EdgeInsets.all(10.0),
                  child: new TextFormField(
                    focusNode: _jobTitleFocus,
                    controller: _jobTitleFilter,
                    decoration: new InputDecoration(
                        labelText: 'Job Title*',
                        prefixIcon: Padding(
                            padding: EdgeInsets.all(0.0),
                            child: Icon(
                              Icons.domain,
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
                    autovalidate: _autoValidate,
                    validator: validationJobTitle,
                    onSaved: (value) => _jobTitle = value,
                  ),
                ),
                new Container(
                    child: new Column (
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget> [
//                              new Container(
//                                margin: new EdgeInsets.only(top: 15.0, left: 20.0),
//                                child: new Text('What sector is your company in?',
//                                  style: new TextStyle(
//                                      fontSize: 16.0
//                                  ),
//                                ),
//                              ),
                          new Container(
                            margin: new EdgeInsets.all(10.0),
                            width: MediaQuery.of(context).size.width,
                            child: new InputDecorator(
                                decoration: new InputDecoration(
                                    labelText: 'What sector is your company in?*',
                                    prefixIcon: Padding(
                                        padding: EdgeInsets.all(0.0),
                                        child: Icon(
                                          Icons.business_center,
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
                                    items: _companySector.map((String dropDownStringItem) {
                                      return DropdownMenuItem<String> (
                                        value: dropDownStringItem,
                                        child: Text(dropDownStringItem),
                                      );
                                    }).toList(),
                                    onChanged: (String newValueSelected) {
                                      _onDropDownCompanySectorSelected (newValueSelected);
                                    },
                                    value: _currentCompanySectorSelected,
                                  ),
                                )
                            ),
//                                  )
                          ),
                        ]
                    )
                ),
                new Container(
                    child: new Column (
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget> [
//                              new Container(
//                                margin: new EdgeInsets.only(top: 25.0, left: 20.0),
//                                child: new Text('Country',
//                                  style: new TextStyle(
//                                      fontSize: 16.0
//                                  ),
//                                ),
//                              ),
                          new Container(
                              margin: new EdgeInsets.all(10.0),
                              width: MediaQuery.of(context).size.width,
                              child: new InputDecorator(
                                  decoration: new InputDecoration(
                                      labelText: 'Country*',
                                      prefixIcon: Padding(
                                          padding: EdgeInsets.all(0.0),
                                          child: Icon(
                                            Icons.public,
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
                                      items: _country.map((String dropDownStringItem) {
                                        return DropdownMenuItem<String> (
                                          value: dropDownStringItem,
                                          child: Text(dropDownStringItem),
                                        );
                                      }).toList(),
                                      onChanged: (String newValueSelected) {
                                        _onDropDownCountrySelected (newValueSelected);
                                      },
                                      value: _currentCountrySelected,
                                    ),
                                  )
//                                    ),
                              )
                          ),
                        ]
                    )
                ),
                new Container(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Container(
                        margin: new EdgeInsets.all(11.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: new BoxDecoration(
                            color: Color.fromRGBO(53, 182, 134, 1),
                            borderRadius: new BorderRadius.circular(5.0)
                        ),
                        child: new FlatButton(
                          child: new Text('Next',
                            style: new TextStyle(
                                color: Colors.white,
                                fontSize: 16.0
                            ),
                          ),
                          onPressed: () {
//                            validateAndSubmit(context);
                            validateAndSave();
                            setState(() {
                              _form = FormType.registerSocial;
                            });
                          }
                        ),
                      ),
                      new FlatButton(
                        child: new Text('Have an account? Click here to login.'),
                        onPressed: _formChange,
                      ),
                      new Container(
                        padding: new EdgeInsets.only(left: 17.0, bottom: 3.0),
                        child: new Text('You must print confirmation ID to the event.'),
                      )
                    ],
                  ),
                )
              ]
          )
      );
    }
    else {
      return new Container(
          margin: new EdgeInsets.all(10.0),
          padding: new EdgeInsets.all(10.0),
          decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.circular(15.0)
          ),
          child: Column(
              children: <Widget>[
                new Container(
                  margin: new EdgeInsets.all(10.0),
                  child: new TextFormField(
                    focusNode: _organisationFocus,
                    textInputAction: TextInputAction.next,
                    controller: _organizationFilter,
                    decoration: new InputDecoration(
                        labelText: 'Organization*',
                        prefixIcon: Padding(
                            padding: EdgeInsets.all(0.0),
                            child: Icon(
                              Icons.domain,
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
                    autovalidate: _autoValidate,
                    validator: validationOrganisation,
                    onSaved: (value) => _organization = value,
                    onFieldSubmitted: (term){
                      _fieldFocusChange(
                          context, _organisationFocus, _usernameFocus);
                    },
                  ),
                ),
                new Container(
                  margin: new EdgeInsets.all(10.0),
                  child: new TextFormField(
                    focusNode: _usernameFocus,
                    textInputAction: TextInputAction.next,
                    controller: _usernameFilter,
                    decoration: new InputDecoration(
                        labelText: 'Username*',
                        prefixIcon: Padding(
                            padding: EdgeInsets.all(0.0),
                            child: Icon(
                              Icons.person,
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
                    autovalidate: _autoValidate,
                    validator: validationUsername,
                    onSaved: (value) => _username = value,
                    onFieldSubmitted: (term){
                      _fieldFocusChange(
                          context, _usernameFocus, _emailFocus);
                    },
                  ),
                ),
                new Container(
                  margin: new EdgeInsets.all(10.0),
                  child: new TextFormField(
                    focusNode: _emailFocus,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailFilter,
                    decoration: new InputDecoration(
                        labelText: 'Your Email*',
                        prefixIcon: Padding(
                            padding: EdgeInsets.all(0.0),
                            child: Icon(
                              Icons.email,
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
                    autovalidate: _autoValidate,
                    validator: validationEmail,
                    onSaved: (value) => _email = value,
                    onFieldSubmitted: (term){
                      _fieldFocusChange(
                          context, _emailFocus, _phoneFocus);
                    },
                  ),
                ),
                new Container(
                  margin: new EdgeInsets.all(10.0),
                  child: new TextFormField(
                    focusNode: _phoneFocus,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    controller: _phoneFilter,
                    decoration: new InputDecoration(
                        labelText: 'Phone number*',
                        prefixIcon: Padding(
                            padding: EdgeInsets.all(0.0),
                            child: Icon(
                              Icons.phone,
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
                    autovalidate: _autoValidate,
                    validator: validationPhone,
                    onSaved: (value) => _phone = value,
                    onFieldSubmitted: (term){
                      _fieldFocusChange(
                          context, _phoneFocus, _passwordFocus);
                    },
                  ),
                ),
                new Container(
                  margin: new EdgeInsets.all(10.0),
                  child: new TextFormField(
                    focusNode: _passwordFocus,
                    controller: _passwordFilter,
                    decoration: new InputDecoration(
                        labelText: 'Password*',
                        prefixIcon: Padding(
                            padding: EdgeInsets.all(0.0),
                            child: Icon(
                              Icons.lock,
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
                    validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
                    obscureText: true,
                    onSaved: (value) => _password = value,
                  ),
                ),
                new Container(
                    child: new Column (
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget> [
//                              new Container(
//                                margin: new EdgeInsets.only(top: 15.0, left: 20.0),
//                                child: new Text('What sector is your company in?',
//                                  style: new TextStyle(
//                                      fontSize: 16.0
//                                  ),
//                                ),
//                              ),
                          new Container(
                            margin: new EdgeInsets.all(10.0),
                            width: MediaQuery.of(context).size.width,
                            child: new InputDecorator(
                                decoration: new InputDecoration(
                                    labelText: 'What sector is your company in?*',
                                    prefixIcon: Padding(
                                        padding: EdgeInsets.all(0.0),
                                        child: Icon(
                                          Icons.business_center,
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
                                    items: _companySector.map((String dropDownStringItem) {
                                      return DropdownMenuItem<String> (
                                        value: dropDownStringItem,
                                        child: Text(dropDownStringItem),
                                      );
                                    }).toList(),
                                    onChanged: (String newValueSelected) {
                                      _onDropDownCompanySectorSelected (newValueSelected);
                                    },
                                    value: _currentCompanySectorSelected,
                                  ),
                                )
                            ),
//                                  )
                          ),
                        ]
                    )
                ),new Container(
                    child: new Column (
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget> [
//                              new Container(
//                                margin: new EdgeInsets.only(top: 25.0, left: 20.0),
//                                child: new Text('Country',
//                                  style: new TextStyle(
//                                      fontSize: 16.0
//                                  ),
//                                ),
//                              ),
                          new Container(
                              margin: new EdgeInsets.all(10.0),
                              width: MediaQuery.of(context).size.width,
                              child: new InputDecorator(
                                  decoration: new InputDecoration(
                                      labelText: 'Country*',
                                      prefixIcon: Padding(
                                          padding: EdgeInsets.all(0.0),
                                          child: Icon(
                                            Icons.public,
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
                                      items: _country.map((String dropDownStringItem) {
                                        return DropdownMenuItem<String> (
                                          value: dropDownStringItem,
                                          child: Text(dropDownStringItem),
                                        );
                                      }).toList(),
                                      onChanged: (String newValueSelected) {
                                        _onDropDownCountrySelected (newValueSelected);
                                      },
                                      value: _currentCountrySelected,
                                    ),
                                  )
//                                    ),
                              )
                          ),
                        ]
                    )
                ),
                new Container(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Container(
                        margin: new EdgeInsets.all(11.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: new BoxDecoration(
                            color: Color.fromRGBO(53, 182, 134, 1),
                            borderRadius: new BorderRadius.circular(5.0)
                        ),
                        child: new FlatButton(
                          child: new Text('Next',
                            style: new TextStyle(
                                color: Colors.white,
                                fontSize: 16.0
                            ),
                          ),
                          onPressed: () {
//                            validateAndSubmit(context);
                            validateAndSave();
                            setState(() {
                              _form = FormType.registerSocial;
                            });
                          }
                        ),
                      ),
                      new FlatButton(
                        child: new Text('Have an account? Click here to login.'),
                        onPressed: _formChange,
                      ),
                      new Container(
                        padding: new EdgeInsets.only(left: 17.0, bottom: 3.0),
                        child: new Text('You must print confirmation ID to the event.'),
                      )
                    ],
                  ),
                )
              ]
          )
      );
    }
  }

  void _register() async {

//    if (confirmationCode == _code) {
      Response response;
      Dio dio = new Dio();
      String sendUrl ='http://icps19.com:6060/icps/i/icps/19/urg';
      _showDialog(context, 'Registering');

      response = await dio.post(sendUrl, queryParameters: {
        "companysector": _currentCompanySectorSelected,
        "conference_id": confirmationCode,
        "country": _currentCountrySelected,
        "email": _email,
        "facebook_id": _facebookId,
        "firstname": _firstname,
        "instagram_id": '',
        "loginstatus": 'A',
        "moderator_yn": false,
        "organisation": _organization,
        "participant_type": signUpType,
        "password": _password,
        "phone": _phone,
        "pic_id": null,
        "short_profile": _shortProfile,
        "speaker_yn": false,
        "surname": _surname,
        "title": _currentTitleSelected,
        "twitter_id": _twitterId,
//            "userinfoid": widget.user.id,
        "username": _username,
        "website": _website,
        "work_position": _jobTitle,
      },
          options: Options(
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              "accept": "application/json"
            },)
      );
      print(response.statusCode);

      Navigator.pop(context, (response.statusCode == 200 || response.statusCode == 401));

      if (response.statusCode == 401)
      {
        Fluttertoast.showToast(
            msg: "Oops, something went wrong, try again.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );
//            Toast.show("Oops, something went wrong, try again.", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      }
      else {
        Fluttertoast.showToast(
            msg: "Account created successfully, please wait",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );

        Future.delayed(Duration(seconds: 0),
                () async {
//            Fluttertoast.showToast(
//                msg: "Redirecting",
//                toastLength: Toast.LENGTH_SHORT,
//                gravity: ToastGravity.BOTTOM,
//                timeInSecForIos: 6,
//                backgroundColor: Colors.black,
//                textColor: Colors.white,
//                fontSize: 16.0
//            );

              Future.delayed(Duration(seconds: 2),
                      () async {
                    String findUrl = 'http://icps19.com:6060/icps/i/icps/19/urp';
                    dio.options.connectTimeout = 50000;
                    response = await dio.get(findUrl, queryParameters: {
                      "username": _username,
                      "password": _password
                    });
                    print(response.statusCode);

                    Navigator.pop(context, (response.statusCode == 200 ||
                        response.statusCode == 401));

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

                      var data = Data.fromUsersInfo(
                          UsersInfo.fromJson(response.data));

                      Fluttertoast.showToast(
                          msg: "Login successful, please wait",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIos: 6,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );

                      Future.delayed(Duration(seconds: 3),
                              () async {
                            Fluttertoast.showToast(
                                msg: "Redirecting",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIos: 6,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );

                            Future.delayed(Duration(seconds: 2),
                                    () async {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) =>
                                          HomePage(
                                              data: data, password: _password))
                                  );
                                  print('5 seconds');
                                }
                            );
                          }
                      );
                    }
                    else if (response.statusCode == 401) {
                      print('Something went wrong $response.statusCode');

                      Fluttertoast.showToast(
                          msg: "Something went wrong $response.statusCode",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIos: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );

//            Toast.show("Something went wrong $response.statusCode", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                    }
                    print('5 seconds');
                  }
              );
            }
        );
      }
//    }
//    else {
//      Fluttertoast.showToast(
//          msg: "Incorrect Confirmation code try again",
//          toastLength: Toast.LENGTH_LONG,
//          gravity: ToastGravity.BOTTOM,
//          timeInSecForIos: 1,
//          backgroundColor: Colors.black,
//          textColor: Colors.white,
//          fontSize: 16.0
//      );
//    }
  }

//  void _loginToast(BuildContext context) {
//    final scaffold = Scaffold.of(context);
//    scaffold.showSnackBar(
//      SnackBar(
//        content: const Text('Login successful.'),
//        action: SnackBarAction(
//            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
//      ),
//    );
//  }

  void _passwordReset () {
    print("The user wants a password reset request sent to $_email");
  }

  void _onDropDownTitleSelected (String newValueSelected)
  {
    setState(() {
      this._currentTitleSelected = newValueSelected;
    });
  }

  void _onDropDownCompanySectorSelected (String newValueSelected)
  {
    setState(() {
      this._currentCompanySectorSelected = newValueSelected;
    });
  }

  void _onDropDownCountrySelected (String newValueSelected)
  {
    setState(() {
      this._currentCountrySelected = newValueSelected;
    });
  }

  void _showDialog (BuildContext context, String formProcess)
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
              Text (formProcess,
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

  void _sendingCode (BuildContext context)
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
              Text ('Sending email',
                style: new TextStyle (
                    color: Colors.white
                ),
              ),
              SizedBox(
                height: 7.0,
              ),
              new Text('Check your email',
                style: new TextStyle (
                    color: Colors.white
                ),
              ),
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

  void _authenticationDialog (BuildContext context)
  {
    var alertDialog = AlertDialog(
      title: new Text('Confirmation Code'),
      content: new Form(
        key: formKey,
        child: new Container(
          margin: new EdgeInsets.all(10.0),
          child: new TextFormField(
//          focusNode: _jobTitleFocus,
            controller: _codeFilter,
            decoration: new InputDecoration(

              labelText: 'Enter code here',
//              prefixIcon: Padding(
//                  padding: EdgeInsets.all(0.0),
//                  child: Icon(
//                    Icons.domain,
//                    color: Colors.grey,
//                  )
//              ),
              border: new OutlineInputBorder(
                  borderSide: new BorderSide(
                      color: Color.fromRGBO(53, 182, 134, 1),
                      width: 1.0
                  ),
                  borderRadius: BorderRadius.circular(5.0)
              ),
            ),
//          autovalidate: _autoValidate,
            validator: (value) => value.isEmpty ? 'Confirmation code can\'t be empty' : null,
            onSaved: (value) => _code = value,
          ),
        ),
      ),
      actions: <Widget>[
        new FlatButton(
          child: new Text('Resend'),
          onPressed: () {
            _authenticate();
          },
        ),
        new FlatButton(
          child: new Text('Submit'),
          onPressed: () async {
            if (validateAndSave()) {
              if (_code == confirmationCode) {

                _register();
              }
            }
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


class Data
{
  int id;
  String surname;
  String firstname;
  bool speaker;
  String companysector;
  dynamic conferenceId;
  String country;
  String email;
  String facebookId;
  dynamic instagramId;
  String loginstatus;
  bool moderatorYn;
  String organisation;
  dynamic participantType;
  String password;
  String phone;
  String picId;
  String shortProfile;
  String title;
  String twitterId;
  String username;
  String website;
  dynamic workPosition;
  int userinfoid;

  Data ({this.id = 0, this.surname = '', this.firstname = '', this.speaker = false, this.companysector = '',
          this.conferenceId = '', this.country = '', this.email = '', this.facebookId = '', this.instagramId = '',
          this.loginstatus = 'A', this.moderatorYn = false, this.organisation = '', this.participantType = '',
          this.password = '', this.phone = '', this.picId = '', this.shortProfile = '', this.title = '',
          this.twitterId = '', this.username = '', this.website = '', this.workPosition = '', this.userinfoid = 0
        });

  factory Data.fromUsersInfo(UsersInfo info)
  {
    return Data (
             id: info.userinfoid,
      firstname: info.firstname,
        surname: info.surname,
        speaker: info.speakerYn,
        conferenceId: info.conferenceId,
        companysector: info.companysector,
        country: info.country,
        email: info.email,
        facebookId: info.facebookId,
        instagramId: info.instagramId,
        loginstatus: info.loginstatus,
        moderatorYn: info.moderatorYn,
        organisation: info.organisation,
        participantType: info.participantType,
        phone: info.phone,
        picId: info.picId,
        shortProfile: info.shortProfile,
        title: info.title,
        twitterId: info.twitterId,
        username: info.username,
        website: info.website,
        workPosition: info.workPosition,
        userinfoid: info.userinfoid
    );
  }
}

