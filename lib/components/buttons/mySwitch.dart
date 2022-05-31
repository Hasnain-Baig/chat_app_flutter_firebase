import 'package:flutter/material.dart';
import '../theme/myTheme.dart';

class MySwitch extends StatefulWidget {
  const MySwitch({Key? key}) : super(key: key);

  @override
  State<MySwitch> createState() => _MySwitchState();
}

class _MySwitchState extends State<MySwitch> {
  bool isDarkTheme = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        currentTheme.currentMode == ThemeMode.light
            ? Text("Light Theme")
            : Text("Dark Theme"),
        Switch(
          activeColor: Theme.of(context).colorScheme.onBackground,
          inactiveThumbColor: Theme.of(context).colorScheme.onBackground,
          value: isDarkTheme,
          onChanged: (value) {
            setState(() {
              isDarkTheme = value;
              currentTheme.toggleTheme();
            });
          },
        ),
      ],
    );
  }
}
