import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:shop_app/screens/Home_Screen/home_screen.dart';
import 'package:intl/intl.dart';

class SetData {
  final User user = FirebaseAuth.instance.currentUser;
  final email = FirebaseAuth.instance.currentUser.email;
  String uid = FirebaseAuth.instance.currentUser.uid.toString();
  String name = FirebaseAuth.instance.currentUser.displayName;
  static DateTime now = DateTime.now();
  String dateTime = DateFormat("dd-MM-yyyy h:mma").format(now);

  Future saveNewUser(email, context) async {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('Admin');
    users
        .doc(email)
        .set({
          'Email': email,
          'Uid': uid,
          'Email status': "Verified",
          'Role': 'Admin',
          'token': ''
        })
        .then((value) =>
            Navigator.pushReplacementNamed(context, HomeScreen.routeName))
        .catchError((e) {
          print(e);
        });
  }

  sendMessage(receiverEmail, receiverName, receiverPhotoURL, isOnline) {
    final CollectionReference messages = FirebaseFirestore.instance
        .collection('Messages')
        .doc(email)
        .collection('Inbox');
    messages.doc(receiverEmail).set({
      'Name': receiverName,
      'PhotoURL': receiverPhotoURL,
      'Online Status': isOnline,
    });
  }
}
