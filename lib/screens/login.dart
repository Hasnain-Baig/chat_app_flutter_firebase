import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/dialogBox/errorDialogBox.dart';
import '../components/dialogBox/loadingDialogBox.dart';
import '../components/buttons/mySwitch.dart';
import '../components/theme/myTheme.dart';
import 'home.dart';
import 'signup.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var userId;
  var hide = true;
  late final Map data;
  var loggedIn = false;
  var loadObj = {"isLoading": false, "action": ""};

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  passwordHide() {
    setState(() {
      hide = !hide;
    });
  }

  login() async {
    print("\nEmail:${emailController.text}\nPass:${passwordController.text}");

    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore db = FirebaseFirestore.instance;
    var email = emailController.text;
    var password = passwordController.text;
    if (email != "" || password != "") {
      setState(() {
        loadObj["isLoading"] = true;
        loadObj["action"] = "logging in";
      });
      try {
        final UserCredential user = await auth.signInWithEmailAndPassword(
            email: email, password: password);
        final DocumentSnapshot snapshot = await db
            .collection("users")
            .doc(user.user!.uid)
            .get(); // UserCredential and DocumentSnapshot is classes just use fot the auto complete purpose of code,it is not necessarily needed.

        // if(loading){showDialog(
        //     context: context,
        //     builder: (BuildContext context) {
        //       return AlertDialog(
        //         content: Center(child: CircularProgressIndicator()),
        //       );
        //     });
        // }

        var userData =
            snapshot.data(); //it will assign complete user array from db
        print("Snapshot : ${userData}");
        // userId = user.user!.uid;
        setState(() {
          loadObj["isLoading"] = false;
          loadObj["action"] = "";
        });
        print("User logged in");

        emailController.clear();
        passwordController.clear();

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(
                      data: {
                        // "uId": userId,
                        "userData": userData,
                        "loggedIn": true
                      },
                    )));
      } catch (e) {
        print("Error ${e}");

        setState(() {
          loadObj["isLoading"] = false;
          loadObj["action"] = "";
        });

        showDialog(
            context: context,
            builder: (context) {
              return ErrorDialogBox(dataError: "$e");
            });
      }
    } else {
      setState(() {
        loadObj["isLoading"] = false;
        loadObj["action"] = "";
      });
      showDialog(
          context: context,
          builder: (context) {
            return ErrorDialogBox(
                dataError: "Empty Input Fields! Kindly Fill to Login");
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
              title: Text("LOGIN FORM"),
              automaticallyImplyLeading: false,
              actions: [MySwitch()]
              // backgroundColor: Colors.deepOrange,
              ),
          body: loadObj["isLoading"] == true
              ? LoadingDialogBox(loadObj: loadObj)
              : Center(
                  child: Container(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: TextField(
                            keyboardType: TextInputType.emailAddress,
                            maxLines: 1,
                            controller: emailController,
                            autofocus: true,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email),
                                border: OutlineInputBorder(),
                                hintText: 'Email Address'),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: TextField(
                            keyboardType: TextInputType.text,
                            maxLines: 1,
                            autofocus: true,
                            controller: passwordController,
                            obscureText: hide, //for passwords to hide
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.password),
                                suffixIcon: GestureDetector(
                                  onTap: passwordHide,
                                  child: hide
                                      ? Icon(Icons.visibility)
                                      : Icon(Icons.visibility_off),
                                ),
                                border: OutlineInputBorder(),
                                hintText: 'Password'),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                            onTap: () {}, child: Text("Forgot Password?")),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: login,
                            child: Text("LOGIN"),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Dont have an account?"),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SignUpScreen()));
                                },
                                child: Text(
                                  " Signup",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                )),
                          ],
                        ),
                      ])),
                )),
    );
  }
}
