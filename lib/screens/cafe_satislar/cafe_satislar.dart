import 'package:cafemm/responsive.dart';
import 'package:cafemm/widgets/cafe_satislar/cafe_satislar_body.dart';
import 'package:cafemm/widgets/home/home_AppBar.dart';
import 'package:cafemm/widgets/home/home_menu_draw.dart';
import 'package:flutter/material.dart';

class CafeSatislarScreen extends StatefulWidget {
  const CafeSatislarScreen({Key? key}) : super(key: key);

  @override
  _CafeSatislarScreenState createState() => _CafeSatislarScreenState();
}

class _CafeSatislarScreenState extends State<CafeSatislarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: Responsive.isDesktop(context) ? null : MenuDraw(),
      appBar: Responsive.isDesktop(context) ? null : homeAppBar(),
      body: CafeSatislarBody(),
    );
  }
}
