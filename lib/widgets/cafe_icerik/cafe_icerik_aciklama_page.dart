import 'package:cafemm/class/cafe.dart';
import 'package:flutter/material.dart';

class CafeIcerikAciklamaPage extends StatelessWidget {
  final Cafe cafe;
  const CafeIcerikAciklamaPage({
    required this.cafe,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(cafe.cafeAciklama),
          ],
        ),
      ),
    );
  }
}
