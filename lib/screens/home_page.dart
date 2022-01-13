import 'dart:convert';
import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:today/utils/date_converter.dart';
import 'package:today/widgets/form_widget.dart';

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
  final double showBoardSize = 130;
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
    // TODO: implement initState
    super.initState();
    // WidgetsBinding.instance!.addPostFrameCallback((_) async {
    //   await loadJson();
    // });
    this.loadJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const DrawerWidget(),
      body: Builder(builder: (BuildContext context) {
        return Container(
          color: Colors.blue.shade100,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                BlocBuilder<NoteBloc, NoteState>(
                  builder: (context, state) {
                    List<Note> notes = state.notes.getTodayNotes;
                    // print("notes: $notes");
                    // print("state: $state");
                    // if(state is NewNoteIsAdded)
                    // noteCount++;
                    return Container(
                      // color: Theme.of(context).scaffoldBackgroundColor,
                      padding: EdgeInsets.only(bottom: showBoardSize / 2),
                      decoration: BoxDecoration(
                        // color: Colors.red,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: const [0.5, 1.0],
                          colors: [
                            // Colors.green,
                            // Colors.red,
                            Theme.of(context).scaffoldBackgroundColor,
                            Theme.of(context)
                                .scaffoldBackgroundColor
                                .withOpacity(0.3),
                          ],
                        ),
                      ),
                      child: Column(
                        children: [
                          topPicture(),
                          SizedBox(height: showBoardSize / 2 + 30),
                          if (notes.isEmpty) noNoteWidget(),
                          for (int i = 0; i < notes.length; i++)
                            NoteItem(notes[i]),
                          addNoteWidgetButton(),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 30),
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
                  padding: EdgeInsets.only(
                      top: topPictureHeight - showBoardSize / 2),
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
                        child: Text(
                          "${(getHourPercent() * 100).toStringAsFixed(0)}%",
                          style: const TextStyle(fontFamily: "ANegar"),
                        ),
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100.0),
                            clipBehavior: Clip.antiAlias,
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                alignment: Alignment.center,
                                height: showBoardSize,
                                width: showBoardSize,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20.0),
                                decoration: BoxDecoration(
                                  // color: Colors.blue.withOpacity(.5),
                                  borderRadius: BorderRadius.circular(100.0),
                                  // border: Border.all(width: 5.0,color: Colors.blue),

                                  gradient: RadialGradient(
                                    colors: [
                                      Colors.purple.withOpacity(0.3),
                                      Colors.blue.withOpacity(0.3)
                                    ],
                                    radius: .8,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      getWeekdayInShamsi(),
                                      style: const TextStyle(
                                        fontFamily: "Negar",
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      getTodayDateStringInShamsi(),
                                      style: const TextStyle(
                                        fontFamily: "Negar",
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          ForPainting(
                            radius: showBoardSize / 2,
                            fillPercent: getHourPercent(),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, MoodPage.routeName),
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
      // margin: const EdgeInsets.only(bottom: 100 / 2 + 20),
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
      height: topPictureHeight,
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
          isScrollControlled: true,
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
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "افزودن یادداشت",
            style: Theme.of(context).textTheme.button,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Icon(Icons.add_circle_outline),
          ),
        ],
      ),
    );
  }

  double getHourPercent() {
    int hour = DateTime.now().hour;
    int min = DateTime.now().minute;
    int totalMinute = 24 * 60;
    int spendedMinute = hour * 60 + min;
    double hourPercent = 1.0 - spendedMinute / totalMinute;
    return hourPercent;
  }
}
