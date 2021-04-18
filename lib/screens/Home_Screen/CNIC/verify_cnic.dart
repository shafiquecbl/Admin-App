import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManageCNIC extends StatefulWidget {
  final String email;
  ManageCNIC({@required this.email});
  @override
  _ManageCNICState createState() => _ManageCNICState();
}

class _ManageCNICState extends State<ManageCNIC> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 0),
          child: Text(
            'Managa CNIC',
            style: GoogleFonts.teko(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        backgroundColor: hexColor,
        actions: [
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                reject(context);
              }),
          IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                accept(context);
              })
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('CNIC')
            .doc(widget.email)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          List galleryItems = [
            snapshot.data['CNIC BS'],
            snapshot.data['CNIC FS'],
            snapshot.data['User Photo'],
          ];
          return Container(
              child: PhotoViewGallery.builder(
            scrollPhysics: const BouncingScrollPhysics(),
            builder: (BuildContext context, int index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(galleryItems[index]),
              );
            },
            itemCount: galleryItems.length,
            loadingBuilder: (context, event) =>
                Center(child: Center(child: CircularProgressIndicator())),
          ));
        },
      ),
    );
  }

  accept(BuildContext context) {
    // set up the button
    Widget yes = CupertinoDialogAction(
      child: Text("Yes"),
      onPressed: () {
        FirebaseFirestore.instance
            .collection('Users')
            .doc(widget.email)
            .update({'CNIC Status': 'verified'}).then((value) => {
                  Navigator.pop(context),
                  Navigator.pop(context),
                });
      },
    );
    Widget no = CupertinoDialogAction(
      child: Text("No"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    CupertinoAlertDialog alert = CupertinoAlertDialog(
      title: Text('Confirmation'),
      content: Text('Do you want to approve CNIC?'),
      actions: [yes, no],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  reject(BuildContext context) {
    // set up the button
    Widget yes = CupertinoDialogAction(
      child: Text("Yes"),
      onPressed: () {
        FirebaseFirestore.instance
            .collection('Users')
            .doc(widget.email)
            .update({'CNIC Status': 'Not Verified'}).then((value) => {
                  Navigator.pop(context),
                  Navigator.pop(context),
                });
      },
    );
    Widget no = CupertinoDialogAction(
      child: Text("No"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    CupertinoAlertDialog alert = CupertinoAlertDialog(
      title: Text('Confirmation'),
      content: Text('Do you want to disapprove CNIC?'),
      actions: [yes, no],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
