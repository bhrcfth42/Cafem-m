import 'package:cafemm/class/cafe.dart';
import 'package:cafemm/class/satis.dart';
import 'package:cafemm/class/user.dart';
import 'package:cafemm/services/kafe_service.dart';
import 'package:cafemm/services/satis_service.dart';
import 'package:cafemm/services/user_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'calisan_siparisler_list_item.dart';

class CalisanSiparisIslemleriIcerik extends StatelessWidget {
  const CalisanSiparisIslemleriIcerik({Key? key}) : super(key: key);

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
          return calisanStream(snapshot.data!, context);
        }
      },
    );
  }

  Widget calisanStream(
      DocumentSnapshot<Object?> documentSnapshot, BuildContext context) {
    User kullanici = User.fromSnapshot(documentSnapshot);
    return StreamBuilder<QuerySnapshot>(
      stream: kafeService.getCafeCalisanKismi(kullanici),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Text("Hata");
        } else {
          return satislarStream(snapshot.data!.docs.first, context);
        }
      },
    );
  }

  Widget satislarStream(
      QueryDocumentSnapshot documentSnapshot, BuildContext context) {
    Cafe kafe = Cafe.fromSnapshot(documentSnapshot);
    return StreamBuilder<QuerySnapshot>(
      stream: satisService.getCafeSatislarKismi(documentSnapshot),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Text("Hata");
        } else {
          return body(snapshot.data!.docs, kafe, context);
        }
      },
    );
  }

  Widget body(
      List<QueryDocumentSnapshot> docs, Cafe kafe, BuildContext context) {
    List<Satis> satislar = docs.map((e) => Satis.fromSnapshot(e)).toList();
    return ListView(
      padding: EdgeInsets.all(8),
      shrinkWrap: true,
      children: [
        for (var i = 0; i < satislar.length; i++)
          CalisanIslemleriSiparislerListItem(
            satis: satislar[i],
          ),
      ],
    );
  }
}
