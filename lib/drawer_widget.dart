// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:today_app/constants.dart';
// import 'package:flutter_email_sender/flutter_email_sender.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  bool notifValue = false;
  int currentTheme = 0;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        height: double.infinity,
        child: Column(
          children: [
            Container(
              height: 250,
              color: Colors.red,
            ),
            Container(
                // color: Colors.lightBlueAccent,
                padding: const EdgeInsets.symmetric( vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Switch(
                            value: notifValue,
                            onChanged: (value) {
                              setState(() {
                                notifValue = value;
                              });
                            },
                          ),
                          const Text("نوتیفیکیشنها", style:  TextStyle(fontFamily: "Negar", fontSize: 20)),
                        ],
                      ),
                    ),
                   const Padding(
                     padding:  EdgeInsets.symmetric(horizontal: 16.0,vertical: 4.0),
                     child:   Text("رنگها", style:  TextStyle(fontFamily: "Negar", fontSize: 20)),
                   ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ColorItem(Colors.red,0),
                          ColorItem(Colors.blue,1),
                          ColorItem(Colors.green,2),
                          ColorItem(Colors.orange,3),
                        ],
                      ),
                    ),
                    drawerItem("درباره برنامه"),
                    drawerItem(" اشتراک برنامه"),
                    // drawerItem(" ارسال نظر ",() => FlutterEmailSender.send(email)),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget drawerItem(String title) {
    return Material(
      child: InkWell(
        // splashColor: Colors.blue,
        child: Ink(
          color: Colors.white,
          child: Container(
            alignment: Alignment.centerRight,
            // color: Colors.blue,
            // height: SizeConfig.responsiveHeight(7.0, 8.0),
            height: 45,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(title, style: const TextStyle(fontFamily: "Negar", fontSize: 20)),
            ),
          ),
        ),
        onTap:(){},
      ),
    );
  }

  Widget ColorItem(Color color,int i) {
    return InkWell(
      onTap: (){
        setState(() {
          currentTheme=i;
        });
      },
      child: Card(
        elevation: 5,
        color: currentTheme==i?Colors.white:color,
        child: Container(

          margin: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: color,
          ),
          height: 30,
          width: 30,
        ),
      ),
    );
  }

  // final Email email = Email(
  //   body: Constants.EMAIL_BODY,
  //   subject: Constants.EMAIL_SUBJECT,
  //   recipients: Constants.EMAIL_RECIP,
  //   // cc: ["samad.nkarimi@gmail.com"],
  //   // bcc: ["samad.nkarimi@gmail.com"],
  //   // attachmentPaths: null,
  //   isHTML: false,
  // );
}
