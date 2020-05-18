import 'dart:ui';

import 'package:flutter/material.dart';


class Prediction extends StatefulWidget {
  Prediction({this.image,this.label});
  final String image ;
  final String label ;
  @override
  _PredictionState createState() => new _PredictionState();
}

class _PredictionState extends State<Prediction> {
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body:new Container(
          child: new SingleChildScrollView(
            child: new ConstrainedBox(
              constraints: new BoxConstraints(),
              child: new Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        height: 50.0,
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(
                                40.0, 35.0, 15.0, 10.0
                            ),
                            child: Material(
                              borderRadius: BorderRadius.circular(
                                  25.0
                              ),
                            ),
                          ),
                          SizedBox(
                              height: 15.0
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 15.0
                            ),
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 10.0
                              ),
                              decoration: BoxDecoration(
                                  border: Border(
                                      left: BorderSide(
                                          color: Colors.green,
                                          style: BorderStyle.solid,
                                          width: 3.0
                                      )
                                  )
                              ),
                              child: Row(

                              ),
                            ),
                          ),

                        ],
                      )
                    ],
                  ),

                  SizedBox(
                      height: 40.0
                  ),
                  Stack(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            left: 12.0, right: 12.0
                        ),
                        child: Container(
                          height: 400.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  15.0
                              ),
                              image: DecorationImage(
                                  image: AssetImage(
                                      widget.image
                                  ), fit: BoxFit.cover
                              )
                          ),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                                sigmaX: 0, sigmaY: 0
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(
                                      0.0
                                  )
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(
                              top: 30.0, left: 40.0
                          ),
                      )
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.only(
                          top: 40.0, left: 40.0
                      ),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                              height: 35.0
                          ),
                          Text(
                            widget.label,
                            style: TextStyle(
                              fontFamily: 'Timesroman',
                              fontSize: 30.0,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      )
                  ),
                  SizedBox(
                      height: 90.0
                  ),
                  FloatingActionButton(
                    tooltip: 'return',
                    child: Icon(
                        Icons.arrow_forward, color: Color(0xff01A0C7)
                    ),
                    backgroundColor: Colors.white,
                    onPressed: () {},
                  ),
                ],

              ),
            ),
          ),
        )
    );
  }


}
