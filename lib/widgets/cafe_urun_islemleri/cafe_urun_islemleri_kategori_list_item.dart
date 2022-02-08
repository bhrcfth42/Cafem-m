import 'package:cafemm/class/cafe.dart';
import 'package:cafemm/class/kategori.dart';
import 'package:cafemm/class/urun.dart';
import 'package:cafemm/responsive.dart';
import 'package:cafemm/widgets/cafe_urun_islemleri/cafe_urun_islemleri_urun_list_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'cafe_urun_islemleri_urun_ekle_list_item.dart';

class CafeUrunIslemleriKategoriListItem extends StatelessWidget {
  final Kategori kategori;
  final Cafe kafe;
  const CafeUrunIslemleriKategoriListItem({
    Key? key,
    required this.kategori,
    required this.kafe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        kategori.kategoriAdi,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      children: [
        GridView.count(
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: Responsive.isDesktop(context) ? 4 : 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          padding: EdgeInsets.all(8),
          shrinkWrap: true,
          children: [
            CafeUrunIslemleriUrunEkleListItem(
              kafe: kafe,
              kategori: kategori,
            ),
            for (var i = 0; i < kategori.kategoriUrunler!.length; i++)
              StreamBuilder<DocumentSnapshot>(
                stream: kategori.kategoriUrunler![i].snapshots(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return Text("Hata");
                  } else {
                    Urun urun = Urun.fromSnapshot(snapshot.data!);
                    return CafeUrunIslemleriUrunListItem(
                      urun: urun,
                      kategori: kategori,
                    );
                  }
                },
              ),
          ],
        ),
      ],
    );
  }
}
