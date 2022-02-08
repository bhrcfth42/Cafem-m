import 'dart:convert';

import 'package:cafemm/class/user.dart';
import 'package:cafemm/noImage.dart';
import 'package:cafemm/screens/profil_duzenleme/profil_duzenleme.dart';
import 'package:cafemm/services/user_service.dart';
import 'package:cafemm/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfileDraw extends StatelessWidget {
  const ProfileDraw({
    Key? key,
  }) : super(key: key);

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
          return body(snapshot.data!, context);
        }
      },
    );
  }

  Widget body(
      DocumentSnapshot<Object?> documentSnapshot, BuildContext context) {
    User kullanici = User.fromSnapshot(documentSnapshot);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => ProfilDuzenlemeScreen(),
            ),
            (Route<dynamic> route) => false);
      },
      child: DrawerHeader(
        decoration: BoxDecoration(
          color: kPrimaryColor,
        ),
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: kullanici.userResim!.lengthInBytes > 0
                  ? MemoryImage(kullanici.userResim!)
                  : MemoryImage(Base64Decoder().convert(noImage)),
              maxRadius: 40,
            ),
            const SizedBox(
              height: 8,
            ),
            Flexible(
              child: Text(
                "${kullanici.userAdi} ${kullanici.userSoyadi}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Flexible(
              child: Text(
                kullanici.userEposta,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
