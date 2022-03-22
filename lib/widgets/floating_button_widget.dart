import 'package:flutter/material.dart';
import 'package:today/screens/calender_page.dart';

enum pageid { today, calendar }

class CustomFloatingButton extends StatefulWidget {
  final pageid page;
  const CustomFloatingButton({Key? key, required this.page}) : super(key: key);

  @override
  State<CustomFloatingButton> createState() => _CustomFloatingButtonState();
}

class _CustomFloatingButtonState extends State<CustomFloatingButton> {
  double animatedPadding = 20;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          animatedPadding = 5;
          Future.delayed(const Duration(milliseconds: 100)).then(
            (value) => setState(() {
              animatedPadding = 20;
            }),
          );
        });

        widget.page == pageid.calendar
            ? Navigator.pop(context)
            : Navigator.pushNamed(context, CalendarPage.routeName);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
            color: Colors.purple,
            borderRadius: BorderRadius.circular(50.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 1,
                spreadRadius: 1,
                offset: const Offset(0, 1),
              )
            ]),
        padding: EdgeInsets.all(animatedPadding),
        margin: const EdgeInsets.all(5.0),
        child: Icon(
          widget.page == pageid.calendar
              ? Icons.today_outlined
              : Icons.calendar_today_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
