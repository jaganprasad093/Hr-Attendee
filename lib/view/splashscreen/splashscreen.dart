import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/homepage/home_page.dart';
import 'package:flutter_application_1/view/login_page/loginpage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3))
        .then((value) => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => Loginpage(),
            ),
            (route) => false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Image.asset(
        "assets/images/splash_screen.png",
        fit: BoxFit.fill,
      ),
    ));

    
  }
}
