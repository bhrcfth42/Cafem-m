import 'package:cafemm/responsive.dart';
import 'package:cafemm/theme.dart';
import 'package:cafemm/widgets/urun_detay/urun_detay_body.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UrunDetayScreen extends StatelessWidget {
  final DocumentReference reference;
  const UrunDetayScreen({
    Key? key,
    required this.reference,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: Responsive.isDesktop(context) ? null : AppBar(),
      backgroundColor: kPrimaryColor,
      body: UrunDetayBody(
        reference: reference,
      ),
    );
  }
}
