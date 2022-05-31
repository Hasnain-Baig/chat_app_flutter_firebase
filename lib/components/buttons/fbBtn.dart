import 'package:flutter/material.dart';

class FbBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
              child: Container(
                width: 220,
                child: ElevatedButton(
                  onPressed: (){},
                  // signInWithFacebook,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.facebook),
                      SizedBox(
                        width: 2,
                      ),
                      Text("Facebook"),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xFF0D47A1),
                      shape: RoundedRectangleBorder(
                          //to set border radius to button
                          borderRadius: BorderRadius.circular(30)),
                      padding: EdgeInsets.all(
                          20) // color: MaterialStateProperty.all(Colors.red)),
                      ),
                ),
              ),
            );
  }
}