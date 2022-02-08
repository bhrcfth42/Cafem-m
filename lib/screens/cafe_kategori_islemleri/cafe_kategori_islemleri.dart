import 'package:cafemm/responsive.dart';
import 'package:cafemm/widgets/cafe_kategori_islemleri/cafe_kategori_islemleri_body.dart';
import 'package:cafemm/widgets/home/home_AppBar.dart';
import 'package:cafemm/widgets/home/home_menu_draw.dart';
import 'package:flutter/material.dart';

class CafeKategoriIslemleriScreen extends StatefulWidget {
  const CafeKategoriIslemleriScreen({Key? key}) : super(key: key);

  @override
  _CafeKategoriIslemleriScreenState createState() =>
      _CafeKategoriIslemleriScreenState();
}

class _CafeKategoriIslemleriScreenState
    extends State<CafeKategoriIslemleriScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: Responsive.isDesktop(context) ? null : MenuDraw(),
      appBar: Responsive.isDesktop(context) ? null : homeAppBar(),
      body: CafeKategoriIslemleriBody(),
    );
  }
}
