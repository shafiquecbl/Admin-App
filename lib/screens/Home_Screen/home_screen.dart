import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/screens/Home_Screen/griddashboard.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/widgets/snack_bar.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home_screen";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 80,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Muhammad Shafique",
                      style: GoogleFonts.teko(
                          fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Admin",
                      style: GoogleFonts.teko(
                          color: Color(0xffa29aac),
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                IconButton(
                  alignment: Alignment.topCenter,
                  icon: Icon(
                    Icons.logout,
                  ),
                  onPressed: () {
                    confirmSignout(context);
                  },
                )
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          GridDashboard()
        ],
      ),
    );
  }
}

confirmSignout(BuildContext context) {
  // set up the button
  Widget yes = CupertinoDialogAction(
    child: Text("Yes"),
    onPressed: () {
      FirebaseAuth.instance.signOut().whenComplete(() {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => SignInScreen()),
        );
      }).catchError((e) {
        Snack_Bar.show(context, e.message);
      });
    },
  );

  Widget no = CupertinoDialogAction(
    child: Text("No"),
    onPressed: () {
      Navigator.maybePop(context);
    },
  );

  // set up the AlertDialog
  CupertinoAlertDialog alert = CupertinoAlertDialog(
    title: Text("Signout"),
    content: Text("Do you want to signout?"),
    actions: [yes, no],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
