import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/size_config.dart';

const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kGreenColor = Color(0xFF29AF70);
const greenColor = Colors.green;
const kWhiteColor = Colors.white;
const Color separatorColor = Color(0xff272c35);
const hexColor = Color(0xFFf5f4f4);
const kTextColor = Color(0xFF757575);
const kCardColor = hexColor;
const kIconColor = Color(0xFF8D4DE9);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);
final otp = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: kPrimaryColor,
  height: 1.5,
);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";
final String initText =
    "Hi ${FirebaseAuth.instance.currentUser.displayName}. This is Muhammad Shafique from Instant Tasker. I'll be accompanying you in this chat, please don't share your contact details or any other personal information in this chat.";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kPrimaryColor),
  );
}

const Color blueColor = Color(0xff2b9ed4);
const Color blackColor = Color(0xff19191b);
const Color greyColor = Color(0xff8f8f8f);
const Color userCircleBackground = Color(0xff2b2b33);
const Color onlineDotColor = Color(0xff46dc64);
const Color lightBlueColor = Color(0xff0077d7);

const Color gradientColorStart = Color(0xff00b6f3);
const Color gradientColorEnd = Color(0xff0184dc);

const Color senderColor = Color(0xff2b343b);
const Color receiverColor = Color(0xff1e2225);

const Gradient fabGradient = LinearGradient(
    colors: [gradientColorStart, gradientColorEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight);

BoxDecoration boxDecoration = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(5)),
  border: Border.all(color: Colors.grey[200]),
);

Divider divider = new Divider(
  height: 1,
  color: Colors.grey,
);

Padding dividerPad = new Padding(
  padding: const EdgeInsets.only(left: 70),
  child: Divider(
    height: 1,
    color: Colors.grey,
  ),
);
