import 'package:cafemm/widgets/cafe/cafe_body.dart';
import 'package:cafemm/widgets/home/home_body.dart';
import 'package:cafemm/widgets/kategori/kategori_body.dart';
import 'package:cafemm/widgets/sepet/sepet_body.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Pages extends StatelessWidget {
  final int? page;
  final DocumentReference? reference;
  const Pages({Key? key, this.page, this.reference}) : super(key: key);

  static Widget isHome(BuildContext context) => HomeBody();
  static Widget isKafelerveRestoranlar(BuildContext context) => CafeBody();
  static Widget isSepet(BuildContext context) => SepetBody();

  @override
  Widget build(BuildContext context) {
    print(page);
    switch (page) {
      case 0:
        return CafeBody();
      case 1:
        return SepetBody();
      case 2:
        return KategoriBody(reference: reference!);
      default:
        return HomeBody();
    }
  }
}
