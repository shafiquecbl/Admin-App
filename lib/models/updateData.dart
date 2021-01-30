import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:shop_app/screens/Home_Screen/home_screen.dart';
import 'package:shop_app/widgets/snack_bar.dart';

class UpdateData{
User user = FirebaseAuth.instance.currentUser;
final email = FirebaseAuth.instance.currentUser.email;

  Future<User> saveUserProfile(context,name,gender,phNo,address) async{

    double doubleValue = 0;
    int intValue = 0;
    final CollectionReference users = FirebaseFirestore.instance.collection('Users');
    users.doc(email).update({
      'Name' : name,
      'Phone Number': phNo,
      'Gender': gender,
      'Address': address,
      'PhotoURL': "",
      'Phone Number status': "Not Verified",
      'Rating as Seller': doubleValue,
      'Rating as Buyer' : doubleValue,
      'Reviews as Buyer': intValue,
      'Reviews as Seller': intValue,
      'Completion Rate': intValue,
      'Completed Task': intValue,
      'About': "",
      'Education':"",
      'Specialities': "",
      'Languages': "",
      'Work': "",
      'CNIC': "Not Verified",
      'Payment Status': "Not Verified",
    },).then((value) => 
    Navigator.pushReplacementNamed(context, HomeScreen.routeName)).catchError((e){
      Snack_Bar.show(context, e.message);
    });
    return null;
  }

  //////////////////////////////////////////////////////////////////////////////////////////
  
Future<User> updateUserProfile(context, name, gender, phNo, address,
    about, education, specialities, languages, work) async {
      
  final CollectionReference users =
      FirebaseFirestore.instance.collection('Users');
  users
      .doc(email)
      .update(
        {
          'Name': name,
          'Phone Number': phNo,
          'Gender': gender,
          'Address': address,
          'About': about,
          'Education': education,
          'Specialities': specialities,
          'Languages': languages,
          'Work': work,
        },
      )
      .then((value) =>
          Snack_Bar.show(context, "Profile Successfully Updated!"),
          )
      .catchError((e) {
        Snack_Bar.show(context, e.message);
      });
  return null;
}


  //////////////////////////////////////////////////////////////////////////////////////////

  Future<User> updateProfilePicture(context, uRL) async {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('Users');
  users
      .doc(email)
      .update(
        {
          'PhotoURL': uRL,
        },
      )
      .then((value) =>
          print('Profile Picture Successfully Updated'),
          )
      .catchError((e) {
        print(e.message);
      });
  return null;
}
}