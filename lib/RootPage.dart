import 'package:flutter/material.dart';
import 'package:smarthealth/LoginPage.dart';
import 'package:smarthealth/SignUp.dart';
import 'package:smarthealth/FireAuth.dart';
import 'package:smarthealth/Home.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
enum AuthStatus { notSignedIn, signedIn }

class RootPage extends StatefulWidget {
  RootPage({this.auth});
  final BasicAuth auth;
  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

class _RootPageState extends State<RootPage> {
  AuthStatus authstatus = AuthStatus.notSignedIn;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.auth.currentUser().then((userId) {
      setState(() {
        authstatus =
            userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  void _signedIn() {
    setState(() {
      authstatus = AuthStatus.signedIn;
    });
  }
  void _signedOut() async {
    setState(() {
      try {
      
      widget.auth.signOut();
      authstatus = AuthStatus.notSignedIn;
      } catch (e) {
        print(e);
      }
      
    });
  }
  @override
  Widget build(BuildContext context) {
    switch (authstatus) {
      case AuthStatus.notSignedIn:
        return new MaterialApp(
          title: 'Smart Health',
          theme: new ThemeData(primarySwatch: Colors.green),
          home: new LoginPage(auth: widget.auth, onSignedIn: _signedIn),
        );
      case AuthStatus.signedIn:
       { print("hona"); 
         return MyHomePage(auth: widget.auth,signedOut: _signedOut,signedIn: _signedIn,);
        //  String userid ;
        //   widget.auth.currentUser().then((onValue){
        //     userid = onValue;
        //   });
        //   if(widget.auth.searchIfUserExists(userid)){
        //     DocumentSnapshot userRef = widget.auth.getSingleDocument(userid);
        //     if(userRef.data["FillingFields"]==0){
              
            }

        }
    
  }
}

class WelcomePage extends StatefulWidget {
  final BasicAuth auth;
  WelcomePage({this.auth, this.onSignedIn});
  final VoidCallback onSignedIn;
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  void _signIn(){
    widget.onSignedIn();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health app'),
      ),
      body: LoginPage(),
    );
  }



  void navigateToSignUp() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                SignUpPage(auth: new FireAuth(), onSignedIn: _signIn),
            fullscreenDialog: true));
  }
}
