import 'package:flutter/material.dart';

class PhoneBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 220,
        child: ElevatedButton(
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.phone),
              SizedBox(
                width: 2,
              ),
              Text("Phone Number"),
            ],
          ),
          style: ElevatedButton.styleFrom(
              primary: Colors.teal,
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
