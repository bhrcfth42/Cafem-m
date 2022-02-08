import 'package:cafemm/responsive.dart';
import 'package:cafemm/widgets/home/home_AppBar.dart';
import 'package:cafemm/widgets/home/home_menu_draw.dart';
import 'package:cafemm/widgets/kategori/kategori_body.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class KategoriScreen extends StatelessWidget {
  final DocumentReference reference;
  const KategoriScreen({
    Key? key,
    required this.reference,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: Responsive.isDesktop(context) ? null : MenuDraw(),
      appBar: Responsive.isDesktop(context) ? null : homeAppBar(),
      body: KategoriBody(
        reference: reference,
      ),
    );
  }
}
