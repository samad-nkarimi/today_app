import 'package:flutter/material.dart';
import 'package:jalali_calendar/jalali_calendar.dart';
import 'package:today_app/form_widget.dart';
import 'package:today_app/note_item_widget.dart';
import 'package:table_calendar/table_calendar.dart';

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
              child:  const FormWidget(isCalendarPage: true ),
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
            Text("افزودن یادداشت",
                style: TextStyle(color: Colors.white, fontFamily: "Negar")),
            Padding(
              padding: EdgeInsets.only(left: 5.0),
              child: Icon(Icons.add_circle_outline, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(

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
