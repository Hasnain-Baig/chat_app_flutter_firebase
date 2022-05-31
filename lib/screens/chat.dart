import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/dialogBox/errorDialogBox.dart';
import '../components/dialogBox/loadingDialogBox.dart';
import 'chatUserInfo.dart';

class ChatScreen extends StatefulWidget {
  final Map data;
  ChatScreen({required this.data});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var msg = "";
  List msgsArr = [];
  var msgController = TextEditingController();
  TimeOfDay time = TimeOfDay.now();
  var chatId;
  var msgDetails = {};
  var loadObj = {"isLoading": false, "action": ""};

// Map chatMap={};
// List chatMsgs=[];
  final ScrollController myScrollController = ScrollController();

  void initState() {
    // chatMap=getChat() as Map;
    getChat();
    print("CHAT MSGS INIT STATE===========>${msgsArr}");
    print(
        "myScrollController.hasClients===========>${myScrollController.hasClients}");
    // WidgetsBinding.instance?.addPostFrameCallback((_) {
    //   scrollDown();
    //   //code will run when widget rendering complete
    // });
    super.initState();
  }

// This is what you're looking for!
  scrollDown() {
    print(
        "myScrollController.hasClients===========>${myScrollController.hasClients}");
    if (myScrollController.hasClients) {
      final position = myScrollController.position.maxScrollExtent;
      print("JUMP++++++++>${position}");
      myScrollController.jumpTo(position);
    }
  }

  getChat() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    if (widget.data["userData"]["uId"]
            .compareTo(widget.data["chatUserData"]["uId"]) ==
        -1) {
      chatId =
          "${widget.data["userData"]["uId"]}_${widget.data["chatUserData"]["uId"]}";
    } else {
      chatId =
          "${widget.data["chatUserData"]["uId"]}_${widget.data["userData"]["uId"]}";
    }

    DocumentSnapshot ds = await db.collection("chats").doc(chatId).get();
    if (ds.exists) {
      msgsArr = ds.get('chat');
    }
    // var chatArr = await db
    //     .collection('chats')
    //     .doc(chatId)
    //     .get();
    //       Map myMap = chatArr.data() as Map;
    //   print("map data------>${myMap}");
    // print("CHATARR------------->${chatArr}");
    //       return myMap;
  }

  msgSavedToFirebase() async {
    try {
      FirebaseFirestore db = FirebaseFirestore.instance;
      var msg = msgController.text;

      if (widget.data["userData"]["uId"]
              .compareTo(widget.data["chatUserData"]["uId"]) ==
          -1) {
        chatId =
            "${widget.data["userData"]["uId"]}_${widget.data["chatUserData"]["uId"]}";
      } else {
        chatId =
            "${widget.data["chatUserData"]["uId"]}_${widget.data["userData"]["uId"]}";
      }

      print("chatId====>${chatId}");
      if (msg != "") {
        msgDetails = {
          "to": widget.data["userData"]["fullname"],
          "from": widget.data["chatUserData"]["fullname"],
          "msg": msg,
          // "time":TimeOfDay.now()
          // "date":
        };
        setState(() {
          // chatMsgs.add(msgDetails);
          msgsArr.add(msgDetails);
          msg = "";
          msgController.clear();
        });
      }
      await db.collection("chats").doc(chatId).set({
        "chat": msgsArr,
        // "chat": chatMsgs,
      });

      print("Chat Added succesfully....");
      print(
          "myScrollController.hasClients===========>${myScrollController.hasClients}");
      //  Future.delayed.call(scrollDown());
      //  then(scrollDown());
      //  scrollDown();
      // var chatArr = FirebaseFirestore.instance
      //     .collection('chats')
      //     .doc("${widget.data["myId"]}_${widget.data["uId"]}")
      //     .collection('chat')
      //     .get();
      // print("ChatArr firebase========>${chatArr}");
    } catch (e) {
      print("Error ${e}");
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("error:${e}"),
            );
          });
    }
  }

  // msgSavedToArr() {
  //   if (msg != "") {
  //     setState(() {
  //       msgsArr.add(msg);
  //       msg = "";
  //       msgController.clear();
  //     });
  //   }
  // }

  deleteAllChat() async {
    try {
      setState(() {
        loadObj["isLoading"] = true;
        loadObj["action"] = "Deleting all chat";
      });
      FirebaseFirestore db = FirebaseFirestore.instance;
      await db.collection("chats").doc(chatId).delete();
      setState(() {
        msgsArr = [];
      });
      setState(() {
        loadObj["isLoading"] = false;
        loadObj["action"] = "";
      });
    } catch (e) {
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
    // if (widget.data["userData"]["uId"]
    //         .compareTo(widget.data["chatUserData"]["uId"]) ==
    //     -1) {
    //   chatId =
    //       "${widget.data["userData"]["uId"]}_${widget.data["chatUserData"]["uId"]}";
    // } else {
    //   chatId =
    //       "${widget.data["chatUserData"]["uId"]}_${widget.data["userData"]["uId"]}";
    // }
    print("------------------>$chatId");
  }

  final Stream<QuerySnapshot> _chatStream =
      FirebaseFirestore.instance.collection('chats').snapshots();

  @override
  Widget build(BuildContext context) {
// getChat();

    print("home to chat===>${widget.data}");
    // print("chat Map===>${chatMap}");
    print("chat Msgs===>${msgsArr}");
    return Scaffold(
      appBar: AppBar(
          leadingWidth: 75,
          actions: [
            // Icon(Icons.video_call),
            // SizedBox(width: 10),
            // Icon(Icons.add_call),
            // SizedBox(width: 10),
            // ignore: prefer_const_constructors

            PopupMenuButton(
                elevation: 40,
                onSelected: (item) {
                  // setState(() {
                  // _selectedMenu = item.name;
                  print("${item}");

                  // });
                },
                itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text(
                          "Delete All Chat",
                          style: TextStyle(fontSize: 12),
                        ),
                        value: "deleteAllChat",
                        onTap: () {
                          deleteAllChat();
                        },
                      ),
                    ]),

            // PopupMenuButton(
            //   onSelected: handleClick,
            //   itemBuilder: (BuildContext context) {
            //     return {'Logout', 'Settings'}.map((String choice) {
            //       return PopupMenuItem(
            //         value: choice,
            //         child: Text(choice),
            //       );
            //     }).toList();
            //   },
            // ),

            //   GestureDetector(
            //       onTap: scrollDown, child: Icon(Icons.more_vert_sharp)),
          ],

          // backgroundColor: Colors.green,
          leading: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChatUserInfoScreen(
                          data: widget.data["chatUserData"])));
            },
            child: Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back)),
                SizedBox(
                  width: 5,
                ),
                CircleAvatar(
                  backgroundImage: AssetImage("assets/images/profile.png"),
                ),
              ],
            ),
          ),
          title: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChatUserInfoScreen(
                          data: widget.data["chatUserData"])));
            },
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${widget.data['chatUserData']['fullname']}"),
                      // Text(
                      //   "online",
                      //   style: TextStyle(fontSize: 12),
                      // ),
                    ]),
              ],
            ),
          )),
      body: loadObj["isLoading"] == true
          ? LoadingDialogBox(loadObj: loadObj)
          : Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: _chatStream,
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          print("state==========>${snapshot.connectionState}");
                          if (snapshot.hasError) {
                            return Text('Something went wrong');
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }

                          return ListView(
                            // physics: NeverScrollableScrollPhysics(),
                            // scrollDirection: Axis.vertical,
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data()! as Map<String, dynamic>;
                              var chatId = document.id;
                              print("data======>${data}");

                              return chatId.contains(
                                          widget.data['userData']['uId']) &&
                                      chatId.contains(
                                          widget.data['chatUserData']['uId'])
                                  ? ListView.builder(
                                      // reverse: true,
                                      controller: myScrollController,
                                      shrinkWrap: true,
                                      primary: false,
                                      // scrollDirection: Axis.vertical,
                                      itemCount: data['chat'].length,
                                      itemBuilder: (context, index) {
                                        print(
                                            "ITEM BUILDER CONTEXT=========>${context}");
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment: data["chat"]
                                                      [index]["to"] ==
                                                  widget.data["userData"]
                                                      ["fullname"]
                                              ? CrossAxisAlignment.end
                                              : CrossAxisAlignment.start,
                                          children: [
                                            // SizedBox(height: 10),
                                            Container(
                                                constraints: BoxConstraints(
                                                  maxWidth:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          .8,
                                                  minWidth:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          .3,
                                                ),
                                                // width:
                                                //     MediaQuery.of(context).size.width*.6,
                                                // MediaQuery.of(context)
                                                // .size
                                                // .width *
                                                // 0.7,
                                                padding: EdgeInsets.all(8),
                                                margin: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color: data["chat"][index]
                                                              ["to"] ==
                                                          widget.data[
                                                                  "userData"]
                                                              ["fullname"]
                                                      ? Theme.of(context)
                                                          .colorScheme
                                                          .primary
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .primaryVariant,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5)),
                                                ),
                                                child: Column(children: [
                                                  Container(
                                                      child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      data['chat'][index]
                                                          ["msg"],
                                                      style: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onPrimary,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  )),
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Text(
                                                          time.period ==
                                                                  DayPeriod.pm
                                                              ? "${time.hourOfPeriod.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} p.m"
                                                              : "${time.hourOfPeriod.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} a.m",
                                                          style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .onPrimary,
                                                            fontSize: 11,
                                                          ),
                                                        ),
                                                        Icon(
                                                          Icons.check,
                                                          size: 11,
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .onPrimary,
                                                        ),
                                                      ]),
                                                ])),
                                          ],
                                        );
                                      })
                                  : SizedBox(
                                      height: 0,
                                    );
                            }).toList(),
                          );
                        })),

                // for(var i=msgsArr.length;i>=0;i--){
                //   return Text(msgsArr[i]);
                // }
                // ListView.builder(itemCount:msgsArr.length,itemBuilder:(builder,index){
                //     return ListTile(
                //       title: Text(msgsArr[index]),
                //     );
                // }),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  color: Theme.of(context).colorScheme.secondaryVariant,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * .82,
                        height: 58,
                        child: TextField(
                          maxLines: 3,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),

                          // cursorColor:
                          // Colors.green,
                          // autofocus: true,

                          controller: msgController,
                          decoration: InputDecoration(
                            fillColor: Theme.of(context).colorScheme.onPrimary,
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            filled: true,
                            hintText: ("Type a message..."),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: (value) {
                            msg = value;
                          },
                        ),
                      ),
                      Container(
                        // width: MediaQuery.of(context).size.width * .15,
                        // height: MediaQuery.of(context).size.height * .08,
                        width: 58,
                        height: 58,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                // backgroundColor:
                                // MaterialStateProperty.all(Colors.green),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.0),
                              // side: BorderSide(color: Colors.red)
                            ))),
                            onPressed: msgSavedToFirebase,
                            child: Icon(Icons.send)),
                      )
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
