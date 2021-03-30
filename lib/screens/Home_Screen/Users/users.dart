import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/Home_Screen/Users/view_userProfile.dart';
import 'package:shop_app/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shop_app/widgets/custom_AppBar.dart';

class ManageUsers extends StatefulWidget {
  @override
  _ManageUsersState createState() => _ManageUsersState();
}

class _ManageUsersState extends State<ManageUsers> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: customAppBar("Manage Users"),
      body: StreamBuilder(
        initialData: [],
        stream: FirebaseFirestore.instance
            .collection('Users')
            .orderBy('Email', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return SpinKitCircle(color: kPrimaryColor);
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (BuildContext context, int index) {
              return users(snapshot.data.docs[index]);
            },
          );
        },
      ),
    );
  }

  users(DocumentSnapshot snapshot) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
            radius: 27,
            backgroundColor: hexColor,
            child: snapshot['PhotoURL'] == null || snapshot['PhotoURL'] == ""
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      'assets/images/nullUser.png',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/load.gif',
                      image: snapshot['PhotoURL'],
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  )),
        title: Text(snapshot['Name']),
        subtitle: Text(snapshot['Email']),
        trailing: IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () {
            moreDialog(snapshot);
          },
        ),
      ),
    );
  }

  moreDialog(DocumentSnapshot snapshot) {
    Widget viewProfile = FlatButton(
      onPressed: () {
        Navigator.pop(context);
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => UserProfile(snapshot['Email'])));
      },
      child: ListTile(
          leading: Icon(
            Icons.supervised_user_circle_outlined,
            color: kPrimaryColor,
          ),
          title: Text("View Profile")),
    );
    SimpleDialog alert = SimpleDialog(
      children: [
        // cnic,
        viewProfile,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
