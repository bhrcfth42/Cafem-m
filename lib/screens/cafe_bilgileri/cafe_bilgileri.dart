import 'package:cafemm/responsive.dart';
import 'package:cafemm/widgets/cafe_bilgileri/cafe_bilgileri_body.dart';
import 'package:cafemm/widgets/home/home_AppBar.dart';
import 'package:cafemm/widgets/home/home_menu_draw.dart';
import 'package:flutter/material.dart';

class CafeBilgileriScreen extends StatefulWidget {
  const CafeBilgileriScreen({Key? key}) : super(key: key);

  @override
  _CafeBilgileriScreenState createState() => _CafeBilgileriScreenState();
}

class _CafeBilgileriScreenState extends State<CafeBilgileriScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: Responsive.isDesktop(context) ? null : MenuDraw(),
      appBar: Responsive.isDesktop(context) ? null : homeAppBar(),
      body: CafeBilgileriBody(),
    );
  }
}
