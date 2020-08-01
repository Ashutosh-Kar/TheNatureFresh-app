import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:mushroomm/models/user.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

enum UserEditStatus { Editing, NotEditing, Error, ImageEdit }

class UserRepository extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth;
  FirebaseUser _user;
  Status _status = Status.Uninitialized;
  UserEditStatus _editStatus = UserEditStatus.NotEditing;
  User user;

  Status get status => _status;

  FirebaseUser get firebaseuser => _user;

  UserEditStatus get userEditStatus => _editStatus;

  //Returns a stream of firebase user authentication state to provider
  UserRepository.instance() : _firebaseAuth = FirebaseAuth.instance {
    _firebaseAuth.onAuthStateChanged.listen(_onAuthStateChanged);
  }

  //Constructor Never used
  UserRepository({FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  //Sign in with credentials emails and password
  Future<bool> signInWithCredentials(
      {@required String email, @required String password}) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      Hive.box('mushroom').put('initStatus', true);
      return true;
    } catch (e) {
      print(e);
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  //Sign up with email and password
  Future<bool> signUp(
      {@required String email, @required String password}) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      AuthResult authResult = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      _user = authResult.user;
      _status = Status.Authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  //Signs out and sets state to Unauthenticated
  Future<void> signOut() async {
    try {
      Future.wait([_firebaseAuth.signOut()]);
      _status = Status.Unauthenticated;
      notifyListeners();
    } catch (e) {
      print(e);
      print('error');
    } finally {}
  }

  //Returns if the user is signed in
  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  //Returns current user
  Future<String> getUser() async {
    return (await _firebaseAuth.currentUser()).email;
  }

  //Whenever firebase auth state changes, it sets the user auth state
  Future<void> _onAuthStateChanged(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      _status = Status.Authenticated;
    }
    notifyListeners();
  }

  Future fetchUserFromFirebase() async {
    var ref = Firestore.instance.collection('users');
    var querySnapshot =
        await ref.where('uid', isEqualTo: _user.uid).getDocuments();
    user = User.fromJson(querySnapshot.documents[0].data);
    print(jsonEncode(user));
  }

//This function updates the username / display name of the user
//Username has to be passed as named argument
//  Future<void> updateUserName({String username}) async {
//    //Sets user status to editing for the update button
//    _editStatus = UserEditStatus.Editing;
//    notifyListeners();
//
//    try {
//      print(username);
//      //Creates new instance of userUpdateInfo
//      UserUpdateInfo userUpdateInfo = UserUpdateInfo();
//      //Sets new displayname / username
//      userUpdateInfo.displayName = username;
//      //Sends new displayname / username to firebase
//      await _user.updateProfile(userUpdateInfo);
//      //Reloads user details
//      await _user.reload();
//      //Sets user to updated user
//      _user = await _firebaseAuth.currentUser();
//      print('new display name is');
//      print(_user.displayName);
//      //Sets status to not editing to remove circularprogressindicator
//      _editStatus = UserEditStatus.NotEditing;
//    } catch (e) {
//      print(e);
//      print('error');
//      //Sets error message
//      _editStatus = UserEditStatus.Error;
//    } finally {
//      //Notifies the UI about changes so that it can reload
//      notifyListeners();
//    }
//  }
}
