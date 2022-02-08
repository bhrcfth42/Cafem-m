import 'package:cafemm/screens/home/home.dart';
import 'package:cafemm/theme.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
            (Route<dynamic> route) => false);
      },
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          children: [
            TextSpan(
              text: "CAFE",
              style: TextStyle(
                color: ksecondaryColor,
                fontSize: 20,
              ),
            ),
            TextSpan(
              text: "M",
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: 18,
              ),
            ),
            TextSpan(
              text: "M",
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
