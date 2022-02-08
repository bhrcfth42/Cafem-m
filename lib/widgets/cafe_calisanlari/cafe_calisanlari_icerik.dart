import 'package:cafemm/class/cafe.dart';
import 'package:cafemm/class/user.dart';
import 'package:cafemm/services/kafe_service.dart';
import 'package:cafemm/services/user_service.dart';
import 'package:cafemm/widgets/cafe_calisanlari/cafe_calisan_ekleme_dialog.dart';
import 'package:cafemm/widgets/cafe_calisanlari/cafe_calisanlari_icerik_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CafeCalisanlariIcerik extends StatefulWidget {
  const CafeCalisanlariIcerik({Key? key}) : super(key: key);

  @override
  _CafeCalisanlariIcerikState createState() => _CafeCalisanlariIcerikState();
}

class _CafeCalisanlariIcerikState extends State<CafeCalisanlariIcerik> {
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
          return body(snapshot.data!.docs.first, context);
        }
      },
    );
  }

  Widget body(DocumentSnapshot documentSnapshot, BuildContext context) {
    Cafe kafe = Cafe.fromSnapshot(documentSnapshot);
    return Container(
      padding: EdgeInsets.all(8),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton.icon(
              icon: Icon(Icons.add_circle_rounded),
              label: Text(
                "Çalışan Ekle",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => CafeCAlisanEklemeDialog(
                    kafe: kafe,
                  ),
                );
              },
            ),
            ListView(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(8),
              shrinkWrap: true,
              children: [
                for (var i = 0; i < kafe.cafeCalisanlari!.length; i++)
                  StreamBuilder<DocumentSnapshot>(
                    stream: kafe.cafeCalisanlari![i].snapshots(),
                    builder:
                        (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (!snapshot.hasData || snapshot.data == null) {
                        return Text("Hata");
                      } else {
                        return CafeCalisanlariIcerikListItem(
                          calisan: User.fromSnapshot(snapshot.data!),
                          kafe: kafe,
                        );
                      }
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
