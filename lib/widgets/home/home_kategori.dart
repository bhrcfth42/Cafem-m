import 'package:cafemm/theme.dart';
import 'package:flutter/material.dart';

class KategoriListesi extends StatelessWidget {
  final String title;
  final bool isActive;
  final Function press;
  const KategoriListesi({
    Key? key,
    required this.title,
    required this.isActive,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            title,
            style: isActive? TextStyle(
              color: kTextColor,
              fontWeight: FontWeight.bold,
            ):TextStyle( fontSize: 12),
          ),
          if (isActive)
            Container(
              margin: EdgeInsets.all(5),
              width: 20,
              height: 5,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
        ],
      ),
    );
  }
}
