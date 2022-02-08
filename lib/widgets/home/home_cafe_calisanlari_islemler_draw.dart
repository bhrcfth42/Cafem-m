import 'package:cafemm/class/user.dart';
import 'package:cafemm/screens/calisan_siparisler/calisan_siparisler.dart';
import 'package:cafemm/services/user_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'home_build_draw_list_item.dart';

class CafeCalisanlariIslemlerDraw extends StatelessWidget {
  const CafeCalisanlariIslemlerDraw({
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
    return kullanici.rol!.rolCafeCalisani!
        ? calisanMenu(kullanici, context)
        : SizedBox();
  }

  Widget calisanMenu(User kullanici, BuildContext context) {
    return ExpansionTile(
      title: Text("Çalışan İşlemleri"),
      children: [
        BuildListItem(
          title: "Siparişler",
          icon: Icons.info,
          onTap: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => CalisanSiparislerScreen(),
                ),
                (Route<dynamic> route) => false);
          },
        ),
      ],
    );
  }
}
