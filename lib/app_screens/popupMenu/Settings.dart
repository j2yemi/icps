import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  bool val = false;

  onSwitchValueChanged (bool newVal) {
    setState(() {
      val = newVal;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance =
    ScreenUtil(width: 750, height: 1334, allowFontScaling: true)
      ..init(context);
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(152, 160, 87, 1),
        title: new Text("Settings"),
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
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            new Container(
              margin: new EdgeInsets.only(top: 23.0, left: 23.0, right: 23.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Container(
                    child: new Text('Notifications',
                      style: new TextStyle(
                        fontSize: ScreenUtil(allowFontScaling: true)
                            .setSp(38),
                      ),
                    ),
                  ),
                  Switch(
                    value: val,
                    activeColor: Color.fromRGBO(152, 160, 87, 1),
                    onChanged: (newVal) {
                      onSwitchValueChanged(newVal);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
