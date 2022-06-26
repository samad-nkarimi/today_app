import 'dart:convert';
import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:today/size/short_methods.dart';
import 'package:today/utils/date_converter.dart';
import 'package:today/widgets/add_note_button_widget.dart';
import 'package:today/widgets/floating_button_widget.dart';
import 'package:today/screens/form_page.dart';
import 'package:today/widgets/hour_widget.dart';
import 'package:today/widgets/remaining_percent_widget.dart';
import 'package:today/widgets/today_info_widget.dart';

import '../blocs/note/note.dart';
import 'calender_page.dart';
import '../utils/draw_arc.dart';
import 'drawer_widget.dart';
import '../models/models.dart';
import 'mood_page.dart';
import '../widgets/note_item_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // int noteCount = 0;
  final double showBoardSize = rw(140, 160);
  final double topPictureHeight = 300;

  Future<void> loadJson() async {
    var data = await rootBundle.loadString('assets/json/shamsi_holiday.json');
    List<dynamic> jsonResult = jsonDecode(data);
    List<String> holidayTitles = [];
    List<String> holidayDates = [];
    for (var i = 0; i < jsonResult.length; i++) {
      String title =
          jsonResult.elementAt(i)["title"] ?? "oooooooooooooooooooooooooo";
      String date = jsonResult.elementAt(i)["date"] ?? "1111111111111111";
      holidayDates.add(date);
      title = title.trim();
      holidayTitles.add(title);

      // final wordObject =
      //     Word(title, meaning, definition, "no ex1", "no ex2", "no ex3");
      // wordObjectList.add(wordObject);
      // WordsDatabase().add(wordObject);
      // print('$i: $word');
    }

    print(holidayTitles);
    print(holidayDates);
    // print(jsonResult.length);
    // print(wordObjectList);
    // print(wordObjectList.length);
    // print("finished");
  }

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance!.addPostFrameCallback((_) async {
    //   await loadJson();
    // });
    // this.loadJson();
  }

  @override
  Widget build(BuildContext context) {
    // print((DateTime.now().difference(DateTime(2021, 3, 21)).inHours) % 24.0);
    print((DateTime.now().difference(DateTime(2021, 3, 21)).inDays) - 354);
    print(gregorianToJalali(2022, 3, 23));
    return SafeArea(
      child: Scaffold(
        endDrawer: const DrawerWidget(),
        body: Builder(builder: (BuildContext context) {
          return Container(
            // color: Colors.blue.shade100,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/earth.jpg"),
                fit: BoxFit.cover,
              ),
              gradient: RadialGradient(
                // begin: Alignment.topLeft,
                // end: Alignment.bottomRight,
                center: Alignment.topLeft,
                radius: 1.4,
                stops: [0.5, 1.0],
                colors: [
                  Color(0xFFB2AFFF),
                  Color(0xFF883AD9),
                  // Theme.of(context).scaffoldBackgroundColor,
                  // Theme.of(context).scaffoldBackgroundColor.withOpacity(0.3),
                ],
              ),
            ),
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  BlocBuilder<NoteBloc, NoteState>(
                    builder: (context, state) {
                      List<Note> notes = state.notes.getTodayNotes;
                      print("notes: $notes");
                      print("state: $state");
                      // if(state is NewNoteIsAdded)
                      // noteCount++;
                      return Container(
                        // color: Theme.of(context).scaffoldBackgroundColor,
                        padding: EdgeInsets.only(bottom: showBoardSize / 2),
                        // decoration: BoxDecoration(
                        //   // color: Colors.red,
                        //   gradient: LinearGradient(
                        //     begin: Alignment.topLeft,
                        //     end: Alignment.bottomRight,
                        //     stops: const [0.5, 1.0],
                        //     colors: [
                        //       // Colors.green,
                        //       // Colors.red,
                        //       Theme.of(context).scaffoldBackgroundColor,
                        //       Theme.of(context)
                        //           .scaffoldBackgroundColor
                        //           .withOpacity(0.3),
                        //     ],
                        //   ),
                        // ),

                        child: Column(
                          children: [
                            topPicture(),
                            // SizedBox(height: showBoardSize / 2 + 30),
                            // if (notes.isEmpty) noNoteWidget(),
                            // const SizedBox(height: 60),
                            addNoteWidgetButton(),
                            Container(
                              // height: 400,
                              child: ListView(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                reverse: true,
                                children: [
                                  for (int i = 0; i < notes.length; i++)
                                    NoteItem(notes[i]),
                                ],
                              ),
                            ),

                            // Container(
                            //   margin: const EdgeInsets.symmetric(
                            //       horizontal: 30, vertical: 30),
                            //   height: 150,
                            //   width: double.infinity,
                            //   child: const Text(""),
                            //   color: Colors.grey,
                            // )
                          ],
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 100,
                      // top: topPictureHeight - showBoardSize / 2,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const RemaningPercentWisget(),
                        TodayInfoWidget(showBoardSize: showBoardSize),
                        const HourWidget(),
                      ],
                    ),
                  ),
                  // Positioned(
                  //   right: 0,
                  //   top: 0,
                  //   child: menuButton(),
                  // ),
                ],
              ),
            ),
          );
        }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            CustomFloatingButton(page: pageid.today),
            CustomFloatingButton(page: pageid.menu),
            // menuButton(),
          ],
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
      // margin: const EdgeInsets.only(bottom: 100 / 2 + 20),
      // color: Colors.blue,
      // child: Image.asset(
      //   "assets/images/winter.jpg",
      //   fit: BoxFit.fill,
      // ),

      //  ShaderMask(
      //   shaderCallback: (rect) {
      //     return const LinearGradient(
      //       begin: Alignment.topCenter,
      //       end: Alignment.bottomCenter,
      //       stops: [
      //         0.9,
      //         1.1,
      //       ],
      //       colors: [Colors.black, Colors.transparent],
      //     ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
      //   },
      //   blendMode: BlendMode.dstIn,
      //   child: Image.asset(
      //     "assets/images/fall.gif",
      //     fit: BoxFit.fill,
      //   ),
      // ),
      height: topPictureHeight,
      width: double.infinity,
    );
  }

  Widget menuButton() {
    return Positioned(
      right: 0,
      top: 20,
      child: Builder(builder: (context) {
        return Container(
          margin: const EdgeInsets.only(right: 10),
          // color: Colors.blue,
          height: 70,
          width: 70,
          child: IconButton(
            onPressed: () => Scaffold.of(context).openEndDrawer(),
            icon: SvgPicture.asset("assets/images/menu_icon.svg"),
          ),
        );
      }),
    );
  }

  Widget addNoteWidgetButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, FormPage.routeName);
      },
      child: AddNoteButton(context: context),
    );
  }
}
