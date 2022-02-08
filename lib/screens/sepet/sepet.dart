import 'package:cafemm/responsive.dart';
import 'package:cafemm/widgets/home/home_AppBar.dart';
import 'package:cafemm/widgets/home/home_menu_draw.dart';
import 'package:cafemm/widgets/sepet/sepet_body.dart';
import 'package:flutter/material.dart';

class SepetScreen extends StatelessWidget {
  const SepetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: Responsive.isDesktop(context) ? null : MenuDraw(),
      appBar: Responsive.isDesktop(context) ? null : homeAppBar(),
      body: SepetBody(),
    );
  }
}
