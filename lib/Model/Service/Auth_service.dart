import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:mergeme/Model/UserModel/userModel.dart';
import 'firestore_service.dart';
import 'localStorage_service.dart';
import 'locator_setup.dart';
import 'package:mergeme/Model/constants/route_path.dart' as route;




class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FireStoreService _fireStoreService = locator<FireStoreService>();
  final LocalStorageService _storageService = locator<LocalStorageService>();

  User _currentUser;

  User get currentUser => _currentUser;


  // making user data available
  Future _populateCurrentUser(FirebaseUser user) async {
    if (user != null) {
      _currentUser = await _fireStoreService.getUser(user.uid);
    }
  }

  // get user name at welcome back
  welcomeBack() async {
    var user = await _firebaseAuth.currentUser();
    await _populateCurrentUser(user);
  }

  UserId _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? UserId(user.uid) : null;
  }

// get user data at login
  Stream<UserId> get userValue {
    return _firebaseAuth.onAuthStateChanged
    //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }



// check if user is log in
  Future<bool> isUserLoggedIn() async {
    var user = await _firebaseAuth.currentUser();
    await _populateCurrentUser(user);
    return user != null;
  }

  // Login with email and password

  Future loginWithEmail({
    @required String email,
    @required String password,
    String location
  }) async {
    try {
      var authUser = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _populateCurrentUser(authUser.user);
      await Firestore.instance.collection('DataBase').document(authUser.user.uid).setData({route.Location:location},merge: true);
      return authUser != null;
    } catch (e) {
      return e.message;
    }
  }

  // sign up with email and password
  Future signUpWithEmail({
    @required String email,
    @required String password,
    @required String fullName,
    @required String mobileNo,
    String workNumber,
    String tradeName,
    String nin,
    String tutorOption,
    String tradeCategory,
    String specificTrade,
    String location,
  }) async {
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // create a new user profile on fireStore
      _currentUser = User(
          password,
          mobileNo,
          workNumber,
          tradeName,
          nin,
          tutorOption,
          tradeCategory,
          authResult.user.uid,
          fullName,
          email,
          specificTrade,
          location
      );
    // save user id locally
      await _storageService.setUser(route.UserID, authResult.user.uid);
      // to save data for trader-to display trade page

      // give work
      if (tradeCategory=='Give a work'){
        await Firestore.instance.collection(route.GiveWork+''+specificTrade+route.UserID).document(
            authResult.user.uid).setData({
          route.UserID:authResult.user.uid,
        });
        await Firestore.instance.collection(route.GiveWork+''+specificTrade).document(
            'User').setData({
          'No of Clients':FieldValue.increment(1),
        },merge: true);
      }

      // Learn trade
      if (tradeCategory=='Learn a trade'){
        await Firestore.instance.collection(route.LearnTrade +''+specificTrade).document(
            'UserData').setData({
          route.UserID:authResult.user.uid,
        });

      }
      await Firestore.instance.collection(route.LearnTrade+''+specificTrade).document(
          'User').setData({
        'No of traders':FieldValue.increment(1),
      },merge: true);



    // Search work
      if (tradeCategory== 'Search for work'){
        await Firestore.instance.collection(route.SearchWork +''+specificTrade+route.UserID).document(
            authResult.user.uid).setData({
          route.UserID:authResult.user.uid,
        });
        await Firestore.instance.collection(route.SearchWork+''+specificTrade).document(
            'User').setData({
          'No of traders':FieldValue.increment(1),
        },merge: true);
      }


      // create user
      await _fireStoreService.createUser(_currentUser);

      // save tutors file-to display learn page
      if (tutorOption == 'Yes') {
        await Firestore.instance.collection(specificTrade +route.tutors+route.UserID).document(
            authResult.user.uid).setData({
          route.UserID:authResult.user.uid,
        });

        await Firestore.instance.collection(specificTrade +route.tutors).document(
            'User').setData({
          'No of tutors':FieldValue.increment(1)
        },merge: true);

        await Firestore.instance.collection(route.tutors).document(
            'Tutors').updateData({
          'No of tutors':FieldValue.increment(1)
        });

      }

      // to get no of client/traders/
      await Firestore.instance.collection("Merge me").document('Users')
          .updateData({
      'No of Users'
      : FieldValue.increment(1)});



      return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await FirebaseAuth.instance.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

}