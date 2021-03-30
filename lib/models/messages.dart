import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class Messages {
  User user = FirebaseAuth.instance.currentUser;
  final email = FirebaseAuth.instance.currentUser.email;
  String uid = FirebaseAuth.instance.currentUser.uid.toString();
  String name = FirebaseAuth.instance.currentUser.displayName;
  static DateTime now = DateTime.now();
  String dateTime = DateFormat("dd-MM-yyyy h:mma").format(now);

  Future addMessage(receiverEmail, message) async {
    await FirebaseFirestore.instance
        .collection('Messages')
        .doc(email)
        .collection(receiverEmail)
        .add({
      'Email': email,
      'Time': dateTime,
      'Message': message,
      'timestamp': FieldValue.serverTimestamp(),
    });

    return await FirebaseFirestore.instance
        .collection('Messages')
        .doc(receiverEmail)
        .collection(email)
        .add({
      'Email': email,
      'Time': dateTime,
      'Message': message,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future addContact(
      receiverEmail, receiverName, receiverPhotoURl, message) async {
    await FirebaseFirestore.instance
        .collection('Admin')
        .doc(email)
        .collection('Contact US')
        .doc(receiverEmail)
        .set({
      'Name': receiverName,
      'Email': receiverEmail,
      'PhotoURL': receiverPhotoURl,
      'Last Message': message,
      'Time': dateTime,
      'Status': "read"
    });

    return await FirebaseFirestore.instance
        .collection('Users')
        .doc(receiverEmail)
        .collection('Contact US')
        .doc(email)
        .set({
      'Email': email,
      'Status': 'unread',
      'Time': dateTime,
    });
  }
}
