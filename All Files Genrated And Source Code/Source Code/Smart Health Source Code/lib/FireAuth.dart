import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BasicAuth {
  Future<String> signInWithEmailAndPassword(String eemail, String ppassword);
  Future<String> signUpWithEmailAndPassword(String email,String password,String name);
  Future<String> currentUser();
  Future<void> signOut();
  Future<String> googleSignIn();
  getDocuments(name);
  bool searchIfUserExists(String userid);
  DocumentSnapshot getSingleDocument(String userid);
  void addInfosUsers(String uid,Map<String, dynamic> infos);
}

class FireAuth implements BasicAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final Firestore _db = Firestore.instance;

  Future<String> googleSignIn() async {
    GoogleSignInAccount googleuser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleuserauth = await googleuser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleuserauth.accessToken,
        idToken: googleuserauth.idToken);
    FirebaseUser user = await _auth.signInWithCredential(credential);
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);
    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    if (!searchIfUserExists(user.uid)) {
      Map<String, dynamic> infos = <String, dynamic>{
        "Email": user.email,
        "Password": "googleUser",
        "FullName": user.displayName,
        "FillingFields": 1,
      };
      _db.collection('Users').document(user.uid).setData(infos).catchError((e) {
        print(e);
      });
    }
    return user.uid;
  }

  void updateUserData(FirebaseUser user) async {}

  Future<String> signInWithEmailAndPassword(
      String eemail, String ppassword) async {
    FirebaseUser user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: eemail, password: ppassword);
    return user.uid;
  }

  Future<String> signUpWithEmailAndPassword(String email,String password,String name) async {
    FirebaseUser user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: email, password: password);
    Map<String, dynamic> infos = <String, dynamic> {
      "Email" : email,
      "Password" : password,
      "FullName" : name,
      "FieldCompleted" : 1,
    };
    _db.collection('Users').document(user.uid).setData(infos).catchError((e) {
      print(e);
    });
    return user.uid;
  }

  Future<String> currentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if (user == null) return null;
    return user.uid;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    return null;
  }

  getDocuments(name) async {
    return await _db.collection(name).getDocuments();
  }

  bool searchIfUserExists(String userid) {
    DocumentReference docref = _db.collection('Users').document(userid);
    docref.get().then((doc) {
      if (doc.exists) return true;

      return false;
    });
  }

  DocumentSnapshot getSingleDocument(String userid) {
    DocumentReference docref = _db.collection('Users').document(userid);
    docref.get().then((doc) {
      print(doc.data);
      return doc;
    });
  
  }
  void addInfosUsers(String uid,Map<String, dynamic> infos){
    _db.collection('Users').document(uid).setData(infos).catchError((e) {
      print(e);
    });
  }
}
