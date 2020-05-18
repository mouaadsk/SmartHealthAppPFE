import 'package:flutter/material.dart';
import 'package:smarthealth/RootPage.dart';
import 'package:smarthealth/FireAuth.dart';

class FocusVisibilityDemo extends StatefulWidget {
  @override
  _FocusVisibilityDemoState createState() => new _FocusVisibilityDemoState();
}
class Age_Gender extends StatefulWidget {
  @override
  _Age_GenderState createState() => new _Age_GenderState();
}
class Height_Weight extends StatefulWidget {
  @override
  _Height_WeightState createState() => new _Height_WeightState();
}
class Disease extends StatefulWidget {
  @override
  _DiseaseState createState() => new _DiseaseState();
}

class _FocusVisibilityDemoState extends State<FocusVisibilityDemo> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Text Dialog')),
      body: new Center(
        child: new RaisedButton(
          onPressed: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) => new Age_Gender()));
          },
          child: new Text("Push Me"),
        ),
      ),
    );
  }


}


class _Height_WeightState extends State<Height_Weight> {
  @override
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {

    final WeightField = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Weight",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final HeightField = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Height",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(42.0,0,42.0,0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 5.0),
                WeightField,
                SizedBox(height: 25.0),
                HeightField,
                SizedBox(
                  height: 55.0,
                ),
                SizedBox(
                  height: 135.0,
                ),
                Container(
                  margin: const EdgeInsets.only( left: 280.0, top:0.0 , bottom:50.0),
                  child: new FloatingActionButton(
                    tooltip: 'Next',
                    child: Icon(Icons.arrow_forward, color: Color(0xff01A0C7)),
                    backgroundColor: Colors.white,
                    onPressed: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) => new Disease()));
                  },
                )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


}



class _Age_GenderState extends State<Age_Gender> {
  @override
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {

    final AgeField = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Age",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final GenderField = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Gender",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(42.0,0,42.0,0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 5.0),
                AgeField,
                SizedBox(height: 25.0),
                GenderField,
                SizedBox(
                  height: 55.0,
                ),
                SizedBox(
                  height: 135.0,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 280.0, top:0.0 , bottom:50.0),
                  child: new FloatingActionButton(
                    tooltip: 'Next',
                    child: Icon(Icons.arrow_forward, color: Color(0xff01A0C7)),
                    backgroundColor: Colors.white,
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) => new Height_Weight()));
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


}


















class _DiseaseState extends State<Disease> {
  @override
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);


  final int _bmi = 45;
  String _obesity="";


  void _showDialog() {
    if(_bmi<19)
    {
      _obesity="Underweight !! ";
    }
    else if(_bmi>19 && _bmi<24)
    {
      _obesity="Normal!! ";
    }
    else if(_bmi>24 && _bmi<29)
    {
      _obesity="Overweight !! ";
    }
    else if(_bmi>29 && _bmi<39)
    {
      _obesity="Underweight !! ";
    }
    else if(_bmi>39 && _bmi<40)
    {
      _obesity="Obese !! ";
    }
    else if(_bmi>40)
    {
      _obesity="Extreme Obesity !! ";
    }
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: new Text(_obesity+"\n\nLet us help you in  your weight loss journey.\nHere you will find plenty of healthy meals",style: TextStyle(
              fontFamily: 'Timesroman',
              fontSize: 28.0,
              color: Colors.black,
              fontWeight: FontWeight.bold),),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Let's Go !",style: TextStyle(
                fontFamily: 'Timesroman',
                fontSize: 17.0,
                color: Color(0xff01A0C7),),),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) => new RootPage(auth: FireAuth(),)));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    final DiseaseField = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Disease",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(42.0,0,42.0,0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 5.0),
                SizedBox(height: 25.0),
                DiseaseField,
                SizedBox(
                  height: 55.0,
                ),
                SizedBox(
                  height: 135.0,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 280.0, top:0.0 , bottom:50.0),
                  child: new FloatingActionButton(
                    tooltip: 'Next',
                    child: Icon(Icons.arrow_forward, color: Color(0xff01A0C7)),
                    backgroundColor: Colors.white,
                    onPressed: _showDialog,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


}
