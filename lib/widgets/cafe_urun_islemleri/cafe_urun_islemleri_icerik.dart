import 'package:cafemm/class/cafe.dart';
import 'package:cafemm/class/kategori.dart';
import 'package:cafemm/class/user.dart';
import 'package:cafemm/services/kafe_service.dart';
import 'package:cafemm/services/kategori_service.dart';
import 'package:cafemm/services/user_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'cafe_urun_islemleri_kategori_list_item.dart';

class CafeUrunIslemleriIcerik extends StatelessWidget {
  const CafeUrunIslemleriIcerik({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: userService.getUserDatabase(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Text("Hata");
        } else {
          return cafeBilgiStream(snapshot.data!, context);
        }
      },
    );
  }

  Widget cafeBilgiStream(
      DocumentSnapshot<Object?> documentSnapshot, BuildContext context) {
    User kullanici = User.fromSnapshot(documentSnapshot);
    return StreamBuilder<QuerySnapshot>(
      stream: kafeService.getCafeBilgiKismi(kullanici),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Text("Hata");
        } else {
          return kategoriStream(snapshot.data!.docs.first, context);
        }
      },
    );
  }

  Widget kategoriStream(
      QueryDocumentSnapshot documentSnapshot, BuildContext context) {
    Cafe kafe = Cafe.fromSnapshot(documentSnapshot);
    return StreamBuilder<QuerySnapshot>(
      stream: kategoriService.getCafeKategorilerKismi(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Text("Hata");
        } else {
          return urunStream(snapshot.data!, kafe, context);
        }
      },
    );
  }

  Widget urunStream(
      QuerySnapshot<Object?> snapshot, Cafe kafe, BuildContext context) {
    List<Kategori> kategoriler =
        snapshot.docs.map((e) => Kategori.fromSnapshot(e)).toList();
    return Container(
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width,
      ),
      padding: EdgeInsets.all(8),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(8),
        shrinkWrap: true,
        children: [
          for (var i = 0; i < kategoriler.length; i++)
            CafeUrunIslemleriKategoriListItem(
              kategori: kategoriler[i],
              kafe: kafe,
            ),
        ],
      ),
    );
  }
}
