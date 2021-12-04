import 'package:flutter/material.dart';
import 'package:today_app/drawer_widget.dart';
import 'package:today_app/slider.dart';

class MoodPage extends StatelessWidget {
  static const routeName = "/mood_page";

  const MoodPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const DrawerWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 5,
                child: SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: Center(
                    child: Container(
                      height: 15,
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      // width: 150,
                      // color: Colors.blue,
                      // constraints: const BoxConstraints(maxHeight: 20),
                      // margin: const EdgeInsets.only(right: 40),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.black12,
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(right: 40),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          // color: Colors.green,
                          gradient: LinearGradient(
                            end: Alignment.centerLeft,
                            begin: Alignment.centerRight,
                            colors: [Colors.green, Colors.greenAccent],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 5,
                child: SizedBox(
                  height: 150,
                  child: Row(
                    children: [
                      for (int i = 0; i < 7; i++)
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            margin: EdgeInsets.only(top: i * 10, bottom: 75, right: 1),
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                end: Alignment.topCenter,
                                begin: Alignment.bottomCenter,
                                colors: [Colors.green, Colors.greenAccent],
                              ),
                            ),
                            // width: 30,
                            height: double.infinity,
                            child: Text(
                              i.toString(),
                              style: const TextStyle(color: Colors.blueAccent),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 5,
                child: Container(
                  height: 150,
                  child: Center(child: SliderHeightWidget()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
