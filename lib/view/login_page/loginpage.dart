import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/login_controller/login_controller.dart';
import 'package:flutter_application_1/controller/registration_controller/registration_controller.dart';
import 'package:flutter_application_1/view/bottom_navigation/bottom_navigation.dart';
import 'package:flutter_application_1/view/homepage/home_page.dart';
import 'package:flutter_application_1/view/login_page/forgot_password/forgot_password.dart';
import 'package:flutter_application_1/view/registerpage/register.dart';
import 'package:provider/provider.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                "Welcome back 👋🏻..",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              RichText(
                  text: TextSpan(
                      text: "to ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.black),
                      children: <TextSpan>[
                    TextSpan(
                      text: "HR Attendee",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.blue),
                    )
                  ])),
              Text("Hello there login to continuee"),
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: email_controller,
                decoration: InputDecoration(
                    hintText: " Email adress",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: password_controller,
                decoration: InputDecoration(
                    hintText: " Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Consumer<registration_controller>(
                              builder: (context, value, child) =>
                                  Forgot_password(),
                            ),
                          ));
                    },
                    child: Text(
                      "forget password",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () {
                  if (email_controller.text.isNotEmpty &&
                      password_controller.text.isNotEmpty) {
                    context
                        .read<login_controller>()
                        .login(
                            context: context,
                            email: email_controller.text,
                            password: password_controller.text)
                        .then((value) {
                      // login sucess
                      if (value == true) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.green,
                            content: Text("login sucess")));

                        showDialogWithFields();
                      }
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red,
                        content: Text("enter valid email and password")));
                  }
                },
                child: Container(
                  height: 50,
                  width: 400,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Registerpage(),
                          ));
                    },
                    child: RichText(
                        text: TextSpan(
                            text: "Did you have an account? ",
                            style: TextStyle(color: Colors.black),
                            children: <TextSpan>[
                          TextSpan(
                            text: "Register",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          )
                        ])),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showDialogWithFields() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: Container(
            height: 230,
            // width: 200,
            child: Column(
              children: [
                Container(
                  height: 200,
                  width: 200,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: Image.network(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1Io69UM6Ba9ZdS6rqwRj0Nh5sSHI_iSGRaQ&s",
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Your account ready to use",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.black.withOpacity(.5)),
                )
              ],
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Bottom_navigation(),
                    ));
              },
              child: Container(
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    "Back to home",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
