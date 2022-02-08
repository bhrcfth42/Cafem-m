import 'package:cafemm/class/cafe.dart';
import 'package:cafemm/services/kafe_service.dart';
import 'package:cafemm/widgets/cafe_icerik/cafe_icerik_detay_kismi.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'cafe_icerik_image_kismi.dart';

class CafeIcerikBody extends StatefulWidget {
  final Cafe cafe;
  const CafeIcerikBody({Key? key, required this.cafe}) : super(key: key);

  @override
  _CafeIcerikBodyState createState() => _CafeIcerikBodyState();
}

class _CafeIcerikBodyState extends State<CafeIcerikBody> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: kafeService.getOneCafe(widget.cafe.reference!),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
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

  Widget body(DocumentSnapshot documentSnapshot) {
    Cafe cafe;
    cafe = Cafe.fromSnapshot(documentSnapshot);
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: CafeIcerikImage(
              cafe: cafe,
            ),
          ),
          Expanded(
            flex: 7,
            child: CafeIcerikDetay(
              cafe: cafe,
            ),
          ),
        ],
      ),
    );
  }
}
