import 'package:cafemm/class/urun.dart';
import 'package:cafemm/services/urun_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'home_urun_item_card.dart';

class UrunItemCardList extends StatefulWidget {
  const UrunItemCardList({
    Key? key,
  }) : super(key: key);

  @override
  _UrunItemCardListState createState() => _UrunItemCardListState();
}

class _UrunItemCardListState extends State<UrunItemCardList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: urunService.getUruns(),
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
    List<Urun> urunler =
        querySnapshot.docs.map((e) => Urun.fromSnapshot(e)).toList();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var i = 0; i < urunler.length; i++)
            UrunItemCard(
              urun: urunler[i],
            ),
        ],
      ),
    );
  }
}
