import 'package:cafemm/responsive.dart';
import 'package:cafemm/widgets/cafe_calisanlari/cafe_calisanlari_body.dart';
import 'package:cafemm/widgets/home/home_AppBar.dart';
import 'package:cafemm/widgets/home/home_menu_draw.dart';
import 'package:flutter/material.dart';

class CafeCalisanlariScreen extends StatefulWidget {
  const CafeCalisanlariScreen({Key? key}) : super(key: key);

  @override
  _CafeCalisanlariScreenState createState() => _CafeCalisanlariScreenState();
}

class _CafeCalisanlariScreenState extends State<CafeCalisanlariScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: Responsive.isDesktop(context) ? null : MenuDraw(),
      appBar: Responsive.isDesktop(context) ? null : homeAppBar(),
      body: CafeCalisanlariBody(),
    );
  }
}
