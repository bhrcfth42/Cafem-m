import 'package:cafemm/class/kategori.dart';
import 'package:cafemm/responsive.dart';
import 'package:cafemm/theme.dart';
import 'package:cafemm/widgets/home/home_logo.dart';
import 'package:cafemm/widgets/home/home_menu_draw.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'kategori_urun_list.dart';

class KategoriBody extends StatelessWidget {
  final DocumentReference reference;
  const KategoriBody({
    Key? key,
    required this.reference,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (Responsive.isDesktop(context))
            Expanded(
              flex: 2,
              child: MenuDraw(),
            ),
          StreamBuilder(
            stream: reference.snapshots(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (!snapshot.hasData || snapshot.data == null) {
                return Text("Hata");
              } else {
                return body(snapshot.data!, context);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget body(
      DocumentSnapshot<Object?> documentSnapshot, BuildContext context) {
    Kategori kategori;
    kategori = Kategori.fromSnapshot(documentSnapshot);
    return Expanded(
      flex: 7,
      child: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Container(
                margin: EdgeInsets.all(8),
                alignment: Alignment.center,
                child: Logo(),
              ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: MemoryImage(kategori.kategoriResim!),
                ),
              ),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFFF961F).withOpacity(0.7),
                      kPrimaryColor.withOpacity(0.7),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        kategori.kategoriAdi,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            KategoriUrunList(
              urunler: kategori.kategoriUrunler!,
            ),
          ],
        ),
      ),
    );
  }
}
