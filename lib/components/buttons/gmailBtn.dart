import 'package:flutter/material.dart';

class GmailBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 220,
        child: ElevatedButton(
          onPressed:(){}, 
          // signInWithGoogle,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/gmail.png", height: 20, width: 20),
              SizedBox(
                width: 2,
              ),
              Text("Google"),
            ],
          ),
          style: ElevatedButton.styleFrom(
              primary: Color(0xFFB71C1C),
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
