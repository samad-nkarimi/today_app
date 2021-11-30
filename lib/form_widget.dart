// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:today_app/blocs/note/note.dart';
import 'package:today_app/models/models.dart';

class FormWidget extends StatefulWidget {
  final bool isCalendarPage;

  const FormWidget({Key? key, this.isCalendarPage = false}) : super(key: key);

  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  Note note = Note("", "");

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "یادداشت",
                  style: TextStyle(fontFamily: "Negar", fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
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
                      note.setTitle(title);
                      if (title == null || title.isEmpty) {
                        return "please enter some text!";
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
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
                      note.setSubTitle(subTitle);
                      if (subTitle == null || subTitle.isEmpty) {
                        return "please enter some text!";
                      }
                      return null;
                    },
                  ),
                ),
              ),
              if (widget.isCalendarPage)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (con) {
                              return DatePickerDialog(
                                initialDate: DateTime(2015),
                                firstDate: DateTime(2010),
                                lastDate: DateTime(2018),
                              );
                            });
                      },
                      child: const Text("تاریخ"),
                    ),
                    const Text("1399.2.2"),
                  ],
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(3.0)),
                    width: 20,
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(3.0)),
                    width: 20,
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(3.0)),
                    width: 20,
                    height: 20,
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("done!")),
                    );
                    BlocProvider.of<NoteBloc>(context).add(NewNoteWasSent(note));
                  }
                },
                child: const Text("Submit"),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }
}
