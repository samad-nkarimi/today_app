import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:today_app/Form_widget.dart';
import 'package:today_app/blocs/note/note.dart';
import 'package:today_app/calender_page.dart';
import 'package:today_app/draw_arc.dart';
import 'package:today_app/drawer_widget.dart';
import 'package:today_app/models/models.dart';
import 'package:today_app/models/notes.dart';
import 'package:today_app/mood_page.dart';
import 'package:today_app/note_item_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int noteCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const DrawerWidget(),
      body: Builder(builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Stack(
            children: [
              BlocBuilder<NoteBloc, NoteState>(
                builder: (context, state) {
                  Notes notes = state.notes;
                  // print("state $notes");
                  // if(state is NewNoteIsAdded)
                    // noteCount++;
                  return Container(
                    color: Colors.white,
                    padding: const EdgeInsets.only(bottom: 50),
                    child: Column(
                      children: [
                        topPicture(),
                        if (notes.getNotesCount == 0) noNoteWidget(),
                        for (int i = 0; i < notes.getNotesCount; i++)
                           NoteItem(
                            notes.notesList[i].title,
                            notes.notesList[i].subTitle,
                            labelColor: Colors.orange,
                          ),
                        addNoteWidgetButton(),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                          height: 150,
                          width: double.infinity,
                          child: const Text(""),
                          color: Colors.grey,
                        )
                      ],
                    ),
                  );
                },
              ),
              menuButton(),
              Padding(
                padding: const EdgeInsets.only(top: 300 - 100 / 2),
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
                    Stack(alignment: Alignment.center, children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        clipBehavior: Clip.antiAlias,
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            alignment: Alignment.center,
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              // color: Colors.blue.withOpacity(.5),
                              borderRadius: BorderRadius.circular(50.0),
                              // border: Border.all(width: 5.0,color: Colors.blue),

                              gradient: RadialGradient(
                                colors: [Colors.purple.withOpacity(0.3), Colors.blue.withOpacity(0.3)],
                                radius: .8,
                              ),
                            ),
                            child: const Text(
                              "1399.2.3 \n سه شنبه",
                              style: TextStyle(fontFamily: "Negar", color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const ForPainting(),
                    ]),
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
            ],
          ),
        );
      }),
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

  Widget noNoteWidget() {
    return Container(
      height: 50,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.grey.withOpacity(0.2),
      ),
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(5),
        dashPattern: const [10, 5],
        color: Colors.grey,
        strokeWidth: 1.5,
        child: Container(
          alignment: Alignment.center,
          child: const Text("no note"),
        ),
      ),
    );
  }

  Widget topPicture() {
    return Container(
      margin: const EdgeInsets.only(bottom: 100 / 2 + 20),
      // color: Colors.blue,
      child: ShaderMask(
        shaderCallback: (rect) {
          return const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [
              0.9,
              1.1,
            ],
            colors: [Colors.black, Colors.transparent],
          ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
        },
        blendMode: BlendMode.dstIn,
        child: Image.asset(
          "assets/images/fall.gif",
          fit: BoxFit.fill,
        ),
      ),
      height: 300,
      width: double.infinity,
    );
  }

  Widget menuButton() {
    return Positioned(
      right: 0,
      top: 20,
      child: Container(
        height: 70,
        width: 70,
        child: IconButton(
          onPressed: () {
            print("pressed");
            Scaffold.of(context).openEndDrawer();
          },
          icon: SvgPicture.asset("assets/images/menu_icon.svg"),
        ),
      ),
    );
  }

  Widget addNoteWidgetButton() {
    return ElevatedButton(
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
    );
  }
}
