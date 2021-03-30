import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/Home_Screen/CNIC/cnic_list.dart';
import 'package:shop_app/screens/Home_Screen/Inbox/inbox.dart';
import 'package:shop_app/screens/Home_Screen/Users/users.dart';
import 'package:shop_app/widgets/navigator.dart';

class GridDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: StaggeredGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 30,
        mainAxisSpacing: 30,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        staggeredTiles: [
          StaggeredTile.extent(2, 120),
          StaggeredTile.extent(1, 120),
          StaggeredTile.extent(1, 120),
        ],
        children: [
          users(context),
          cnic(context),
          inbox(context),
        ],
      ),
    );
  }

  users(BuildContext context) {
    return InkWell(
      onTap: () {
        navigator(context, ManageUsers());
      },
      splashColor: kPrimaryColor,
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: kPrimaryColor.withOpacity(0.3),
            spreadRadius: 0,
            blurRadius: 2,
            offset: Offset(1, 0),
          )
        ], color: Colors.grey[50], borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              "assets/icons/User.svg",
              color: kPrimaryColor,
              width: 42,
            ),
            SizedBox(
              height: 14,
            ),
            Text(
              "Users",
              style:
                  GoogleFonts.teko(fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  cnic(BuildContext context) {
    return InkWell(
      onTap: () {
        navigator(context, CNICList());
      },
      splashColor: kPrimaryColor,
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: kPrimaryColor.withOpacity(0.3),
            spreadRadius: 0,
            blurRadius: 2,
            offset: Offset(1, 0),
          )
        ], color: Colors.grey[50], borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              "assets/icons/id-card.svg",
              color: kPrimaryColor,
              width: 42,
            ),
            SizedBox(
              height: 14,
            ),
            Text(
              "Manage CNIC",
              style:
                  GoogleFonts.teko(fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  inbox(BuildContext context) {
    return InkWell(
      onTap: () {
        navigator(context, Inbox());
      },
      splashColor: kPrimaryColor,
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: kPrimaryColor.withOpacity(0.3),
            spreadRadius: 0,
            blurRadius: 2,
            offset: Offset(1, 0),
          )
        ], color: Colors.grey[50], borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.inbox,
              color: kPrimaryColor,
              size: 42,
            ),
            SizedBox(
              height: 14,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Inbox",
                  style: GoogleFonts.teko(
                      fontWeight: FontWeight.w600, fontSize: 18),
                ),
                SizedBox(
                  width: 5,
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Admin')
                      .doc(FirebaseAuth.instance.currentUser.email)
                      .collection('Contact US')
                      .where('Status', isEqualTo: 'unread')
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return Container();
                    return Container(
                      padding: EdgeInsets.all(2),
                      decoration: new BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 25,
                        minHeight: 12,
                      ),
                      child: new Text(
                        '${snapshot.data.docs.length}',
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
