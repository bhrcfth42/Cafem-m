import 'package:cafemm/class/cafe.dart';
import 'package:cafemm/class/urun.dart';
import 'package:cafemm/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UrunDetayCafeBilgiKismi extends StatefulWidget {
  final Urun urun;
  const UrunDetayCafeBilgiKismi({
    Key? key,
    required this.urun,
  }) : super(key: key);

  @override
  _UrunDetayCafeBilgiKismiState createState() =>
      _UrunDetayCafeBilgiKismiState();
}

class _UrunDetayCafeBilgiKismiState extends State<UrunDetayCafeBilgiKismi> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: widget.urun.reference!.parent.parent!.snapshots(),
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

  Widget body(DocumentSnapshot data, BuildContext context) {
    Cafe cafe = Cafe.fromSnapshot(data);
    return Row(
      children: [
        Icon(
          Icons.location_on,
          color: ksecondaryColor,
        ),
        SizedBox(
          width: 20,
        ),
        Flexible(
          child: Text(
            cafe.cafeAdi,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
