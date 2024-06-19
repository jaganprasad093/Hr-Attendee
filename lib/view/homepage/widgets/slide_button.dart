import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/home_controller/home_controller.dart';
import 'package:flutter_application_1/model/homescreen_model/homescreen_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slider_button/slider_button.dart';

class SlideButton extends StatefulWidget {
  @override
  _SlideButtonState createState() => _SlideButtonState();
}

class _SlideButtonState extends State<SlideButton> {
  bool isSlide = false;
  @override
  void initState() {
    value_islide();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliderButton(
      backgroundColor: isSlide ? Colors.blue : Colors.red,
      height: 60,
      shimmer: false,
      width: 300,
      radius: 5,
      action: () async {
        HomeController().addData(isSlide);

        setState(() {
          isSlide = !isSlide;
          save_IsSlide(isSlide);

          log("isslide:$isSlide");
        });
        return false;
      },
      label: Text(
        isSlide ? " Swipe to check in" : "Swipe to check out",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 17,
        ),
      ),
      icon: Center(
        child: Icon(
          Icons.arrow_forward,
          color: isSlide ? Colors.blue : Colors.redAccent,
          size: 30.0,
          semanticLabel: 'Text to announce in accessibility modes',
        ),
      ),
      boxShadow: BoxShadow(
        color: Colors.black.withOpacity(0.3),
        blurRadius: 4,
      ),
    );
  }

  Future<void> value_islide() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      isSlide = pref.getBool('isSlide') ?? false;
    });
  }

  void save_IsSlide(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isSlide', value);
  }
}
