import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/constants.dart';

customAppBar(
  text,
) {
  AppBar appBar = AppBar(
    elevation: 2,
    title: Text(
      '$text',
      style: GoogleFonts.teko(
        color: kTextColor,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
  );
  return appBar;
}
