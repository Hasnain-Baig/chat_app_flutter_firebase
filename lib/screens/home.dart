import 'package:cloud_firestore/cloud_firestore.dart';

import '../components/drawer/myDrawer.dart';
import 'package:flutter/material.dart';
import '../components/buttons/mySwitch.dart';
import '../components/theme/myTheme.dart';
import 'chat.dart';
// import 'chatScreen.dart';

class HomeScreen extends StatefulWidget {
  Map data;

  HomeScreen({required this.data});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  var searchVar = false;
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  var chatArr = [
    {
      "image": "assets/images/cr7.jpg",
      "name": "asim",
      "lastMsg": "i m here",
      "unSeenMsgsCount": 3,
    },
    {
      "image": "assets/images/adidas.jpg",
      "name": "sajjad",
      "lastMsg": "humanist",
      "unSeenMsgsCount": 0,
    },
    {
      "image": "assets/images/ferrari.jpg",
      "name": "Sharjeel",
      "lastMsg": "I m an idiot",
      "unSeenMsgsCount": 1,
    },
    {
      "image": "assets/images/iphonex.jpg",
      "name": "farhan",
      "lastMsg": "Mr. Jhonny",
      "unSeenMsgsCount": 2,
    },
    {
      "image": "assets/images/nike.jpg",
      "name": "Saeed",
      "lastMsg": "Chandio sahb",
      "unSeenMsgsCount": 0,
    },
    {
      "image": "assets/images/oppo.jpg",
      "name": "Touseer",
      "lastMsg": "Ertugal here...",
      "unSeenMsgsCount": 0,
    },
    {
      "image": "assets/images/shirt.jpg",
      "name": "Ali",
      "lastMsg": "Ufff...",
      "unSeenMsgsCount": 0,
    },
    {
      "image": "assets/images/kit.jpg",
      "name": "Nomi",
      "lastMsg": "yo...",
      "unSeenMsgsCount": 0,
    },
  ];

  searchFunc() {
    setState(() {
      searchVar = !searchVar;
    });
  }

  Widget build(BuildContext context) {
    print(widget.data);
    return Scaffold(
        drawer: MyDrawer(data: widget.data),
        appBar: AppBar(
          title: Text("HOME"),
          actions: [MySwitch()],

          // title: searchVar
          //     ? Row(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         children: [
          //           GestureDetector(
          //             onTap: searchFunc,
          //             child: Icon(Icons.arrow_back),
          //           ),
          //           SizedBox(width: 10),
          //           Container(
          //             width: MediaQuery.of(context).size.width * 0.8,
          //             child: TextField(
          //               style: TextStyle(color: Colors.white),
          //               cursorColor: Colors.white,
          //               decoration: InputDecoration(
          //                 border: InputBorder.none,
          //                 // focusedBorder: UnderlineInputBorder(

          //                 //   borderSide: BorderSide(color: Colors.white),
          //                 // ),
          //               ),
          //               autofocus: true,
          //               onChanged: (value) {
          //                 // item = value;
          //               },
          //             ),
          //           ),
          //         ],
          //       )
          //     : Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text("WhatsApp"),
          //           Container(
          //             child: Row(
          //               children: [
          //                 GestureDetector(
          //                     onTap: searchFunc, child: Icon(Icons.search)),
          //                 SizedBox(width: 10),
          //                 Icon(Icons.more_vert_sharp),
          //               ],
          //             ),
          //           )
          //         ],
          //       ),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: _usersStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data = {};
                  data["chatUserData"] = document.data()!;

                  return Column(
                    children: [
                      data["chatUserData"]["uId"] !=
                              widget.data["userData"]["uId"]
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChatScreen(data: {
                                              "userData":
                                                  widget.data["userData"],
                                              "chatUserData":
                                                  data["chatUserData"]
                                            })));
                              },
                              child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        AssetImage("assets/images/profile.png"),
                                    radius: 25,
                                  ),
                                  title: Text(
                                    "${data["chatUserData"]["fullname"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  subtitle: Text(
                                    "",

                                    //  "${chatArr[index]["lastMsg"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  trailing: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      // Text(
                                      //   "1:51 p.m",
                                      //   style: TextStyle(
                                      //     fontSize: 10,
                                      //   ),
                                      // ),
                                      //  chatArr[index]['unSeenMsgsCount'] != 0
                                      //  ?
                                      // CircleAvatar(
                                      //     backgroundColor: Theme.of(context)
                                      //         .colorScheme
                                      //         .primary,
                                      //     radius: 9,
                                      //     child: Center(
                                      //       child: Text(
                                      //         "1",
                                      //         style: TextStyle(
                                      //           fontSize: 12,
                                      //           color: Theme.of(context)
                                      //               .colorScheme
                                      //               .onPrimary,
                                      //         ),
                                      //       ),
                                      //     ))
                                    ],
                                  )),
                            )
                          : SizedBox(height: 0),
                      // Divider(
                      // height: 5,
                      // color: Theme.of(context).colorScheme.onSurface,
                      // thickness: 1,
                      // ),
                    ],
                  );
                }).toList(),
              );
            })
        // ListView.builder(
        //     itemCount: chatArr.length,
        //     itemBuilder: (context, index) {
        //       return GestureDetector(
        //         onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) =>
        //             ChatScreen(chatUserData: chatArr[index])));
        //         },
        //         child: Column(
        //           children: [
        //             ListTile(
        //                 leading: CircleAvatar(
        //                   // backgroundImage:AssetImage("${chatArr[index]["image"]}"),
        //                   backgroundImage: AssetImage("assets/images/profile.png"),
        //                   radius: 25,
        //                 ),
        //                 title: Text(
        //                   "${chatArr[index]["name"]}",
        //                   style: TextStyle(
        //                     fontWeight: FontWeight.w500,
        //                   ),
        //                 ),
        //                 subtitle: Text(
        //                   "${chatArr[index]["lastMsg"]}",
        //                   style: TextStyle(
        //                     fontSize: 12,
        //                   ),
        //                 ),
        //                 trailing: Column(
        //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
        //                   children: [
        //                     Text(
        //                       "1:51 p.m",
        //                       style: TextStyle(
        //                         fontSize: 10,
        //                       ),
        //                     ),
        //                     chatArr[index]['unSeenMsgsCount'] != 0
        //                         ? CircleAvatar(
        //                             backgroundColor:
        //                                 Theme.of(context).colorScheme.primary,
        //                             radius: 9,
        //                             child: Center(
        //                               child: Text(
        //                                 "${chatArr[index]['unSeenMsgsCount']}",
        //                                 style: TextStyle(
        //                                   fontSize: 12,
        //                                   color: Theme.of(context)
        //                                       .colorScheme
        //                                       .onPrimary,
        //                                 ),
        //                               ),
        //                             ))
        //                         : Text(""),
        //                   ],
        //                 )),
        //             // Divider(
        //             // height: 5,
        //             // color: Colors.grey[50],
        //             // thickness: 1,
        //             // ),
        //           ],
        //         ),
        //       );
        //     }),

        );
  }
}
