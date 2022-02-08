import 'package:cafemm/responsive.dart';
import 'package:cafemm/widgets/calisan_siparisler/calisan_siparisler_body.dart';
import 'package:cafemm/widgets/home/home_AppBar.dart';
import 'package:cafemm/widgets/home/home_menu_draw.dart';
import 'package:flutter/material.dart';

class CalisanSiparislerScreen extends StatelessWidget {
  const CalisanSiparislerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: Responsive.isDesktop(context) ? null : MenuDraw(),
      appBar: Responsive.isDesktop(context) ? null : homeAppBar(),
      body: CalisanSiparisIslemleriBody(),
    );
  }
}
