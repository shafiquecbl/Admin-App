import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/enum/utils.dart';
import 'package:shop_app/enum/user_state.dart';

class UpdateData {
  User user = FirebaseAuth.instance.currentUser;
  final email = FirebaseAuth.instance.currentUser.email;

  setUserState({@required String userEmail, @required UserState userState}) {
    int stateNum = Utils.stateToNum(userState);

    FirebaseFirestore.instance.collection('Admin').doc(userEmail).update({
      "state": stateNum,
    });
  }

  Future updateMessageStatus(receiverEmail) async {
    return await FirebaseFirestore.instance
        .collection('Admin')
        .doc(email)
        .collection('Contact US')
        .doc(receiverEmail)
        .update({'Status': "read"});
  }
}
