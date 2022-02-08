import 'package:cafemm/class/cafe.dart';
import 'package:cafemm/class/user.dart';
import 'package:cafemm/services/kafe_service.dart';
import 'package:cafemm/services/user_service.dart';
import 'package:cafemm/widgets/cafe_bilgileri/cafe_bilgileri_aciklama_duzenleme_dialog.dart';
import 'package:cafemm/widgets/cafe_bilgileri/cafe_bilgileri_adi_d%C3%BCzenleme_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'cafe_bilgileri_adres_duzenleme_dialog.dart';
import 'cafe_bilgileri_logo_duzenleme_dialog.dart';

class CafeBilgileriIcerik extends StatefulWidget {
  const CafeBilgileriIcerik({Key? key}) : super(key: key);

  @override
  _CafeBilgileriIcerikState createState() => _CafeBilgileriIcerikState();
}

class _CafeBilgileriIcerikState extends State<CafeBilgileriIcerik> {
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
      child: Column(
        children: [
          SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: () => showDialog(
              context: context,
              builder: (_) => CafeBilgileriLogoDuzenleme(
                kafe: kafe,
              ),
            ),
            child: CircleAvatar(
              backgroundImage: MemoryImage(kafe.cafeLogo!),
              maxRadius: 100,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          ListTile(
            title: Text("Kafe & Restoran Adı"),
            subtitle: Text(
              kafe.cafeAdi,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
              onPressed: () => showDialog(
                context: context,
                builder: (_) => CafeBilgileriAdiDuzenleme(
                  kafe: kafe,
                ),
              ),
              icon: Icon(
                Icons.edit,
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          ListTile(
            title: Text("Kafe & Restoran Açıklaması"),
            subtitle: Text(
              kafe.cafeAciklama,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
              onPressed: () => showDialog(
                context: context,
                builder: (_) => CafeBilgileriAciklamaDuzenleme(
                  kafe: kafe,
                ),
              ),
              icon: Icon(
                Icons.edit,
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          ListTile(
            title: Text("Kafe & Restoran Adresi"),
            subtitle: Text(
              kafe.cafeAdres,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
              onPressed: () => showDialog(
                context: context,
                builder: (_) => CafeBilgileriAdresDuzenleme(
                  kafe: kafe,
                ),
              ),
              icon: Icon(
                Icons.edit,
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
