import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatUserInfoScreen extends StatefulWidget {
  Map data;

  ChatUserInfoScreen({required this.data});

  @override
  _ChatUserInfoScreenState createState() => _ChatUserInfoScreenState();
}

class _ChatUserInfoScreenState extends State<ChatUserInfoScreen> {
  @override
  Widget build(BuildContext context) {
    print("=============>${widget.data}");
    return Scaffold(
        // appBar: AppBar(),
        body: Container(
      color: Theme.of(context).colorScheme.secondary,
      child: ListView(
        controller: ScrollController(),
        children: [
          Container(
            height: 230,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        child: Icon(Icons.arrow_back),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage("assets/images/profile.png"),
                  ),
                  SizedBox(height: 10),
                  Text("${widget.data["fullname"]}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
            ),
          ),
          ListTile(
            // tileColor: Colors.black87,
            title: Text("Account Details",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                )),
          ),
          // ListTile(
          //   leading: Icon(
          //     Icons.verified_user_outlined,
          //     color: Theme.of(context).colorScheme.onSecondary,
          //   ),
          //   // tileColor: Colors.black87,
          //   title: Text("Username",
          //       style: TextStyle(
          //         color: Theme.of(context).colorScheme.onSecondary,
          //       )),
          //   subtitle: Text("${userData['userName']}",
          //       style: TextStyle(
          //         color: Theme.of(context).colorScheme.onSecondary,
          //       )),
          // ),
          ListTile(
            leading: widget.data['gender'] == 'Male'
                ? Icon(
                    Icons.male,
                    color: Theme.of(context).colorScheme.onSecondary,
                  )
                : widget.data['gender'] == 'Female'
                    ? Icon(
                        Icons.female,
                        color: Theme.of(context).colorScheme.onSecondary,
                      )
                    : Icon(
                        Icons.add,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),

            // tileColor: Colors.black87,
            title: Text("Gender",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                )),
            subtitle: Text("${widget.data['gender']}",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                )),
          ),
          ListTile(
            leading: Icon(
              Icons.perm_contact_calendar_outlined,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
            // tileColor: Colors.black87,
            title: Text("Date of Birth",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                )),
            subtitle: Text("${widget.data['date of birth']}",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                )),
          ),
          ListTile(
            leading: Icon(
              Icons.area_chart,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
            // tileColor: Colors.black87,
            title: Text("Country",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                )),
            subtitle: Text("${widget.data['country']}",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                )),
          ),
          ListTile(
            leading: Icon(
              Icons.email_outlined,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
            // tileColor: Colors.black87,
            title: Text("Email Address",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                )),
            subtitle: Text("${widget.data['email']}",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                )),
          ),
          ListTile(
            leading: Icon(
              Icons.phone_outlined,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
            // tileColor: Colors.black87,
            title: Text("Phone Number",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                )),
            subtitle: Text("${widget.data['phone number']}",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                )),
          ),
        ],
      ),
    ));
  }
}
