import 'package:flutter/material.dart';
import 'dart:async';
import 'package:smarthealth/FireAuth.dart';
import 'package:smarthealth/RootPage.dart';
import 'package:smarthealth/SignUp.dart';
import 'Home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
  LoginPage({this.auth, this.onSignedIn});
  final BasicAuth auth;
  final VoidCallback onSignedIn;
}

class _LoginPageState extends State<LoginPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 280.0,
                child: Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.contain,
                ),
              ),
              Form(
                key: _formKey,
                child: new Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        textAlign: TextAlign.center,
                        style: style,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: "Email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0))),
                        validator: (input) =>
                            input.isEmpty ? "Email Can't Be Empty" : null,
                        onSaved: (input) {
                          setState(() {
                            _email = input;
                          });
                        },
                      ),
                      new Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      ),
                      TextFormField(
                        validator: (input) => input.isEmpty
                            ? "The Password Can't Be Empty"
                            : null,
                        obscureText: true,
                        textAlign: TextAlign.center,
                        style: style,
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: "Password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0))),
                        onSaved: (input) {
                          setState(() {
                            _password = input;
                          });
                        },
                      ),
                      new Container(
                        margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                      ),
                      Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(30.0),
                        color: Color(0xff01A0C7),
                        child: MaterialButton(
                          minWidth: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          onPressed: validateAndSubmit,
                          child: Text("Login",
                              textAlign: TextAlign.center,
                              style: style.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      new Container(
                        margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                      ),
                      InkWell(
                        onTap: () {
                          validateandsubmitgoogle();
                          Navigator.of(context).push(MaterialPageRoute(builder : (BuildContext context) => RootPage(auth: widget.auth)));
                        },
                        child: Container(
                          height: 40.0,
                          color: Colors.transparent,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black,
                                    style: BorderStyle.solid,
                                    width: 1.0),
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Center(
                                  child: ImageIcon(
                                      AssetImage('assets/images/google.png')),
                                ),
                                SizedBox(width: 30.0),
                                Center(
                                  child: Text('Log in with Google',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Montserrat')),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      new Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'New User ?',
                            style: TextStyle(fontFamily: 'Montserrat'),
                          ),
                          SizedBox(width: 5.0),
                          InkWell(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SignUpPage(
                                            auth: widget.auth,
                                            onSignedIn: widget.onSignedIn))),
                            child: Text(
                              'Register',
                              style: TextStyle(
                                  color: Color(0xff01A0C7),
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool validateAndSave() {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        String userid =
            await widget.auth.signInWithEmailAndPassword(_email, _password);
        print('Signid In : $userid');
        widget.onSignedIn();
      } catch (e) {
        print('Error : $e ');
      }
    }
  }

  void validateandsubmitgoogle() async {
    try {
      String userid = await widget.auth.googleSignIn();
      widget.onSignedIn();
    } catch (e) {
      print(e);
    }
  }
}
