import 'package:flutter/material.dart';
import 'dart:async';

import 'login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var splashScreenTimer;
  var myTimer = 0;

  timerPlay() {
    splashScreenTimer =
        new Timer.periodic(new Duration(milliseconds: 1000), (timer) {
      myTimer++;
      // print("timer------->${myTimer}");
      if (myTimer == 3) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
        splashScreenTimer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    timerPlay();
    return Scaffold(
      body: Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 25),
              Center(
                child: Container(
                  child: Text(
                    "CHAT APP",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 24,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Center(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      "By Hasnain",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w200),
                    ),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
