import 'package:flutter/material.dart';
import 'package:smarthealth/FireAuth.dart';
import 'package:smarthealth/LoginPage.dart';
import 'package:smarthealth/RootPage.dart';
import 'package:smarthealth/Infos.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
  final BasicAuth auth;
  SignUpPage({this.auth, this.onSignedIn});
  final VoidCallback onSignedIn;
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password, _name, _gender;
  int selectedRadio;

  void initState() {
    super.initState();
    selectedRadio = 0;
  }

// Changes the selected value on 'onChanged' click on each radio button
  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
      if (val == 1) {
        _gender = 'Female';
      } else {
        _gender = 'Male';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
    return new Scaffold(
      body: Center(
        
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(42.0,0,42.0,0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children : <Widget>[
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
                      validator: (input) =>
                          input.isEmpty ? "Full Name Can't Be Empty" : null,
                      textAlign: TextAlign.center,
                      style: style,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Full Name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0))),
                      onSaved: (input) {
                        setState(() {
                          _name = input;
                        });
                      },
                    ),
                    new Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    ),
                    TextFormField(
                      validator: (input) =>
                          input.isEmpty ? "Email Can't Be Empty" : null,
                      textAlign: TextAlign.center,
                      style: style,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Email",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0))),
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
                          ? "Password Can't Be Empty"
                          : (input.length < 6
                              ? "PLease Enter A Longer Password"
                              : null),
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
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    ),
                    new Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    ),
                    Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(30.0),
                      color: Color(0xff01A0C7),
                      child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        onPressed: (){validateAndSubmit();
                        Navigator.of(context).push(MaterialPageRoute(builder : (BuildContext context) => Age_Gender()));},
                        child: Text("Sign Up",
                            textAlign: TextAlign.center,
                            style: style.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
                  margin: const EdgeInsets.only(left: 0.0, right: 280.0, top:0.0 , bottom:50.0),
                  child: new FloatingActionButton(
                    tooltip: 'Signin',
                    child: Icon(Icons.account_circle, color: Color(0xff01A0C7)),
                    backgroundColor: Colors.white,
                    onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder : (BuildContext context) => LoginPage(auth: widget.auth,onSignedIn: widget.onSignedIn,)));},
                  ),
                ),],
          ),
        ),
      ),
    ),);
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
        String userid = await widget.auth.signUpWithEmailAndPassword(_email,_password,_name);
        print('User Signed In $userid');
        widget.onSignedIn();
      } catch (e) {
        print('Error : $e ');
      }
    }
  }
}
