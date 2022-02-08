import 'package:cafemm/class/kategori.dart';
import 'package:cafemm/screens/kategori/kategori.dart';
import 'package:cafemm/services/kategori_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'home_build_draw_list_item.dart';

class KategorilerDraw extends StatefulWidget {
  const KategorilerDraw({
    Key? key,
  }) : super(key: key);

  @override
  _KategorilerDrawState createState() => _KategorilerDrawState();
}

class _KategorilerDrawState extends State<KategorilerDraw> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: kategoriService.getKategories(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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

  Widget body(QuerySnapshot querySnapshot) {
    final List<Kategori> kategoriler;
    kategoriler =
        querySnapshot.docs.map((e) => Kategori.fromSnapshot(e)).toList();
    return ExpansionTile(
      title: Text(
        "Kategoriler",
      ),
      children: [
        for (var i = 0; i < kategoriler.length; i++)
          BuildListItem(
            title: kategoriler[i].kategoriAdi,
            icon: Icons.apps,
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => KategoriScreen(
                      reference: kategoriler[i].reference!,
                    ),
                  ),
                  (Route<dynamic> route) => false);
            },
          ),
        const SizedBox(height: 24),
      ],
    );
  }
}
