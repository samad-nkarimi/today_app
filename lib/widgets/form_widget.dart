// ignore_for_file: file_names

// import 'package:flutter/cupertino.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:today/blocs/blocs.dart';
import 'package:today/database/database_provider.dart';
import 'package:today/utils/custom_calendar.dart';
import '../blocs/note/note.dart';
import '../models/models.dart';

class FormWidget extends StatefulWidget {
  static const routeName = '/form_widget';
  final bool isCalendarPage;
  final Note initialData;

  const FormWidget({
    Key? key,
    this.isCalendarPage = false,
    required this.initialData,
  }) : super(key: key);

  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  late Note note;
  int noteColorIndex = 0;
  String selectedDate = "select date";
  final subTitleController = TextEditingController();
  final titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    note = widget.initialData;
    titleController.text = note.title;
    subTitleController.text = note.subTitle;
    noteColorIndex = widget.initialData.labelColor;
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    subTitleController.dispose();
  }

  List<String> months = [
    "فروردین",
    "اردیبهشت",
    "خرداد",
    "تیر",
    "مرداد",
    "شهریور",
    "مهر",
    "آبان",
    "آذر",
    "دی",
    "بهمن",
    "اسفند"
  ];

  @override
  Widget build(BuildContext context) {
    // print("what day: ${widget.isCalendarPage}");
    print(widget.initialData);
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: AppBar(
                  title: const Text(
                    "یادداشت",
                    style: TextStyle(
                      fontFamily: "Negar",
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: IconButton(
                        onPressed: _clearNoteDitails,
                        icon: const Icon(Icons.clear_rounded),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        onPressed: _confirmNote,
                        icon: const Icon(Icons.done_rounded),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 90,
                      color: Colors.grey.withOpacity(0.1),
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      child: FutureBuilder<Notes>(
                        future: DatabaseProvider.historyNotes(),
                        builder: (context, ss) {
                          print(ss.connectionState);

                          if (ss.connectionState == ConnectionState.done) {
                            int length = 0;
                            List<Note> notes = [];
                            if (ss.hasData) {
                              notes = ss.data!.notesList;
                              length = notes.length;
                            }
                            return ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 5),
                              children: [
                                for (int i = 0; i < length; i++)
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        titleController.text = notes[i].title;
                                        subTitleController.text =
                                            notes[i].subTitle;
                                        noteColorIndex = notes[i].labelColor;
                                        print(noteColorIndex);
                                        print(notes[i].title);
                                        print(notes[i].subTitle);
                                      });
                                    },
                                    child: Card(
                                      elevation: 1,
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Container(
                                        margin: const EdgeInsets.all(5),
                                        width: 80,
                                        height: 80,
                                        alignment: Alignment.center,
                                        child: Text(notes[i].title),
                                      ),
                                    ),
                                  )
                              ],
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 5.0),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          // initialValue: note.title,
                          controller: titleController,
                          // autofocus: true,
                          maxLines: 1,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            labelText: "عنوان",
                            labelStyle: TextStyle(fontFamily: "Negar"),

                            // border: const OutlineInputBorder(
                            //   borderRadius: BorderRadius.all(Radius.circular(4.0)),
                            // ),
                            // label: const Text("عنوان", style: TextStyle(fontFamily: "ANegar")),
                          ),
                          validator: (title) {
                            note.setTitle(title!);
                            if (title == null || title.isEmpty) {
                              return "please enter some text!";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 5.0),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          // initialValue: note.subTitle,
                          controller: subTitleController,
                          maxLines: 4,
                          minLines: 1,
                          textInputAction: TextInputAction.done,
                          decoration: const InputDecoration(
                            labelText: "متن یادداشت",
                            labelStyle: TextStyle(fontFamily: "Negar"),
                            // border:  OutlineInputBorder(
                            //   borderRadius: BorderRadius.all(Radius.circular(4.0)),
                            // ),
                            // label:  Text("متن یادداشت", style: TextStyle(fontFamily: "ANegar")),
                            // filled: true,
                            // fillColor: Colors.grey,
                            // hintText: "salam",
                            // helperText: "hey",
                            // focusColor: Colors.blue.withOpacity(0.5),
                          ),
                          validator: (subTitle) {
                            note.setSubTitle(subTitle!);
                            // if (subTitle == null || subTitle.isEmpty) {
                            //   return "please enter some text!";
                            // }
                            return null;
                          },
                        ),
                      ),
                    ),
                    // if (widget.isCalendarPage)
                    //   CupertinoDatePicker(
                    //     minimumDate: DateTime.now(),
                    //     minuteInterval: 1,
                    //     mode: CupertinoDatePickerMode.date,
                    //     // initialDateTime: DateTime.now(),
                    //     onDateTimeChanged: (_) {},
                    //   ),
                    if (widget.isCalendarPage)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                showGeneralDialog<String>(
                                  barrierLabel: "label",
                                  barrierDismissible: true,
                                  barrierColor: Colors.black54,
                                  transitionDuration:
                                      const Duration(milliseconds: 300),
                                  context: context,
                                  pageBuilder: (context, anim1, anim2) =>
                                      customDialog(context),

                                  // transitionBuilder:
                                  //     (context, anim1, anim2, child) =>
                                  //         ScaleTransition(
                                  //   scale: Tween(begin: 0.0, end: 1.0)
                                  //       .animate(anim1),
                                  //   child: child,
                                  // ),
                                ).then((value) => print(value));
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.black12),
                              child: Text(
                                selectedDate,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const Text("تاریخ"),
                          ],
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 0; i < 6; i++) coloredItem(i),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        onPressed: _confirmNote,
                        child: const Text("ثبت"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget customDialog(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        height: 450,
        decoration: const BoxDecoration(
          color: Colors.blue,
          // image: DecorationImage(
          //   image: AssetImage(
          //       "assets/images/rose.jpg"),
          //   fit: BoxFit.cover,
          // ),
        ),
        // alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const CustomCalendar(),
            BlocBuilder<CalenderBloc, CalenderState>(builder: (context, state) {
              String date = "not selected";
              if (state is ContentRefreshedCalenderState) {
                date =
                    "${getDayName(state.dateDetails.startDay, state.selectedDay)}    ${state.selectedDay}    ${months[state.dateDetails.month]}";

                Future.delayed(Duration.zero).then((value) => setState(() {
                      selectedDate = date;
                      note.hour = "";
                      note.day = state.selectedDay;
                      note.dayName = getDayName(
                          state.dateDetails.startDay, state.selectedDay);
                      note.month = months[state.dateDetails.month];
                      note.year = state.dateDetails.year.toString();
                    }));
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(date, style: const TextStyle(color: Colors.white)),
              );
            }),
          ],
        ),
      ),
      // Container(
      //   // height: 350,
      //   width: 300,
      //   constraints: const BoxConstraints(minHeight: 200),
      //   // alignment: Alignment.center,
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       // Container(
      //       //   // color: Colors.red,
      //       //   margin: const EdgeInsets.only(left: 30), //change this value
      //       //   height: 50,
      //       //   alignment: Alignment.center,
      //       //   child: SvgPicture.asset("assets/images/logo.svg"),
      //       // ),
      //       Container(
      //         padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      //         alignment: Alignment.center,
      //         child: const Text(
      //           """this can help you to find what you are searching for.""",
      //           textAlign: TextAlign.center,
      //           style: TextStyle(color: Colors.purple),
      //         ),
      //       ),
      //       GestureDetector(
      //         onTap: () => Navigator.pop(context),
      //         child: Container(
      //           height: 50,
      //           alignment: Alignment.center,
      //           decoration: const BoxDecoration(
      //             borderRadius: BorderRadius.only(
      //               bottomLeft: Radius.circular(8.0),
      //               bottomRight: Radius.circular(8.0),
      //             ),
      //             color: Colors.green,
      //           ),
      //           child: const Text(
      //             "ok",
      //             style: TextStyle(fontSize: 20, color: Colors.white),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  String getDayName(int monthStartDay, String selectedDay) {
    int dayInWeek = (monthStartDay + int.parse(selectedDay)) % 7;
    String todayString = "";
    switch (dayInWeek) {
      case 1:
        todayString = "شنبه";
        break;
      case 2:
        todayString = "یکشنبه";
        break;
      case 3:
        todayString = "دوشنبه";
        break;
      case 4:
        todayString = "سه شنبه";
        break;
      case 5:
        todayString = "چهارشنبه";
        break;
      case 6:
        todayString = "پنجشنبه";
        break;
      default:
        todayString = "جمعه";
    }

    return todayString;
  }

  void _confirmNote() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context);

      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text("done!")),
      // );

      if (widget.initialData.id == "0") {
        //we are creating a new note
        note.isTodayNote = widget.isCalendarPage;
        note.setId(note.getRandomString());
        note.labelColor = noteColorIndex;

        BlocProvider.of<NoteBloc>(context).add(NewNoteWasSent(note));
      } else {
        // we are editting a note
        print(note);
        BlocProvider.of<NoteBloc>(context).add(NoteWasEdittedEvent(note));
      }
    }
  }

  void _clearNoteDitails() {
    setState(() {
      titleController.text = "";
      subTitleController.text = "";
      noteColorIndex = 0;
      selectedDate = "select date";
    });
  }

  // repeated
  Widget coloredItem(int i) {
    List<Color> colors = [
      Colors.red,
      Colors.amber,
      Colors.blue,
      Colors.orange,
      Colors.yellow,
      Colors.green,
    ];
    return InkWell(
      onTap: () {
        setState(() {
          noteColorIndex = i;
        });
        // BlocProvider.of<ThemeSettingBloc>(context).add(ThemeChanged(currentTheme));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: noteColorIndex == i ? 1 : 5,
        color: noteColorIndex == i ? Colors.white : colors[i],
        child: Container(
          margin: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: colors[i],
          ),
          height: 40,
          width: 40,
          child: noteColorIndex == i
              ? const Icon(Icons.done_rounded, color: Colors.white)
              : const Text(""),
        ),
      ),
    );
  }
}
