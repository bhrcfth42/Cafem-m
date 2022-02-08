import 'package:cafemm/class/urun.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'urun_detay_icerik_kismi.dart';
import 'urun_detay_image.dart';

class UrunDetayBody extends StatelessWidget {
  final DocumentReference reference;
  const UrunDetayBody({
    Key? key,
    required this.reference,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
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
    );
  }

  Widget body(
      DocumentSnapshot<Object?> documentSnapshot, BuildContext context) {
    Urun urun;
    urun = Urun.fromSnapshot(documentSnapshot);
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: UrunDetayImage(
              resimler: urun.urunResimler!,
            ),
          ),
          Expanded(
            flex: 7,
            child: UrunDetayIcerik(
              urun: urun,
            ),
          ),
        ],
      ),
    );
  }
}
