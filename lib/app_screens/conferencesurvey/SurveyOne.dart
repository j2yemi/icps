import 'package:flutter/material.dart';

class SurveyOne extends StatefulWidget {
  @override
  _SurveyOneState createState() => _SurveyOneState();
}

class _SurveyOneState extends State<SurveyOne> {

  var _satisfaction = ['Very Satisfied', 'Somewhat Satisfied', 'Neutral', 'Somewhat Dissatisfied', 'Very Dissatisfied'];
  var _currentSatisfactionSelected = 'Very Satisfied';
  var _recommend = ['Quite Likely', 'Maybe', 'Not Likely'];
  var _currentRecommendSelected = 'Quite Likely';

  bool _value1 = false;
  bool _value2 = false;
  bool _value3 = false;
  bool _value4 = false;

  void _value1Changed(bool value) => setState(() => _value1 = value);
  void _value2Changed(bool value) => setState(() => _value2 = value);
  void _value3Changed(bool value) => setState(() => _value3 = value);
  void _value4Changed(bool value) => setState(() => _value4 = value);


  @override
  Widget build(BuildContext context) {
    return new SingleChildScrollView(
      child: Container(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              child: new Column (
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget> [
                  new Container(
                    margin: new EdgeInsets.only(top: 25.0, left: 20.0),
                    child: new Text('How satisfied are you with the event?',
                      style: new TextStyle(
                        fontSize: 20.0
                      ),
                    ),
                  ),
                  new Container(
                    margin: new EdgeInsets.only(left: 20.0, right: 20.0),
                    width: MediaQuery.of(context).size.width,
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        items: _satisfaction.map((String dropDownStringItem) {
                          return DropdownMenuItem<String> (
                            value: dropDownStringItem,
                            child: Text(dropDownStringItem),
                          );
                        }).toList(),
                        onChanged: (String newValueSelected) {
                          _onDropDownSatisfactionSelected (newValueSelected);
                        },
                        value: _currentSatisfactionSelected,
                      ),
                    )
                      ),
                    ]
                )
            ),
            new Container(
              child: new Column (
                children: <Widget> [
                  new Container(
                    margin: new EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0),
                    child: new Text('How likely are you to recommend this event?',
                      style: new TextStyle(
                        fontSize: 20.0
                      ),
                    ),
                  ),
                  new Container(
                    margin: new EdgeInsets.only(left: 20.0, right: 20.0),
                    width: MediaQuery.of(context).size.width,
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        items: _recommend.map((String dropDownStringItem) {
                          return DropdownMenuItem<String> (
                            value: dropDownStringItem,
                            child: Text(dropDownStringItem),
                          );
                        }).toList(),
                        onChanged: (String newValueSelected) {
                          _onDropDownRecommendSelected (newValueSelected);
                        },
                        value: _currentRecommendSelected,
                      ),
                    )
                      ),
                    ]
                )
            ),
            new Container(
              child: new Column (
                children: <Widget> [
                  new Container(
                    margin: new EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0),
                    child: new Text('Why did you attend out event? Select all that apply.',
                      style: new TextStyle(
                        fontSize: 20.0
                      ),
                    ),
                  ),
                  new Container(
                    margin: new EdgeInsets.only(left: 10.0, right: 10.0),
                    width: MediaQuery.of(context).size.width,
                    child: new Column(
                      children: <Widget>[
                        new CheckboxListTile(
                          value: _value1,
                          onChanged: _value1Changed,
                          title: new Text('For Networking'),
                          controlAffinity: ListTileControlAffinity.leading,
                          activeColor: Color.fromRGBO(25, 110, 42, 1),
                        ),
                        new CheckboxListTile(
                          value: _value2,
                          onChanged: _value2Changed,
                          title: new Text('Interest in event topic'),
                          controlAffinity: ListTileControlAffinity.leading,
                          activeColor: Color.fromRGBO(25, 110, 42, 1),
                        ),
                        new CheckboxListTile(
                          value: _value3,
                          onChanged: _value3Changed,
                          title: new Text('To support the organization'),
                          controlAffinity: ListTileControlAffinity.leading,
                          activeColor: Color.fromRGBO(25, 110, 42, 1),
                        ),
                        new CheckboxListTile(
                          value: _value4,
                          onChanged: _value4Changed,
                          title: new Text('You know the organizers or participants'),
                          controlAffinity: ListTileControlAffinity.leading,
                          activeColor: Color.fromRGBO(25, 110, 42, 1),
                        ),
                      ],
                    )
                      ),
                    ]
                )
            ),
          ],
        ),
      ),
    );
  }

  void _onDropDownSatisfactionSelected (String newValueSelected)
  {
    setState(() {
      this._currentSatisfactionSelected = newValueSelected;
    });
  }

  void _onDropDownRecommendSelected (String newValueSelected)
  {
    setState(() {
      this._currentRecommendSelected = newValueSelected;
    });
  }
}
