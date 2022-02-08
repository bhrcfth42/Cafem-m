import 'package:cafemm/class/user.dart';
import 'package:cafemm/screens/cafe_bilgileri/cafe_bilgileri.dart';
import 'package:cafemm/screens/cafe_calisanlari/cafe_calisanlari.dart';
import 'package:cafemm/screens/cafe_ciro/cafe_ciro.dart';
import 'package:cafemm/screens/cafe_kategori_islemleri/cafe_kategori_islemleri.dart';
import 'package:cafemm/screens/cafe_satislar/cafe_satislar.dart';
import 'package:cafemm/screens/cafe_urun_islemleri/cafe_urun_islemleri.dart';
import 'package:flutter/material.dart';

import 'home_build_draw_list_item.dart';

class CafeSahibiIslemlerDraw extends StatefulWidget {
  final User kullanici;
  const CafeSahibiIslemlerDraw({
    Key? key,
    required this.kullanici,
  }) : super(key: key);

  @override
  _CafeSahibiIslemlerDrawState createState() => _CafeSahibiIslemlerDrawState();
}

class _CafeSahibiIslemlerDrawState extends State<CafeSahibiIslemlerDraw> {
  @override
  Widget build(BuildContext context) {
    return body(context);
  }

  Widget body(BuildContext context) {
    return ExpansionTile(
      title: Text("Kafe & Restoran İşlemleri"),
      children: [
        BuildListItem(
          title: "Kafe & Restoran Bilgileri",
          icon: Icons.info,
          onTap: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => CafeBilgileriScreen(),
                ),
                (Route<dynamic> route) => false);
          },
        ),
        BuildListItem(
          title: "Kafe & Restoran Çalışanları",
          icon: Icons.work,
          onTap: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => CafeCalisanlariScreen(),
                ),
                (Route<dynamic> route) => false);
          },
        ),
        BuildListItem(
          title: "Kafe & Restoran Siparişler",
          icon: Icons.shopping_basket,
          onTap: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => CafeSatislarScreen(),
                ),
                (Route<dynamic> route) => false);
          },
        ),
        BuildListItem(
          title: "Kafe & Restoran Kategori İşlemleri",
          icon: Icons.apps,
          onTap: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => CafeKategoriIslemleriScreen(),
                ),
                (Route<dynamic> route) => false);
          },
        ),
        BuildListItem(
          title: "Kafe & Restoran Ürün Ekleme",
          icon: Icons.sell,
          onTap: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => CafeUrunIslemleriScreen(),
                ),
                (Route<dynamic> route) => false);
          },
        ),
        BuildListItem(
          title: "Kafe & Restoran Ciro",
          icon: Icons.question_answer,
          onTap: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => CafeCiroScreen(),
                ),
                (Route<dynamic> route) => false);
          },
        ),
        const SizedBox(
          height: 24,
        ),
      ],
    );
  }
}
