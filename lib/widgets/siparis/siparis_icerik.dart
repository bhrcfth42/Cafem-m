import 'package:cafemm/class/user.dart';
import 'package:cafemm/services/user_service.dart';
import 'package:cafemm/widgets/siparis/siparis_list_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SiparisIcerik extends StatelessWidget {
  const SiparisIcerik({Key? key}) : super(key: key);

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

  Widget body(DocumentSnapshot documentSnapshot, BuildContext context) {
    User kullanici = User.fromSnapshot(documentSnapshot);
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: kullanici.userSiparisler!.length,
      shrinkWrap: true,
      padding: EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return SiparisListItem(
          reference: kullanici.userSiparisler![index],
          kullanici: kullanici,
        );
      },
    );
  }
}
