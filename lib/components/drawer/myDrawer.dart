import 'package:chat_app_flutter_firebase/screens/home.dart';
import 'package:flutter/material.dart';

import '../../screens/login.dart';

class MyDrawer extends StatefulWidget {
  Map data;

  MyDrawer({required this.data});

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  // var loadObj = {"isLoading": false, "action": ""};

  logOutDialogBox() {
    return AlertDialog(
      title: Container(
        color: Theme.of(context).colorScheme.primary,
        width: MediaQuery.of(context).size.width * .3,
        padding: EdgeInsets.all(8),
        child: Center(
            child: Text("Logout",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ))),
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Do you want to logout?",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                  child: Text("Yes"),
                  onPressed: () {
                    logOut();
                  }),
              ElevatedButton(
                child: Text("No"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              // Container(
              //     width: MediaQuery.of(context).size.width * .3,
              //     child: Column(
              //       mainAxisSize: MainAxisSize.min,
              //       // mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Center(
              //           child: CircularProgressIndicator(
              //             color: Theme.of(context).colorScheme.primary,
              //           ),
              //         ),
              //       ],
              //     )),
            ],
          ),
        ],
      ),
    );
  }

  logOut() async {
    // setState(() {
    //   loadObj["isLoading"] = true;
    //   loadObj["action"] = "logging out";
    // });
    widget.data['loggedIn'] = false;
    // setState(() {
    //   loadObj["isLoading"] = false;
    //   loadObj["action"] = "";
    // });
    setState(() {});
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  logOutPopUp() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return logOutDialogBox();
        });
  }

  Widget build(BuildContext context) {
    // var userData = {
    //   "firstLetter": "C",
    //   "name": "Cristiano Ronaldo",
    //   "userName": "CristianoRonaldo7",
    //   "country": "portugal",
    //   "email": "cristiano_ronaldo7@gmail.com",
    //   "phone": "+92 300 0000000",
    //   "accountId": "127826728282",
    //   "dOB": "20/2/1987",
    //   "gender": "Male",
    // };

    var userData = {
      "firstLetter": widget.data["userData"]["fullname"]
          .toString()
          .substring(0, 1)
          .toUpperCase(),
      "accountId": widget.data["userData"]["uId"],
      "name": widget.data["userData"]["fullname"].toString().toUpperCase(),
      "gender": widget.data["userData"]["gender"],
      "dOB": widget.data["userData"]["date of birth"],
      "country": widget.data["userData"]["country"],
      "email": widget.data["userData"]["email"],
      "phone": widget.data["userData"]["phone number"],
    };

    print("drawer->${widget.data}");

    return
        // loadObj['isLoading'] == true
        //     ? LoadingDialogBox(loadObj: loadObj)
        //     :
        Drawer(
      child: Container(
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
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: logOutPopUp,
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .secondaryVariant,
                              child: Text(
                                "${userData['firstLetter']}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                              ),
                            ),
                          ),
                        ]),
                    SizedBox(height: 10),
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage("assets/images/profile.png"),
                    ),
                    SizedBox(height: 10),
                    Text("${userData['name']}",
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
              leading: userData['gender'] == 'Male'
                  ? Icon(
                      Icons.male,
                      color: Theme.of(context).colorScheme.onSecondary,
                    )
                  : userData['gender'] == 'Female'
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
              subtitle: Text("${userData['gender']}",
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
              subtitle: Text("${userData['dOB']}",
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
              subtitle: Text("${userData['country']}",
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
              subtitle: Text("${userData['email']}",
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
              subtitle: Text("${userData['phone']}",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondary,
                  )),
            ),
            ListTile(
              leading: Icon(
                Icons.perm_identity_outlined,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
              // tileColor: Colors.black87,
              title: Text("Account ID",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondary,
                  )),
              subtitle: Text("${userData['accountId']}",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondary,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
