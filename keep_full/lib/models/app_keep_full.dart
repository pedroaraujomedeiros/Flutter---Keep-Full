
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class App {

  Map<String,String> _user;

  App._(); // this basically makes it so you can instantiate this class


  static void clearSharedPreferences() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static const MaterialColor primarySwatch = const MaterialColor(
    0xFFE64A19,
    const <int, Color>{
      50:  const Color.fromRGBO(230, 74, 19, .1),
      100: const Color.fromRGBO(230, 74, 19, .2),
      200: const Color.fromRGBO(230, 74, 19, .3),
      300: const Color.fromRGBO(230, 74, 19, .4),
      400: const Color.fromRGBO(230, 74, 19, .5),
      500: const Color.fromRGBO(230, 74, 19, .6),
      600: const Color.fromRGBO(230, 74, 19, .7),
      700: const Color.fromRGBO(230, 74, 19, .8),
      800: const Color.fromRGBO(230, 74, 19, .9),
      900: const Color.fromRGBO(230, 74, 19, 1),
    },
  );

  static List<String> carouselImagesHomeTab(){
    final List<String> images = [];
    for(int i = 1; i <= 20; i++) {
      images.add('assets/images/carousel_home_tab/img$i.jpg');
    }
    return images;
  }


}