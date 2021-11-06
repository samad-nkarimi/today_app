import 'package:flutter/material.dart';

class MoodPage extends StatelessWidget {
  static const  routeName = "/mood_page";
  const MoodPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("here i am"),
      ),
    );
  }
}
