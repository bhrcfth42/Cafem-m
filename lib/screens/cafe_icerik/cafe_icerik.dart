import 'package:cafemm/class/cafe.dart';
import 'package:cafemm/responsive.dart';
import 'package:cafemm/theme.dart';
import 'package:cafemm/widgets/cafe_icerik/cafe_icerik_body.dart';
import 'package:flutter/material.dart';

class CafeIcerikScreen extends StatelessWidget {
  final Cafe cafe;
  const CafeIcerikScreen({Key? key, required this.cafe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: Responsive.isDesktop(context) ? null : AppBar(),
      backgroundColor: kPrimaryColor,
      body: CafeIcerikBody(
        cafe: cafe,
      ),
    );
  }
}
