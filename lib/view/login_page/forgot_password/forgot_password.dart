import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/login_page/forgot_password/otp_verification/otp_verification.dart';

class Forgot_password extends StatefulWidget {
  const Forgot_password({super.key});

  @override
  State<Forgot_password> createState() => _Forgot_passwordState();
}

class _Forgot_passwordState extends State<Forgot_password> {
  EmailOTP myauth = EmailOTP();
  TextEditingController email_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_new_outlined)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
              Text(
                "Forgot password",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              SizedBox(
                height: 10,
              ),
              Text("Which contact details should we use to reset password"),
              SizedBox(
                height: 50,
              ),
              Image.network(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTgDPHc9TIzPqEJ1EJ-32CQ7JZ7BdOxWHgAQ&s"),
              SizedBox(
                height: 50,
              ),
              TextField(
                controller: email_controller,
                decoration: InputDecoration(
                  hintText: "email",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 30),
              //   child: Container(
              //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              //     decoration: BoxDecoration(
              //         color: Colors.black.withOpacity(.1),
              //         borderRadius: BorderRadius.circular(10)),
              //     height: 80,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Row(
              //           children: [
              //             Icon(Icons.email_outlined),
              //             SizedBox(
              //               width: 10,
              //             ),
              //             Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Text(
              //                   "Phone",
              //                   style: TextStyle(fontWeight: FontWeight.bold),
              //                 ),
              //                 Text("sdfgh@gamil.com"),
              //               ],
              //             ),
              //           ],
              //         ),
              //         CircleAvatar(
              //           radius: 15,
              //           backgroundColor: Colors.blue,
              //           child: CircleAvatar(
              //             radius: 13,
              //             backgroundColor: Colors.white,
              //             child: CircleAvatar(
              //               radius: 10,
              //               backgroundColor: Colors.blue,
              //             ),
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // ),
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
                    onTap: () {
                      resetPassword(context);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Otp_verification(),
                          ));
                    },
                    // onTap: () async {
                    //   myauth.setConfig(
                    //       appEmail: "jaganprasad094@gmail.com",
                    //       appName: "email OTP of HR attendeee",
                    //       userEmail: email_controller.text,
                    //       otpLength: 6,
                    //       otpType: OTPType.digitsOnly);
                    //   log("message");
                    //   if (await myauth.sendOTP() == true) {
                    //     log("sucess");
                    //     ScaffoldMessenger.of(context)
                    //         .showSnackBar(const SnackBar(
                    //       content: Text("OTP has been sent"),
                    //     ));
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) => Otp_verification(),
                    //         ));
                    //   } else {
                    //     ScaffoldMessenger.of(context)
                    //         .showSnackBar(const SnackBar(
                    //       content: Text("Oops, OTP send failed"),
                    //     ));
                    //   }
                    // },
                    child: Text(
                      "Continue",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void resetPassword(BuildContext context) async {
    String email = email_controller.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter your email')),
      );
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password reset email sent')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }
}
