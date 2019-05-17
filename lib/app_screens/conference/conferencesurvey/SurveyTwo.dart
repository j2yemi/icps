import 'package:flutter/material.dart';

class SurveyTwo extends StatefulWidget {
  @override
  _SurveyTwoState createState() => _SurveyTwoState();
}

class _SurveyTwoState extends State<SurveyTwo> {

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
                    child: new Text('What were your greatest take-aways from the event?',
                      style: new TextStyle(
                        fontSize: 20.0
                      ),
                    ),
                  ),
                  new Container(
                    margin: new EdgeInsets.only(top: 10.0, left: 20.0),
                    child: new Text('Please enter an answer up to [500] characters.',
                      style: new TextStyle(
                        color: Colors.grey
                      ),
                    ),
                  ),
                  new Container(
                    margin: new EdgeInsets.only(left: 20.0, right: 20.0),
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      maxLines: 4,
                      decoration: new InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2.0)
                        )
                      ),
                    )
                  ),
                ]
            )
            ),
            new Container(
              child: new Column (
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget> [
                  new Container(
                    margin: new EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0),
                    child: new Text('Please provide suggestions for improving our future events',
                      style: new TextStyle(
                        fontSize: 20.0
                      ),
                    ),
                  ),
                  new Container(
                    margin: new EdgeInsets.only(top: 10.0, left: 20.0),
                    child: new Text('Please enter an answer up to [500] characters.',
                      style: new TextStyle(
                        color: Colors.grey
                      ),
                    ),
                  ),
                  new Container(
                    margin: new EdgeInsets.only(left: 20.0, right: 20.0),
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      maxLines: 4,
                      decoration: new InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2.0)
                        )
                      ),
                    )
                  ),
                ]
              )
            ),
            new Center(
              child: new Container(
                margin: new EdgeInsets.only(top: 20.0),
                color: Color.fromRGBO (53, 182, 134, 1),
                child: FlatButton(
                  child: Text('Finish',
                    style: new TextStyle(
                      color: Colors.white
                    ),
                  ),
                  onPressed: () {

                  },
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}
