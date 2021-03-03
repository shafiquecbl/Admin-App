import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/Home_Screen/CNIC/cnic_list.dart';
import 'package:shop_app/screens/Home_Screen/Users/users.dart';

class GridDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 30,
        mainAxisSpacing: 30,
      ),
      padding: EdgeInsets.only(left: 30, right: 30),
      children: [users(context), cnic(context)],
    ));
  }

  users(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ManageUsers(),
          ),
        );
      },
      splashColor: kPrimaryColor,
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xff453658), borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              "assets/icons/User.svg",
              color: kPrimaryColor,
              width: 42,
            ),
            SizedBox(
              height: 14,
            ),
            Text(
              "Users",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  cnic(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CNICList(),
          ),
        );
      },
      splashColor: kPrimaryColor,
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xff453658), borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              "assets/icons/User.svg",
              color: kPrimaryColor,
              width: 42,
            ),
            SizedBox(
              height: 14,
            ),
            Text(
              "Manage CNIC",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
