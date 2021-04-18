import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/Home_Screen/Users/view_userProfile.dart';
import 'package:shop_app/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:shop_app/widgets/custom_AppBar.dart';

class ManageUsers extends StatefulWidget {
  @override
  _ManageUsersState createState() => _ManageUsersState();
}

class _ManageUsersState extends State<ManageUsers> {
  User user = FirebaseAuth.instance.currentUser;
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
            return Center(child: CircularProgressIndicator());
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
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => UserProfile(snapshot['Email'])));
      },
      child: Card(
        elevation: 2,
        shadowColor: Colors.deepPurple,
        child: ListTile(
          leading: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                border: Border.all(
                  width: 2,
                  color: Theme.of(context).primaryColor,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: CircleAvatar(
                  radius: 24,
                  backgroundColor: hexColor,
                  child: snapshot['PhotoURL'] == null ||
                          snapshot['PhotoURL'] == ""
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
                          child: CachedNetworkImage(
                            imageUrl: snapshot['PhotoURL'],
                            placeholder: (context, url) => Image(
                              image: AssetImage('assets/images/nullUser.png'),
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ))),
          title: Text(snapshot['Name']),
          subtitle: Text(snapshot['Email']),
          trailing: IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => UserProfile(snapshot['Email'])));
            },
          ),
        ),
      ),
    );
  }
}
