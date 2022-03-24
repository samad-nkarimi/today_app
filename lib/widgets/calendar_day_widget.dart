import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:today/blocs/blocs.dart';

class CalendarDayWidget extends StatefulWidget {
  final String text;
  final bool isTitle;
  final bool isToday;
  final bool isHoliday;
  final bool isSelected;
  const CalendarDayWidget({
    Key? key,
    this.isTitle = false,
    this.isToday = false,
    this.isHoliday = false,
    this.isSelected = false,
    required this.text,
  }) : super(key: key);

  @override
  State<CalendarDayWidget> createState() => _CalendarDayWidgetState();
}

class _CalendarDayWidgetState extends State<CalendarDayWidget> {
  // bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return
        // ClipRRect(
        //   clipBehavior: Clip.antiAlias,
        //   child: BackdropFilter(
        //     filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
        //     child:
        GestureDetector(
      onTap: () {
        // setState(() {
        //   isSelected = true;
        //   print(widget.text);
        // });
        BlocProvider.of<CalenderBloc>(context)
            .add(DaySelectedCalenderEvent(widget.text));
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: widget.text.isEmpty
              ? Colors.transparent
              : widget.isSelected
                  ? Colors.orange
                  : widget.isToday
                      ? Colors.green
                      : widget.isTitle
                          ? Colors.red.withOpacity(0.8)
                          : Colors.blue.withOpacity(0.4),
          borderRadius: BorderRadius.circular(widget.isTitle
              ? 10
              : widget.isToday
                  ? 20
                  : 2.0),
          border: Border.all(
            width: widget.isToday ? 1.0 : 1.0,
            color: (widget.isHoliday && widget.text.isNotEmpty)
                ? Colors.orange
                : widget.isToday
                    ? Colors.white
                    : Colors.transparent,
            style: BorderStyle.solid,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
        margin: const EdgeInsets.all(0.5),
        child: Text(
          widget.text,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: "Negar",
            color: widget.isHoliday ? Colors.amber : Colors.white,
            fontSize: 12,
          ),
        ),
        //   ),
        // ),
      ),
    );
  }
}
