// import 'package:country_code_picker/country_code_picker.dart';
// import 'package:country_list_pick/country_list_pick.dart';
// import 'package:country_picker/country_picker.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:news_app_mini_hackathon_flutter/components/MySnackBar.dart';
// import 'package:firebase_core/firebase_core.dart';

import '../components/dialogBox/errorDialogBox.dart';
import '../components/dialogBox/loadingDialogBox.dart';
import '../components/buttons/mySwitch.dart';
import 'login.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var hidePass = true;
  var hideConfPass = true;
  // var selectedVal = '0';
  // var checkBoxVal = false;

  var loadObj = {"isLoading": false, "action": ""};

  TextEditingController fullNameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController myDOBController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confPasswordController = TextEditingController();

  var phoneNumCode;

  var focusColor = Color(0xFFBDBDBD);

  hidePassword() {
    setState(() {
      hidePass = !hidePass;
    });
  }

  hideConfPassword() {
    setState(() {
      hideConfPass = !hideConfPass;
    });
  }

  getDOB() async {
    var initialDate = DateTime(DateTime.now().year - 10);
    var newDate = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime(DateTime.now().year - 1),
      initialDate: initialDate,
      helpText: "SELECT DATE OF BIRTH",
    );
    setState(() {
      if (newDate != null) {
        myDOBController.text =
            "${newDate.day}/${newDate.month}/${newDate.year}";
      }
    });
  }

  containerFocused() {
// Color(0xFFEC407A)
    print("TAPPED");
    setState(() {
      focusColor = Colors.pink;
    });
  }

  getCountry(countryName) {
    print("=========>${countryName}");

    countryController.text = countryName;
  }

  getCountryCode(countryCode) {
    print(countryCode);
    phoneNumCode = countryCode;
  }

  signup() async {
    print(
        "\nName:${fullNameController.text}\nGender:${genderController.text}\nDOB:${myDOBController.text}\nCountry:${countryController.text}\nEmail:${emailController.text}\nPhone:${phoneNumCode} ${phoneNumController.text}\nPass:${passwordController.text}\nConfPass:${confPasswordController.text}");
    if (fullNameController.text != "" ||
        genderController.text != "" ||
        myDOBController.text != "" ||
        countryController.text != "" ||
        emailController.text != "" ||
        phoneNumCode != "" ||
        phoneNumController.text != "" ||
        passwordController.text != "" ||
        confPasswordController.text != "") {
      setState(() {
        loadObj["isLoading"] = true;
        loadObj["action"] = "signing up";
      });

      if (passwordController.text != confPasswordController.text) {
        showDialog(
            context: context,
            builder: (context) {
              return ErrorDialogBox(
                  dataError: "Password and Confirm Password is not Matched");
            });
      }

      FirebaseFirestore db = FirebaseFirestore.instance;
      FirebaseAuth auth = FirebaseAuth.instance;
      var fullName = fullNameController.text;
      var email = emailController.text;
      var password = passwordController.text;
      var gender = genderController.text;
      var dob = myDOBController.text;
      var country = countryController.text;
      var phone = "${phoneNumCode}${phoneNumController.text}";

      try {
        UserCredential user = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await db.collection("users").doc(user.user!.uid).set({
          "fullname": fullName,
          "gender": gender,
          "date of birth": dob,
          "country": country,
          "phone number": phone,
          "email": email,
          "password": password,
          "uId": user.user!.uid
        });

        print("User Registered succesfully....");
        setState(() {
          loadObj["isLoading"] = false;
          loadObj["action"] = "";
        });

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
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
        // return AlertBox();
        //   final snackBar=SnackBar(
        //     content: Text('Error: ${e}'),
        //     action: SnackBarAction(
        //       label: 'Undo',
        //       onPressed: () {
        //         // Some code to undo the change.
        //       },
        //     ),
        //   );
      }
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return ErrorDialogBox(
                dataError: "Empty Input Fields! Kindly Fill to Signup");
          });
    }
  }
  // void _showDialog() {
  //   // flutter defined function
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       // return object of type Dialog
  //       return AlertDialog(
  //         title: new Text("Alert Dialog title"),
  //         content: new Text("Alert Dialog body"),
  //         actions: <Widget>[
  //           // usually buttons at the bottom of the dialog
  //           new FlatButton(
  //             child: new Text("Close"),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SIGN UP"),
        actions: [MySwitch()],
        // backgroundColor: Colors.deepOrange,
      ),
      body: loadObj["isLoading"] == true
          ? LoadingDialogBox(loadObj: loadObj)
          : SingleChildScrollView(
              child: Center(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextField(
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          controller: fullNameController,
                          // autofocus: true,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              border: OutlineInputBorder(),
                              hintText: 'Full Name'),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextField(
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          controller: genderController,
                          // autofocus: true,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.male),
                              border: OutlineInputBorder(),
                              hintText: 'Gender'),
                        ),
                      ), // child: TextField(
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          controller: myDOBController,
                          // autofocus: true,
                          decoration: InputDecoration(
                              prefixIcon: GestureDetector(
                                child: Icon(Icons.calendar_today),
                                onTap: getDOB,
                              ),
                              border: OutlineInputBorder(),
                              hintText: 'Date of Birth'),
                        ),
                      ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          // containerFocused()
                          // ,
                          // ;
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                              // borderRadius: ,
                              border: Border.all(
                            color: focusColor,
                            width: 1,
                          )),
                          child: TextField(
                              keyboardType: TextInputType.text,
                              maxLines: 1,
                              controller: countryController,
                              autofocus: true,
                              decoration: InputDecoration(
                                prefixIcon: CountryCodePicker(
                                  // initialSelection: "Pakistan",
                                  alignLeft: true,
                                  showCountryOnly: true,
                                  showOnlyCountryWhenClosed: true,
                                  showFlag: true,

                                  // onInit: (country) {
                                  //   getCountry(country);
                                  // },
                                  onChanged: (country) {
                                    getCountry(country.name);
                                  },
                                  boxDecoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  searchDecoration: InputDecoration(
                                    hintText: " Select Country",
                                  ),
                                ),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          maxLines: 1,
                          controller: emailController,
                          // autofocus: true,
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
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          // autofocus: true,
                          controller: phoneNumController,
                          decoration: InputDecoration(
                              prefixIcon: CountryCodePicker(
                                // showCountryOnly: true,
                                onInit: (countryCode) {
                                  getCountryCode(countryCode);
                                },
                                onChanged: (countryCode) {
                                  getCountryCode(countryCode);
                                },
                                boxDecoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                searchDecoration: InputDecoration(
                                  hintText: " Select Country Code",
                                ),
                              ),
                              border: OutlineInputBorder(),
                              hintText: 'Phone Number'),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextField(
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          controller: passwordController,
                          // autofocus: true,
                          obscureText: hidePass, //for passwords to hide
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: GestureDetector(
                                onTap: hidePassword,
                                child: hidePass
                                    ? Icon(Icons.visibility)
                                    : Icon(Icons.visibility_off),
                              ),
                              border: OutlineInputBorder(),
                              hintText: 'Password'),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextField(
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          controller: confPasswordController,

                          // autofocus: true,
                          obscureText: hideConfPass, //for passwords to hide
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: GestureDetector(
                                onTap: hideConfPassword,
                                child: hideConfPass
                                    ? Icon(Icons.visibility)
                                    : Icon(Icons.visibility_off),
                              ),
                              border: OutlineInputBorder(),
                              hintText: 'Confirm Password'),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: signup,
                          child: Text("SIGN UP"),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
