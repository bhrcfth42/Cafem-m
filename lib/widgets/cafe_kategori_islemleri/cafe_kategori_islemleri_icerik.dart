import 'package:cafemm/class/cafe.dart';
import 'package:cafemm/class/kategori.dart';
import 'package:cafemm/class/user.dart';
import 'package:cafemm/responsive.dart';
import 'package:cafemm/services/kafe_service.dart';
import 'package:cafemm/services/kategori_service.dart';
import 'package:cafemm/services/user_service.dart';
import 'package:cafemm/widgets/cafe_kategori_islemleri/cafe_kategori_islemleri_kategori_ekleme_dialog.dart';
import 'package:cafemm/widgets/cafe_kategori_islemleri/cafe_kategori_islemleri_list_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CafeKategoriIslemleriIcerik extends StatelessWidget {
  const CafeKategoriIslemleriIcerik({Key? key}) : super(key: key);

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
          return kategorilerStream(snapshot.data!.docs.first, context);
        }
      },
    );
  }

  Widget kategorilerStream(
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
          return body(snapshot.data!, kafe, context);
        }
      },
    );
  }

  Widget body(QuerySnapshot snapshot, Cafe kafe, BuildContext context) {
    List<Kategori> kategoriler =
        snapshot.docs.map((e) => Kategori.fromSnapshot(e)).toList();
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton.icon(
            icon: Icon(Icons.add_circle_rounded),
            label: Text(
              "Kategori Ekle",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => CafeKategoriIslemleriKategoriEkleme(
                  kafe: kafe,
                ),
              );
            },
          ),
          GridView.count(
            crossAxisCount: Responsive.isDesktop(context) ? 4 : 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(8),
            shrinkWrap: true,
            children: [
              for (var i = 0; i < kategoriler.length; i++)
                CafeKategoriIslemleriListItem(kategori: kategoriler[i]),
            ],
          ),
        ],
      ),
    );
  }
}
