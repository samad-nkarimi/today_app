// ignore_for_file: file_names

import 'package:flutter/material.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({Key? key}) : super(key: key);

  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "یادداشت",
              style:
                  TextStyle(fontFamily: "Negar", fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                maxLines: 1,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                  label: const Text("عنوان"),
                  fillColor: Colors.grey,
                  focusColor: Colors.grey.withOpacity(0.5),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter some text!";
                  }
                  return null;
                },
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                maxLines: 4,
                minLines: 4,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    label: const Text("متن یادداشت"),
                    filled: true,
                    fillColor: Colors.grey,
                    hintText: "salam",
                    helperText: "hey",
                    focusColor: Colors.blue.withOpacity(0.5)),
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return "please enter some text!";
                //   }
                //   return null;
                // },
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(3.0)),
                width: 20,
                height: 20,
              ),
              Container(
                margin: EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(3.0)),
                width: 20,
                height: 20,
              ),
              Container(
                margin: EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(3.0)),
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
              }
            },
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }
}
