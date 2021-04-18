import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/Home_Screen/CNIC/verify_cnic.dart';
import 'package:shop_app/size_config.dart';
import 'package:shop_app/widgets/custom_AppBar.dart';

class CNICList extends StatefulWidget {
  @override
  _CNICListState createState() => _CNICListState();
}

class _CNICListState extends State<CNICList> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: customAppBar("Manage CNIC"),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .where('CNIC Status', isEqualTo: 'Submitted')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null)
            return Center(child: CircularProgressIndicator());
          if (snapshot.data.docs.length == 0)
            return Center(
              child: Text(
                "No User available",
                style: GoogleFonts.teko(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            );
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (BuildContext context, int index) {
              return listTile(snapshot.data.docs[index]);
            },
          );
        },
      ),
    );
  }

  listTile(DocumentSnapshot snapshot) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ManageCNIC(
                      email: snapshot['Email'],
                    )));
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
                      builder: (_) => ManageCNIC(
                            email: snapshot['Email'],
                          )));
            },
          ),
        ),
      ),
    );
  }

  moreDialog(DocumentSnapshot snapshot) {
    Widget view = FlatButton(
      onPressed: () {
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ManageCNIC(
                      email: snapshot['Email'],
                    )));
      },
      child: ListTile(
          leading: Icon(
            Icons.verified_user,
            color: kPrimaryColor,
          ),
          title: Text("View CNIC")),
    );
    Widget viewProfile = FlatButton(
      onPressed: () {
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ManageCNIC(email: snapshot['Email'])));
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
        view,
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
