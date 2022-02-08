import 'package:cafemm/class/cafe.dart';
import 'package:cafemm/class/urun.dart';
import 'package:cafemm/screens/urun_detay/urun_detay.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UrunItemCard extends StatelessWidget {
  final Urun urun;
  const UrunItemCard({
    Key? key,
    required this.urun,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => UrunDetayScreen(
              reference: urun.reference!,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: MemoryImage(
                  urun.urunResimler![0],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                urun.urunAdi.length > 20
                    ? "${urun.urunAdi.substring(0, 17)}..."
                    : urun.urunAdi,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            StreamBuilder<DocumentSnapshot>(
              stream: urun.reference!.parent.parent!.snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return Text("Hata");
                } else {
                  return cafeAdi(snapshot.data!);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget cafeAdi(DocumentSnapshot<Object?> documentSnapshot) {
    Cafe cafe = Cafe.fromSnapshot(documentSnapshot);
    return Padding(
      padding: EdgeInsets.all(5),
      child: Text(
        cafe.cafeAdi.length > 20
            ? "${cafe.cafeAdi.substring(0, 17)}..."
            : cafe.cafeAdi,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
