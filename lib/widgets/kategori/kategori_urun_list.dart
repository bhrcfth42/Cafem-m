import 'package:cafemm/responsive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'kategori_urun_list_item.dart';

class KategoriUrunList extends StatelessWidget {
  final List<DocumentReference> urunler;
  const KategoriUrunList({
    Key? key,
    required this.urunler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: Responsive.isDesktop(context) ? 4 : 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        padding: EdgeInsets.all(8),
        shrinkWrap: true,
        children: [
          for (var i = 0; i < urunler.length; i++)
            KategoriUrunListItem(
              reference: urunler[i],
            ),
        ],
      ),
    );
  }
}
