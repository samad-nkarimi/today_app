import 'package:flutter/material.dart';

class CalenderPage extends StatefulWidget {
  static const routeName = "/calender_route";
  const CalenderPage({Key? key}) : super(key: key);

  @override
  _CalenderPageState createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: const Text("test"),
      ),
    );
  }
}
