import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:today_app/Form_widget.dart';
import 'package:today_app/calender_page.dart';
import 'package:today_app/mood_page.dart';
import 'package:today_app/note_item_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        child: Container(
          color: Colors.white,
          height: double.infinity,
          child: Column(
            children: [
              Container(
                height: 150,
                color: Colors.red,
              ),
              Container(
                height: 300,
                child: ListView(
                  children: [
                    Container(color: Colors.amber, child: ListTile(title: const Text("title"), onTap: () {})),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(bottom: 50),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 100 / 2 + 20),
                  color: Colors.blue,
                  child: Image.asset(
                    "assets/images/sample_picture.jpg",
                    fit: BoxFit.fill,
                  ),
                  height: 200,
                  width: double.infinity,
                ),
                const NoteItem(labelColor: Colors.orange),
                const NoteItem(labelColor: Colors.green),
                const NoteItem(labelColor: Colors.red),
                // NoteItem(),
                ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                      ),
                      context: context,
                      builder: (context) {
                        return Container(
                          // height: 300,
                          color: Colors.transparent,
                          child: const FormWidget(),
                        );
                      },
                    );
                  },
                  child: const Text("add note"),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  height: 150,
                  width: double.infinity,
                  child: const Text(""),
                  color: Colors.grey,
                )
              ],
            ),
          ),
          Positioned(
            right: 20,
            top: 20,
            child: IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: SvgPicture.asset("assets/images/menu_icon.svg"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200 - 100 / 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(20.0),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.lightGreenAccent,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: const Text("40%", style: TextStyle(fontFamily: "ANegar")),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50.0),
                    // border: Border.all(width: 5.0,color: Colors.blue),

                    gradient: RadialGradient(
                      colors: [Colors.lightBlueAccent, Colors.blue.withOpacity(0.5)],
                      radius: .7,
                    ),
                  ),
                  child: const Text(
                    "1399.2.3 \n سه شنبه",
                    style: TextStyle(fontFamily: "Negar", color: Colors.white),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, MoodPage.routeName),
                  child: Container(
                    margin: const EdgeInsets.all(20.0),
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: InkWell(
        onTap: () => Navigator.pushNamed(context, CalendarPage.routeName),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(20.0),
          ),
          padding: const EdgeInsets.all(14.0),
          child: const Text(
            "تقویم",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: "Negar",
            ),
          ),
        ),
      ),
    );
  }
}
