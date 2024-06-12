import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/login_page/loginpage.dart';

class New_password extends StatefulWidget {
  const New_password({super.key});

  @override
  State<New_password> createState() => _New_passwordState();
}

class _New_passwordState extends State<New_password> {
  TextEditingController password_controller = TextEditingController();
  TextEditingController repassword_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios_new_outlined),
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
                "Enter new password",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              SizedBox(
                height: 10,
              ),
              Text("please enter your new password"),
              SizedBox(
                height: 50,
              ),
              Center(
                child: Image.network(
                    "https://static.vecteezy.com/system/resources/thumbnails/005/163/927/small/login-success-concept-illustration-flat-design-eps10-modern-graphic-element-for-landing-page-empty-state-ui-infographic-icon-vector.jpg"),
              ),
              SizedBox(
                height: 50,
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
                controller: repassword_controller,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "re-enter password",
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
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Loginpage(),
                          ));
                    },
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
}
