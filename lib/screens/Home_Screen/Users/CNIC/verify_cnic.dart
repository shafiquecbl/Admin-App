import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shop_app/widgets/custom_AppBar.dart';

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
      appBar: customAppBar("Manage CNIC"),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('CNIC')
            .doc(widget.email)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return SpinKitCircle(color: kPrimaryColor);
          if (snapshot.data == null) return CircularProgressIndicator();
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
            loadingBuilder: (context, event) => Center(
                child: SpinKitCircle(
              color: kPrimaryColor,
            )),
          ));
        },
      ),
    );
  }
}
