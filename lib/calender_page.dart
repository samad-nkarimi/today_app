import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:today_app/blocs/note/note.dart';
import 'package:today_app/form_widget.dart';
import 'package:today_app/models/models.dart';
import 'package:today_app/note_item_widget.dart';

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
              height: 400,
              color: Colors.transparent,
              child: const FormWidget(isCalendarPage: true),
            );
          },
        );
      },
      child: Container(
        // constraints: BoxConstraints(maxWidth: 100),
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.35),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(0, 3),
          ),
        ], color: Colors.blue, borderRadius: BorderRadius.circular(3.0)),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text("افزودن یادداشت", style: TextStyle(color: Colors.white, fontFamily: "Negar")),
            Padding(
              padding: EdgeInsets.only(left: 5.0),
              child: Icon(Icons.add_circle_outline, color: Colors.white),
            ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                  color: Colors.blue,
                  // height: 200,
                  width: double.infinity,
                  child: TableCalendar(
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: DateTime.now(),
                  ),
                ),
                if (notes.isEmpty) noNoteWidget(),
                for (int i = 0; i < notes.length; i++)
                  Dismissible(
                    key: Key(notes[i].id.toString()),
                    confirmDismiss: (direction) async{
                      if(direction == DismissDirection.endToStart) {
                        BlocProvider.of<NoteBloc>(context).add(NoteWasRemoved(notes[i]));
                        return true;
                      }else{
                        return false;
                      }
                    },
                    background:Container(color: Colors.red),

                    child: NoteItem(
                      notes[i].title,
                      notes[i].subTitle,
                      labelColor: Colors.orange,
                    ),
                  ),
                // NoteItem(labelColor: Colors.orange),
                // NoteItem(labelColor: Colors.green),
                // NoteItem(labelColor: Colors.red),
                // NoteItem(),
                addNoteButtonWidget(),
                // ElevatedButton(
                //   onPressed: () {
                //     showModalBottomSheet(
                //       shape: const RoundedRectangleBorder(
                //         borderRadius: BorderRadius.only(
                //           topLeft: Radius.circular(30.0),
                //           topRight: Radius.circular(30.0),
                //         ),
                //       ),
                //       context: context,
                //       builder: (context) {
                //         return Container(
                //           // height: 300,
                //           color: Colors.transparent,
                //           child: const FormWidget(),
                //         );
                //       },
                //     );
                //   },
                //   child: const Text("add note"),
                // ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  height: 150,
                  width: double.infinity,
                  child: const Text(""),
                  color: Colors.grey,
                )
              ],
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: InkWell(
        onTap: () => Navigator.pop(context),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(20.0),
          ),
          padding: const EdgeInsets.all(14.0),
          child: const Text(
            "امروز",
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
