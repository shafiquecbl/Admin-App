import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/Home_Screen/Users/view_userProfile.dart';
import 'package:shop_app/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ManageUsers extends StatefulWidget {
  @override
  _ManageUsersState createState() => _ManageUsersState();
}

class _ManageUsersState extends State<ManageUsers> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        shadowColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 0),
          child: Text(
            'Manage Users',
            style: TextStyle(color: kPrimaryColor),
          ),
        ),
        backgroundColor: hexColor,
      ),
      body: StreamBuilder(
        initialData: [],
        stream: FirebaseFirestore.instance
            .collection('Users')
            .orderBy('Email', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return SpinKitDoubleBounce(color: kPrimaryColor);
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: DataTable(
                      columns: [
                        DataColumn(
                          label: Text("No."),
                        ),
                        DataColumn(
                          label: Text("Email"),
                        ),
                        DataColumn(
                          label: Text("View Details"),
                        ),
                        DataColumn(
                          label: Text("Delete"),
                        ),
                      ],
                      rows: List.generate(
                          snapshot.data.docs.length,
                          (index) => DataRow(
                            cells: [
                                DataCell(Text("${index + 1}")),
                                DataCell(Text(
                                    "${snapshot.data.docs[index]['Email']}")),
                                DataCell(RaisedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => UserProfile(
                                            snapshot.data.docs[index]['Email']),
                                      ),
                                    );
                                  },
                                  child: Text("View"),
                                  color: kPrimaryColor,
                                )),
                                DataCell(RaisedButton(
                                  onPressed: () {},
                                  child: Text("Delete"),
                                  color: Colors.redAccent,
                                )),
                              ]))),
                )),
          );
        },
      ),
    );
  }
}
