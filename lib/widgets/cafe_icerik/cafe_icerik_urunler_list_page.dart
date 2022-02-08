import 'package:cafemm/class/urun.dart';
import 'package:cafemm/responsive.dart';
import 'package:cafemm/services/urun_service.dart';
import 'package:cafemm/widgets/cafe_icerik/cafe_icerik_urun_list_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CafeIcerikUrunlerListPage extends StatelessWidget {
  final DocumentReference reference;
  const CafeIcerikUrunlerListPage({
    Key? key,
    required this.reference,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: urunService.cafegetUruns(reference),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
    );
  }

  Widget body(QuerySnapshot<Object?> querySnapshot, BuildContext context) {
    List<Urun> urunler;
    urunler = querySnapshot.docs.map((e) => Urun.fromSnapshot(e)).toList();
    return Container(
      child: GridView.count(
        crossAxisCount: Responsive.isDesktop(context) ? 4 : 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        padding: EdgeInsets.all(8),
        shrinkWrap: true,
        children: [
          for (var i = 0; i < urunler.length; i++)
            CafeIcerikUrunlerListItem(
              urun: urunler[i],
            ),
        ],
      ),
    );
  }
}
