import 'package:cafemm/class/cafe.dart';
import 'package:cafemm/services/kafe_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'home_cafe_item_card.dart';

class CafeItemCardList extends StatefulWidget {
  const CafeItemCardList({
    Key? key,
  }) : super(key: key);

  @override
  _CafeItemCardListState createState() => _CafeItemCardListState();
}

class _CafeItemCardListState extends State<CafeItemCardList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: kafeService.getCafes(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Text("Hata");
        } else {
          return body(snapshot.data!);
        }
      },
    );
  }

  Widget body(QuerySnapshot snapshot) {
    List<Cafe> cafeler;
    cafeler = snapshot.docs.map((e) => Cafe.fromSnapshot(e)).toList();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var i = 0; i < cafeler.length; i++)
            CafeItemCard(
              cafe: cafeler[i],
            ),
        ],
      ),
    );
  }
}
