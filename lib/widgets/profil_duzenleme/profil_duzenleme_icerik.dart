import 'package:cafemm/class/user.dart';
import 'package:cafemm/services/user_service.dart';
import 'package:cafemm/widgets/profil_duzenleme/profil_duzenleme_kafe_kurma.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'profil_duzenleme_adi.dart';
import 'profil_duzenleme_soyadi.dart';
import 'profile_duzenleme_resim.dart';

class ProfilDuzenlemeIcerik extends StatelessWidget {
  const ProfilDuzenlemeIcerik({Key? key}) : super(key: key);

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
    return Column(
      children: [
        SizedBox(
          height: 12,
        ),
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (_) => ProfilDuzenlemeResim(
                kullanici: kullanici,
              ),
            );
          },
          child: CircleAvatar(
            backgroundImage: MemoryImage(kullanici.userResim!),
            maxRadius: 100,
          ),
        ),
        SizedBox(
          height: 12,
        ),
        ListTile(
          title: Text("Adınız"),
          subtitle: Text(
            kullanici.userAdi,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => ProfilDuzenlemeAdi(
                  kullanici: kullanici,
                ),
              );
            },
            icon: Icon(
              Icons.edit,
            ),
          ),
        ),
        SizedBox(
          height: 12,
        ),
        ListTile(
          title: Text("Soyadınız"),
          subtitle: Text(
            kullanici.userSoyadi,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => ProfilDuzenlemeSoyadi(
                  kullanici: kullanici,
                ),
              );
            },
            icon: Icon(
              Icons.edit,
            ),
          ),
        ),
        SizedBox(
          height: 12,
        ),
        ListTile(
          title: Text("E-Mail"),
          subtitle: Text(
            kullanici.userEposta,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          height: 12,
        ),
        if (!kullanici.rol!.rolCafeSahibi!)
          ListTile(
            title: Text("Kafe Kur"),
            subtitle: Text(
              "uygulamada yeni bir kafe sahibi olarak kullanabilmek için kullanılmaktadır.",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => ProfilDuzenlemeKafeKurma(
                    kullanici: kullanici,
                  ),
                );
              },
              icon: Icon(
                Icons.add,
              ),
            ),
          ),
        if (!kullanici.rol!.rolCafeSahibi!)
          SizedBox(
            height: 12,
          ),
      ],
    );
  }
}
