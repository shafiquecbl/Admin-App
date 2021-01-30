import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/getData.dart';
import 'package:shop_app/size_config.dart';
import 'package:shop_app/widgets/RatingBar.dart';

class UserProfile extends StatefulWidget {
  final String userEamil;
  UserProfile(this.userEamil);
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  User user = FirebaseAuth.instance.currentUser;
  String email = FirebaseAuth.instance.currentUser.email;
  final auth = FirebaseAuth.instance;
  GetData getData = new GetData();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
          elevation: 5,
          shadowColor: kPrimaryColor,
          title: Text(
            "My Profile",
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: hexColor,
          ),
      body: FutureBuilder(
        future: getData.getUserProfile(widget.userEamil),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return SpinKitDoubleBounce(
              color: kPrimaryColor,
            );

          return SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  getData.getUserProfile(widget.userEamil);
                });
              },
              child: ListView(children: [
                Column(
                  children: [
                    SizedBox(height: getProportionateScreenHeight(30)),
                    Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: snapshot.data['PhotoURL'] == null ? 54 : 68,
                            backgroundColor: kPrimaryColor.withOpacity(0.8),
                            child: user.photoURL != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(70),
                                    child: Image.network(
                                      snapshot.data['PhotoURL'],
                                      width: 130,
                                      height: 130,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    width: 100,
                                    height: 100,
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      snapshot.data['Name'],
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.blueGrey,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      child: DefaultTabController(
                          length: 2, // length of tabs
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 50),
                                  child: TabBar(
                                    labelColor: kWhiteColor,
                                    unselectedLabelColor: kPrimaryColor,
                                    indicator: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10)),
                                        color: kPrimaryColor),
                                    tabs: [
                                      Tab(text: 'As Seller'),
                                      Tab(text: 'As Buyer'),
                                    ],
                                  ),
                                ),
                                Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 30),
                                    height: 140, //height of TabBarView
                                    decoration: BoxDecoration(
                                        border: Border(
                                            top: BorderSide(
                                                color: Colors.grey,
                                                width: 0.5))),
                                    child: TabBarView(children: <Widget>[
                                      Container(
                                        child: Center(
                                            child: Column(
                                          children: [
                                            SizedBox(
                                                height:
                                                    getProportionateScreenHeight(
                                                        10)),
                                            snapshot.data['Rating as Seller'] ==
                                                    0
                                                ? EmptyRatingBar(
                                                    rating: 5,
                                                  )
                                                : RatingBar(
                                                    rating: snapshot.data[
                                                        'Rating as Seller'],
                                                  ),
                                            SizedBox(
                                                height:
                                                    getProportionateScreenHeight(
                                                        10)),
                                            Text(
                                                '${snapshot.data['Reviews as Seller']} Reviews'),
                                            SizedBox(
                                                height:
                                                    getProportionateScreenHeight(
                                                        10)),
                                            Text(
                                                '${snapshot.data['Completion Rate']}% Completetion Rate'),
                                            Text(
                                                '${snapshot.data['Completed Task']} Completed Tasks'),
                                          ],
                                        )),
                                      ),
                                      Container(
                                        child: Center(
                                            child: Column(
                                          children: [
                                            SizedBox(
                                                height:
                                                    getProportionateScreenHeight(
                                                        10)),
                                            snapshot.data['Rating as Buyer'] ==
                                                    0
                                                ? EmptyRatingBar(
                                                    rating: 5,
                                                  )
                                                : RatingBar(
                                                    rating: snapshot.data[
                                                        'Rating as Buyer'],
                                                  ),
                                            SizedBox(
                                                height:
                                                    getProportionateScreenHeight(
                                                        10)),
                                            Text(
                                                '${snapshot.data['Reviews as Buyer']} Reviews'),
                                            SizedBox(
                                                height:
                                                    getProportionateScreenHeight(
                                                        10)),
                                            Text(
                                                '${snapshot.data['Completion Rate']}% Completetion Rate'),
                                            Text(
                                                '${snapshot.data['Completed Task']} Completed Tasks'),
                                          ],
                                        )),
                                      ),
                                    ]))
                              ])),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 20),
                      height: 50,
                      color: Colors.blueGrey[200].withOpacity(0.3),
                      child: Text(
                        'About',
                        style: TextStyle(color: Colors.black.withOpacity(0.7)),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 20),
                      child: Text(
                        snapshot.data['About'],
                        style: TextStyle(color: Colors.black.withOpacity(0.7)),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 20),
                      height: 50,
                      color: Colors.blueGrey[200].withOpacity(0.3),
                      child: Text(
                        'Gender',
                        style: TextStyle(color: Colors.black.withOpacity(0.7)),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 20),
                      child: Text(
                        snapshot.data['Gender'],
                        style: TextStyle(color: Colors.black.withOpacity(0.7)),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 20),
                      height: 50,
                      color: Colors.blueGrey[200].withOpacity(0.3),
                      child: Text(
                        'Verifications',
                        style: TextStyle(color: Colors.black.withOpacity(0.7)),
                      ),
                    ),
                    Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 20),
                        child: Column(children: [
                          ListTile(
                            leading: Icon(Icons.email_outlined,
                                color: kPrimaryColor),
                            title: Text("Email"),
                            subtitle: Text(snapshot.data['Email']),
                            trailing: Text(snapshot.data['Email status'])
                          ),
                          ListTile(
                            leading: Icon(Icons.phone, color: kPrimaryColor),
                            title: Text("Phone"),
                            subtitle: Text(snapshot.data['Phone Number']),
                            trailing: Text(snapshot.data['Phone Number status'])
                          ),
                          ListTile(
                            leading: Icon(Icons.verified_user,
                                color: kPrimaryColor),
                            title: Text("CNIC"),
                            subtitle: Text(snapshot.data['CNIC']),
                            trailing: Text(snapshot.data['CNIC Status'])
                          ),
                          ListTile(
                            leading: Icon(Icons.attach_money,
                                color: kPrimaryColor),
                            title: Text("Payment Method"),
                            subtitle: Text(snapshot.data['Payment Method']),
                            trailing: Text(snapshot.data['Payment Status'])
                          ),
                        ])),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 20),
                      height: 50,
                      color: Colors.blueGrey[200].withOpacity(0.3),
                      child: Text(
                        'Address',
                        style: TextStyle(color: Colors.black.withOpacity(0.7)),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 20),
                      child: Text(
                        snapshot.data['Address'],
                        style: TextStyle(color: Colors.black.withOpacity(0.7)),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 20),
                      height: 50,
                      color: Colors.blueGrey[200].withOpacity(0.3),
                      child: Text(
                        'Education',
                        style: TextStyle(color: Colors.black.withOpacity(0.7)),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 20),
                      child: Text(
                        snapshot.data['Education'],
                        style: TextStyle(color: Colors.black.withOpacity(0.7)),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 20),
                      height: 50,
                      color: Colors.blueGrey[200].withOpacity(0.3),
                      child: Text(
                        'Specialities',
                        style: TextStyle(color: Colors.black.withOpacity(0.7)),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 20),
                      child: Text(
                        snapshot.data['Specialities'],
                        style: TextStyle(color: Colors.black.withOpacity(0.7)),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 20),
                      height: 50,
                      color: Colors.blueGrey[200].withOpacity(0.3),
                      child: Text(
                        'Languages',
                        style: TextStyle(color: Colors.black.withOpacity(0.7)),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 20),
                      child: Text(
                        snapshot.data['Languages'],
                        style: TextStyle(color: Colors.black.withOpacity(0.7)),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 20),
                      height: 50,
                      color: Colors.blueGrey[200].withOpacity(0.3),
                      child: Text(
                        'Work',
                        style: TextStyle(color: Colors.black.withOpacity(0.7)),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 20),
                      child: Text(
                        snapshot.data['Work'],
                        style: TextStyle(color: Colors.black.withOpacity(0.7)),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 20),
                      height: 50,
                      color: Colors.blueGrey[200].withOpacity(0.3),
                      child: Text(
                        'Reviews',
                        style: TextStyle(color: Colors.black.withOpacity(0.7)),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: DefaultTabController(
                          length: 2, // length of tabs
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 50),
                                  child: TabBar(
                                    labelColor: kWhiteColor,
                                    unselectedLabelColor: kPrimaryColor,
                                    indicator: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10)),
                                        color: kPrimaryColor),
                                    tabs: [
                                      Tab(text: 'As Seller'),
                                      Tab(text: 'As Buyer'),
                                    ],
                                  ),
                                ),
                                Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 30),
                                    height: 140, //height of TabBarView
                                    decoration: BoxDecoration(
                                        border: Border(
                                            top: BorderSide(
                                                color: Colors.grey,
                                                width: 0.5))),
                                    child: TabBarView(children: <Widget>[
                                      Container(
                                        child: Center(
                                            child: Column(
                                          children: [
                                            SizedBox(
                                                height:
                                                    getProportionateScreenHeight(
                                                        10)),
                                            Text(
                                                '${snapshot.data['Rating as Seller']} stars from ${snapshot.data['Reviews as Seller']} Reviews'),
                                            SizedBox(
                                                height:
                                                    getProportionateScreenHeight(
                                                        10)),
                                            snapshot.data['Rating as Seller'] ==
                                                    0
                                                ? EmptyRatingBar(
                                                    rating: 5,
                                                  )
                                                : RatingBar(
                                                    rating: snapshot.data[
                                                        'Rating as Seller'],
                                                  ),
                                            SizedBox(
                                                height:
                                                    getProportionateScreenHeight(
                                                        10)),
                                            Text(
                                                'This user has ${snapshot.data['Reviews as Seller']} reviews as a Seller'),
                                          ],
                                        )),
                                      ),
                                      Container(
                                        child: Center(
                                            child: Column(
                                          children: [
                                            SizedBox(
                                                height:
                                                    getProportionateScreenHeight(
                                                        10)),
                                            Text(
                                                '${snapshot.data['Rating as Buyer']} stars from ${snapshot.data['Reviews as Buyer']} Reviews'),
                                            SizedBox(
                                                height:
                                                    getProportionateScreenHeight(
                                                        10)),
                                            snapshot.data['Rating as Buyer'] ==
                                                    0
                                                ? EmptyRatingBar(
                                                    rating: 5,
                                                  )
                                                : RatingBar(
                                                    rating: snapshot.data[
                                                        'Rating as Buyer'],
                                                  ),
                                            SizedBox(
                                                height:
                                                    getProportionateScreenHeight(
                                                        10)),
                                            Text(
                                                'This user has ${snapshot.data['Reviews as Buyer']} reviews as a Buyer'),
                                          ],
                                        )),
                                      ),
                                    ]))
                              ])),
                    ),
                  ],
                ),
              ]),
            ),
          );
        },
      ),
    );
  }
}
