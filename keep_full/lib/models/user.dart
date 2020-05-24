import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  String _firstName;
  String _lastName;
  int _id;
  bool isLogged = false;

  User();

  Future<bool> appWasSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('seen') ?? false;
  }

  static Future<User> getUser() async {
    User user = User();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString('userFirstName') != null &&
        prefs.getString('userFirstName').isNotEmpty &&
        prefs.getString('userLastName') != null &&
        prefs.getString('userLastName').isNotEmpty) {
      await user.logIn(
        firstName: prefs.getString('userFirstName'),
        lastName: prefs.getString('userLastName'),
        userId: prefs.getInt('userId')
      );
    }

    return user;
  }

  Future<void> logIn(
      {@required firstName,
      @required String lastName,
      int userId = null}) async {
    this._firstName = firstName;
    this._lastName = lastName;
    if (userId == null) {
      this._id = Random().nextInt(9999999);
    }else{
      this._id = userId;
    }

    this.isLogged = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userFirstName', firstName);
    prefs.setString('userLastName', lastName);
    prefs.setInt('userId', this._id);
    prefs.setBool('seen', true);
  }

  Future<void> logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();

    this._firstName = null;
    this._lastName = null;
    this._id = null;

    this.isLogged = false;
  }

  @override
  String toString() {
    return "$_firstName $_lastName";
  }

}
