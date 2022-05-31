import 'package:flutter/material.dart';

class EmailPassBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 220,
        child: ElevatedButton(
          onPressed: () {
            // Navigator.push(context,
            // MaterialPageRoute(builder: (context) => EmailLogin()));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.email),
              SizedBox(
                width: 2,
              ),
              Text("Email"),
            ],
          ),
          style: ElevatedButton.styleFrom(
              primary: Colors.blueGrey,
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
