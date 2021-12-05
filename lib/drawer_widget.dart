// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:today_app/blocs/blocs.dart';
import 'package:today_app/constants.dart';
import 'package:today_app/size/size_config.dart';

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
  bool _showAboutUs = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        // color: Colors.black12,
        height: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              height: 250,
              color: Colors.lightBlueAccent,
              child: Image.asset("assets/images/tick8_logo.png"),
            ),
            // const Divider(color: Colors.black45),
            _showAboutUs ? _aboutUsSection() : _drawerBottomSection(),
          ],
        ),
      ),
    );
  }

  Widget _drawerBottomSection() {
    return Container(
      // color: Colors.lightBlueAccent,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
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
                const Text("نوتیفیکیشنها", style: TextStyle(fontFamily: "Negar", fontSize: 20)),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: Text("رنگها", style: TextStyle(fontFamily: "Negar", fontSize: 20)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                colorItem(Colors.white70, 0),
                colorItem(Colors.black45, 1),
                colorItem(Colors.green, 2),
                colorItem(Colors.blue, 3),
              ],
            ),
          ),
          drawerItem(
              "درباره برنامه",
              () => setState(() {
                    _showAboutUs = !_showAboutUs;
                  })),
          drawerItem(
            " اشتراک برنامه",
            () => StoreRedirect.redirect(
              androidAppId: Constants.STORE_ANDROID_APP_ID,
              iOSAppId: Constants.STORE_IOS_APP_ID,
            ),
          ),
          drawerItem(" ارسال نظر ", () => FlutterEmailSender.send(email)),
        ],
      ),
    );
  }

  Widget drawerItem(String title, Function function) {
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
        onTap: () => function(),
      ),
    );
  }

  Widget colorItem(Color color, int i) {
    return InkWell(
      onTap: () {
        setState(() {
          currentTheme = i;
        });
        BlocProvider.of<ThemeSettingBloc>(context).add(ThemeChanged(currentTheme));
      },
      child: Card(
        elevation: 5,
        color: currentTheme == i ? Colors.white : color,
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

  Widget _aboutUsSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.responsiveWidth(5, 7.0)),
      color: Colors.black12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text("درباره ما", style: Theme.of(context).textTheme.subtitle1),
          const SizedBox(height: 15),
          Text(
            // Constants.ABOUT_US_BODY,
            "توضیحاتی درباره ما",
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),


          Container(
            // color: Colors.yellow,

            // alignment: Alignment.bottomCenter,
            margin: EdgeInsets.all(SizeConfig.responsiveHeight(8.0, 8.0)),
            width: SizeConfig.responsiveHeight(22.0, 20.0),
            height: SizeConfig.responsiveHeight(7.0, 10.0),
            child: ElevatedButton(
              onPressed: () => setState(() {
                _showAboutUs = !_showAboutUs;
              }),
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFF75C28C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "ok",
                style: Theme.of(context).textTheme.button,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final Email email = Email(
    body: Constants.EMAIL_BODY,
    subject: Constants.EMAIL_SUBJECT,
    recipients: Constants.EMAIL_RECIP,
    // cc: ["samad.nkarimi@gmail.com"],
    // bcc: ["samad.nkarimi@gmail.com"],
    // attachmentPaths: null,
    isHTML: false,
  );
}
