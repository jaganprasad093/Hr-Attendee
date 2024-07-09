import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/home_controller/home_controller.dart';
import 'package:flutter_application_1/controller/leave_controller/leave_controller.dart';
import 'package:flutter_application_1/controller/registration_controller/registration_controller.dart';
import 'package:flutter_application_1/view/bottom_navigation/bottom_navigation.dart';
import 'package:flutter_application_1/view/login_page/loginpage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // context.read<leave_controller>().ApprovelGetData();
    // context.read<leave_controller>().CancelledGetData();
    // context.read<leave_controller>().LeaveBalance();
    context.read<leave_controller>().fetchData();
    var user = FirebaseAuth.instance.currentUser;

    Future.delayed(Duration(seconds: 3)).then((value) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      log('isLoggedIn--$isLoggedIn');
      log(" user=$user");
      if (isLoggedIn && user != null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MultiProvider(
                providers: [
                  ChangeNotifierProvider(
                    create: (BuildContext context) {
                      return HomeController();
                    },
                  ),
                  ChangeNotifierProvider(
                    create: (context) => registration_controller(),
                  ),
                  ChangeNotifierProvider(
                    create: (context) => leave_controller(),
                  ),
                ],
                child: BottomNavigation(
                  initialIndex: 0,
                )),
          ),
          (route) => false,
        );
        log(" login page");
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Loginpage()),
          (route) => false,
        );
        log("login to homepage");
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Image.asset(
          "assets/images/splash_screen.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
