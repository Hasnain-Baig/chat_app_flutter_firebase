import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ErrorDialogBox extends StatefulWidget {
  var dataError;
  ErrorDialogBox({required this.dataError});

  @override
  State<ErrorDialogBox> createState() => _ErrorDialogBoxState();
}

class _ErrorDialogBoxState extends State<ErrorDialogBox> {
  @override
  Widget build(BuildContext context) {
    // showDialog(
    //   context: context,
    //   builder: (context) {
    return AlertDialog(
      title: Container(
        width: MediaQuery.of(context).size.width * .3,
        padding: EdgeInsets.all(8),
        color: Theme.of(context).colorScheme.primary,
        child: Center(
            child: Text(
          "ERROR",
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        )),
      ),
      content: Container(
          width: MediaQuery.of(context).size.width * .3,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${widget.dataError}",
                style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSecondary),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.primary)),
                onPressed: () {
                  Navigator.of(context).pop();
                  // addItemDialogBox();
                },
                child: Text("OK"),
              )
            ],
          )),
    );
    //   },
    // );
  }
}
