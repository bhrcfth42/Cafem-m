import 'package:cafemm/theme.dart';
import 'package:flutter/material.dart';

class CafeDetayButtonKismi extends StatelessWidget {
  const CafeDetayButtonKismi({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.all(8),
            backgroundColor: kPrimaryColor,
            primary: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.note),
              Text("Açıklama"),
            ],
          ),
          onPressed: () {
            controller.jumpToPage(0);
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.all(8),
            backgroundColor: kPrimaryColor,
            primary: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.food_bank),
              Text("Ürünler"),
            ],
          ),
          onPressed: () {
            controller.jumpToPage(1);
          },
        ),
      ],
    );
  }
}
