import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:today/blocs/blocs.dart';
import 'package:today/widgets/add_note_button_widget.dart';
import 'package:today/widgets/floating_button_widget.dart';
import '../blocs/note/note.dart';
import '../utils/custom_calendar.dart';
import 'drawer_widget.dart';
import '../widgets/form_widget.dart';
import '../models/models.dart';
import '../widgets/note_item_widget.dart';

class CalendarPage extends StatefulWidget {
  static const routeName = "/calender_route";

  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  Widget addNoteButtonWidget() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                FormWidget(initialData: Note("", ""), isCalendarPage: true),
          ),
        );
      },
      child: AddNoteButton(context: context),
    );

    // GestureDetector(
    //   onTap: () {
    //     showModalBottomSheet(
    //       isScrollControlled: true,
    //       shape: const RoundedRectangleBorder(
    //         borderRadius: BorderRadius.only(
    //           topLeft: Radius.circular(30.0),
    //           topRight: Radius.circular(30.0),
    //         ),
    //       ),
    //       context: context,
    //       builder: (context) {
    //         return Container(
    //           // height: 400,
    //           color: Colors.transparent,
    //           child:
    //               FormWidget(isCalendarPage: true, initialData: Note("", "")),
    //         );
    //       },
    //     );
    //   },
    //   child: AddNoteButton(context: context),
    // );
  }

  // repeated
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

  // repeated
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        endDrawer: const DrawerWidget(),
        body: Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              // begin: Alignment.topLeft,
              // end: Alignment.bottomRight,
              center: Alignment.topLeft,
              radius: 1.4,
              stops: [0.5, 1.0],
              colors: [
                Color(0xFFB2AFFF),
                Color(0xFF003AD9),
                // Theme.of(context).scaffoldBackgroundColor,
                // Theme.of(context).scaffoldBackgroundColor.withOpacity(0.3),
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: BlocBuilder<NoteBloc, NoteState>(
              builder: (context, state) {
                List<Note> notes = state.notes.getCalenderNotes;
                // print("notes: $notes");
                // print("state: $state");
                // if(state is NewNoteIsAdded)
                // noteCount++;
                return Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(
                          image: AssetImage("assets/images/rose.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      alignment: Alignment.bottomCenter,
                      child: const CustomCalendar(),
                    ),
                    const SizedBox(height: 20),
                    if (notes.isEmpty) noNoteWidget(),
                    for (int i = 0; i < notes.length; i++) NoteItem(notes[i]),
                    const SizedBox(height: 20),
                    addNoteButtonWidget(),
                    BlocBuilder<CalenderBloc, CalenderState>(
                        buildWhen: (previous, current) {
                      if (current is MonthAdequaciesCalenderState) {
                        return true;
                      } else {
                        return false;
                      }
                    }, builder: (context, state) {
                      return state is MonthAdequaciesCalenderState
                          ? _allAdequacyWidget(state.adequacies)
                          : const CircularProgressIndicator();
                    })
                  ],
                );
              },
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: const CustomFloatingButton(page: pageid.calendar),
      ),
    );
  }

  Widget _allAdequacyWidget(List<Adequacy> adequacies) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
      // height: 500,
      width: double.infinity,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          for (var i = 0; i < adequacies.length; i++)
            Container(
              // color: Colors.green,
              margin: const EdgeInsets.symmetric(vertical: 1),
              // width: 300,
              decoration: BoxDecoration(
                border:
                    Border.all(width: 1, color: Colors.white.withOpacity(0.4)),
                // color: Colors.amber.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),

              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                      flex: 60,
                      child: Container(
                        alignment: Alignment.centerRight,
                        // color: Colors.black12,
                        child: _listAdequacyTitles(adequacies[i].title),
                      ),
                    ),
                    Flexible(
                      flex: 25,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 1),
                        // decoration: BoxDecoration(
                        //   color: Colors.amber.withOpacity(0.3),
                        //   borderRadius: BorderRadius.circular(10),
                        // ),
                        child: Text(
                          "${adequacies[i].dayTitle}\n${adequacies[i].dayNumber}\n${adequacies[i].month}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
        ],
      ),
      // color: Colors.grey,
    );
  }

  Widget _listAdequacyTitles(String adequacyTitles) {
    List<String> titles = adequacyTitles.split("-");

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (int i = 0; i < titles.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                "* ${titles[i]}",
                textAlign: TextAlign.right,
                overflow: TextOverflow.ellipsis,
                maxLines: 10,
                softWrap: true,
                style: TextStyle(
                  color: titles[i].contains("[تعطیل]")
                      ? Colors.orange
                      : Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
