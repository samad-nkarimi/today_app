// ignore_for_file: file_names

// import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

  @override
  void initState() {
    super.initState();
    note = widget.initialData;
    // noteColorIndex = widget.initialData.labelColor.;
  }

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
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                          onPressed: _confirmNote,
                          icon: const Icon(Icons.save)),
                    )
                  ],
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 5.0),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          initialValue: widget.initialData.title,
                          // autofocus: true,
                          maxLines: 1,
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
                          initialValue: widget.initialData.subTitle,
                          maxLines: 4,
                          minLines: 2,
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
                            if (subTitle == null || subTitle.isEmpty) {
                              return "please enter some text!";
                            }
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              showGeneralDialog(
                                barrierLabel: "label",
                                barrierDismissible: true,
                                barrierColor: Colors.black54,
                                transitionDuration:
                                    const Duration(milliseconds: 300),
                                context: context,
                                pageBuilder: (context, anim1, anim2) =>
                                    customDialog(context),
                                //     Container(
                                //   height: 300,
                                //   decoration: const BoxDecoration(
                                //     color: Colors.amber,
                                //     // image: DecorationImage(
                                //     //   image: AssetImage(
                                //     //       "assets/images/rose.jpg"),
                                //     //   fit: BoxFit.cover,
                                //     // ),
                                //   ),
                                //   // alignment: Alignment.bottomCenter,
                                //   // child: const CustomCalendar(),
                                // ),
                                transitionBuilder:
                                    (context, anim1, anim2, child) =>
                                        ScaleTransition(
                                  scale: Tween(begin: 0.0, end: 1.0)
                                      .animate(anim1),
                                  child: child,
                                ),
                              );
                            },
                            child: const Text("data"),
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
                          coloredItem(Colors.red, 0),
                          coloredItem(Colors.blueGrey, 1),
                          coloredItem(Colors.green, 2),
                          // Container(
                          //   margin: const EdgeInsets.all(3.0),
                          //   decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(3.0)),
                          //   width: 40,
                          //   height: 40,
                          // ),
                          // Container(
                          //   margin: const EdgeInsets.all(3.0),
                          //   decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(3.0)),
                          //   width: 40,
                          //   height: 40,
                          // ),
                          // Container(
                          //   margin: const EdgeInsets.all(3.0),
                          //   decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(3.0)),
                          //   width: 40,
                          //   height: 40,
                          // ),
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
        height: 400,
        decoration: const BoxDecoration(
          color: Colors.amber,
          // image: DecorationImage(
          //   image: AssetImage(
          //       "assets/images/rose.jpg"),
          //   fit: BoxFit.cover,
          // ),
        ),
        // alignment: Alignment.bottomCenter,
        child: const CustomCalendar(),
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
        note.setLabelColor(noteColorIndex);
        BlocProvider.of<NoteBloc>(context).add(NewNoteWasSent(note));
      } else {
        // we are editting a note
        print(note);
        BlocProvider.of<NoteBloc>(context).add(NoteWasEdittedEvent(note));
      }
    }
  }

  // repeated
  Widget coloredItem(Color color, int i) {
    return InkWell(
      onTap: () {
        setState(() {
          noteColorIndex = i;
        });
        // BlocProvider.of<ThemeSettingBloc>(context).add(ThemeChanged(currentTheme));
      },
      child: Card(
        elevation: 5,
        color: noteColorIndex == i ? Colors.white : color,
        child: Container(
          margin: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: color,
          ),
          height: 40,
          width: 40,
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }
}
