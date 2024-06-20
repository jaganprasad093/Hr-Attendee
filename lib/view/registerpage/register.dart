import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/registration_controller/registration_controller.dart';
import 'package:flutter_application_1/model/registration_model/registration_model.dart';
import 'package:flutter_application_1/view/login_page/loginpage.dart';
import 'package:provider/provider.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repasswordController = TextEditingController();
  bool invisible = true;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30),
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
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: "HR Attendee",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.blue,
                        ),
                      )
                    ],
                  ),
                ),
                Text("Hello there, login to continue"),
                SizedBox(height: 30),
                TextFormField(
                  controller: firstnameController,
                  decoration: InputDecoration(
                    hintText: "First name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (String? value) {
                    return (value == null || value.isEmpty)
                        ? 'Please enter the first name'
                        : null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: lastnameController,
                  decoration: InputDecoration(
                    hintText: "Last name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (String? value) {
                    return (value == null || value.isEmpty)
                        ? 'Please enter the last name'
                        : null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "Email address",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (String? value) {
                    return (value == null || value.isEmpty)
                        ? 'Please enter the email'
                        : null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
                  obscureText: invisible,
                  decoration: InputDecoration(
                    hintText: "Password",
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          invisible = !invisible;
                        });
                      },
                      child: Icon(
                          invisible ? Icons.visibility : Icons.visibility_off),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (String? value) {
                    return (value == null || value.isEmpty)
                        ? 'Please enter the password'
                        : null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: repasswordController,
                  obscureText: invisible,
                  decoration: InputDecoration(
                    hintText: "Re-enter password",
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          invisible = !invisible;
                        });
                      },
                      child: Icon(
                          invisible ? Icons.visibility : Icons.visibility_off),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (String? value) {
                    return (value == null || value.isEmpty)
                        ? 'Please re-enter the password'
                        : null;
                  },
                ),
                SizedBox(height: 80),
                Container(
                  height: 50,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: InkWell(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          if (passwordController.text ==
                              repasswordController.text) {
                            log("success");

                            context
                                .read<registration_controller>()
                                .register(
                                  firstname: firstnameController.text,
                                  lastname: lastnameController.text,
                                  email: emailController.text,
                                  context: context,
                                  password: passwordController.text,
                                  repassword: repasswordController.text,
                                )
                                .then((value) async {
                              log("register success");
                              await context
                                  .read<registration_controller>()
                                  .addData(
                                      Registration_model(
                                        firstname: firstnameController.text,
                                        lastname: lastnameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                      ),
                                      FirebaseAuth.instance.currentUser?.uid ??
                                          "");

                              if (value == true) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text("Register success"),
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
                              content: Text("Passwords do not match"),
                            ));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Text("Please fill in all fields"),
                          ));
                        }
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                              text: "Login",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
