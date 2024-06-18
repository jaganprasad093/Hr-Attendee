import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/view/login_page/loginpage.dart';
import 'package:flutter_application_1/view/profile/personal_information/personal_information.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Center(
              child: Stack(children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://images.pexels.com/photos/1704488/pexels-photo-1704488.jpeg?auto=compress&cs=tinysrgb&w=600"),
                  radius: 60,
                  backgroundColor: Colors.grey.withOpacity(0.6),
                  // child: Icon(
                  //   Icons.person,
                  //   size: 60,
                  //   color: Colors.white,
                  // ),
                ),
                Positioned(
                    bottom: 1,
                    right: 1,
                    child: Icon(
                      Icons.camera_alt_outlined,
                      size: 40,
                      color: Colors.white,
                    )),
              ]),
            ),
            SizedBox(height: 10),
            Text(
              "username",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            Text("Description"),
            SizedBox(height: 20),
            Container(
              color: Colors.grey.withOpacity(0.3),
            ),
            Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PersonalInformation(),
                        ));
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey.shade300,
                              child: Icon(Icons.person),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "My Profile",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios_rounded)
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 1,
                  width: 200,
                  color: Colors.grey.withOpacity(.3),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey.shade300,
                            child: Icon(Icons.policy),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Privacy and policy",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios_rounded)
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 1,
                  width: 200,
                  color: Colors.grey.withOpacity(.3),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey.shade300,
                            child: Icon(Icons.book_online_rounded),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Terms and conditions",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios_rounded)
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 1,
                  width: 200,
                  color: Colors.grey.withOpacity(.3),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey.shade300,
                            child: Icon(Icons.settings),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Settings",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios_rounded)
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 1,
                  width: 200,
                  color: Colors.grey.withOpacity(.3),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    try {
                      await FirebaseAuth.instance.signOut();
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setBool('isLoggedIn', false);

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Loginpage(),
                        ),
                        (route) => false,
                      );
                      setState(() {});
                    } catch (e) {
                      print('Error logging out: $e');

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Failed to log out. Please try again.'),
                        ),
                      );
                    }
                  },
                  child: Container(
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey.shade300,
                          child: Icon(
                            Icons.exit_to_app_rounded,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Log Out",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
            // Additional content can go here
          ],
        ),
      ),
    );
  }
}
