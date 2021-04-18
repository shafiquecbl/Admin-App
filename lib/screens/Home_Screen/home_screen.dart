import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/updateData.dart';
import 'package:shop_app/screens/Home_Screen/griddashboard.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/widgets/snack_bar.dart';
import 'package:shop_app/enum/user_state.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home_screen";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  User user = FirebaseAuth.instance.currentUser;
  String token;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      UpdateData().setUserState(
        userEmail: user.email,
        userState: UserState.Online,
      );
    });
    WidgetsBinding.instance.addObserver(this);
  }

  void getToken() async {
    token = await FirebaseMessaging().getToken();
    print("TOKENNNNNNNNNNN: $token");
    await FirebaseFirestore.instance
        .collection('Admin')
        .doc(user.email)
        .update({'token': token});
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    String uEmail = user.email != null ? user.email : "";

    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        uEmail != null
            ? UpdateData()
                .setUserState(userEmail: uEmail, userState: UserState.Online)
            : print("resume state");
        break;
      case AppLifecycleState.inactive:
        uEmail != null
            ? UpdateData()
                .setUserState(userEmail: uEmail, userState: UserState.Offline)
            : print("inactive state");
        break;
      case AppLifecycleState.paused:
        uEmail != null
            ? UpdateData()
                .setUserState(userEmail: uEmail, userState: UserState.Waiting)
            : print("paused state");
        break;
      case AppLifecycleState.detached:
        uEmail != null
            ? UpdateData()
                .setUserState(userEmail: uEmail, userState: UserState.Offline)
            : print("detached state");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    getToken();
    return Scaffold(
        backgroundColor: Color(0xFF0C1019),
        body: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height * .3,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/top_header.png'),
                    fit: BoxFit.cover),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    ListTile(
                        contentPadding:
                            EdgeInsets.only(left: 20, right: 20, top: 20),
                        title: Text(
                          "Muhammad Shafique",
                          style: GoogleFonts.teko(
                              color: hexColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                        subtitle: Text(
                          "Admin",
                          style: GoogleFonts.teko(
                              color: Color(0xFF0C1019),
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        trailing: IconButton(
                          alignment: Alignment.topCenter,
                          icon: Icon(
                            Icons.logout,
                            color: hexColor,
                          ),
                          onPressed: () {
                            confirmSignout(context);
                          },
                        )),
                    Expanded(child: GridDashboard()),
                  ],
                ),
              ),
            ),
          ],
        ));
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
