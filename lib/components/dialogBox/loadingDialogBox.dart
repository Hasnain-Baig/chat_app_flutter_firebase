import 'package:flutter/material.dart';

class LoadingDialogBox extends StatefulWidget {
  Map loadObj;
  LoadingDialogBox({required this.loadObj});

  @override
  State<LoadingDialogBox> createState() => _LoadingDialogBoxState();
}

class _LoadingDialogBoxState extends State<LoadingDialogBox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Container(
        width: MediaQuery.of(context).size.width * .3,
        padding: EdgeInsets.all(8),
        child: Center(
            child: Text("${widget.loadObj['action']}",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ))),
      ),
      content: Container(
          width: MediaQuery.of(context).size.width * .3,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          )),
    );
  }
}
