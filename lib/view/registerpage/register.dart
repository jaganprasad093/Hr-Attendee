import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/registration_controller/registration_controller.dart';
import 'package:flutter_application_1/model/registration_model.dart/registration_model.dart';
import 'package:flutter_application_1/view/login_page/loginpage.dart';
import 'package:provider/provider.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  TextEditingController firstname_controller = TextEditingController();
  TextEditingController lastname_controller = TextEditingController();
  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  TextEditingController repassword_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                "Register account",
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
                controller: firstname_controller,
                decoration: InputDecoration(
                    hintText: " first name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: lastname_controller,
                decoration: InputDecoration(
                    hintText: " last name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: email_controller,
                decoration: InputDecoration(
                    hintText: " Email address",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: password_controller,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                obscureText: true,
                controller: repassword_controller,
                decoration: InputDecoration(
                    hintText: " re-enter password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(
                height: 80,
              ),
              Container(
                height: 50,
                width: 400,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: InkWell(
                    onTap: () async {
                      if (email_controller.text.isNotEmpty &&
                          password_controller.text.isNotEmpty &&
                          firstname_controller.text.isNotEmpty &&
                          lastname_controller.text.isNotEmpty) {
                        await context.read<registration_controller>().addData(
                              Registration_model(
                                firstname: firstname_controller.text,
                                lastname: lastname_controller.text,
                                email: email_controller.text,
                                password: password_controller.text,
                              ),
                            );

                        log("success");

                        context
                            .read<registration_controller>()
                            .register(
                              firstname: firstname_controller.text,
                              lastname: lastname_controller.text,
                              email: email_controller.text,
                              context: context,
                              password: password_controller.text,
                              repassword: repassword_controller.text,
                            )
                            .then((value) {
                          log("login success");

                          if (value == true) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.green,
                              content: Text("register success"),
                            ));

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Loginpage(),
                              ),
                            );
                          }
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("something is missing"),
                        ));
                      }
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                      text: TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(color: Colors.black),
                          children: <TextSpan>[
                        TextSpan(
                          text: "login",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        )
                      ])),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
