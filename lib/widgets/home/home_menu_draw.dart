import 'package:cafemm/class/user.dart';
import 'package:cafemm/screens/cafe/cafe.dart';
import 'package:cafemm/screens/home/home.dart';
import 'package:cafemm/screens/sepet/sepet.dart';
import 'package:cafemm/screens/siparis/siparis.dart';
import 'package:cafemm/services/auth_service.dart';
import 'package:cafemm/services/user_service.dart';
import 'package:cafemm/widgets/home/home_cafe_sahibi_islemler_draw.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'home_build_draw_list_item.dart';
import 'home_cafe_calisanlari_islemler_draw.dart';
import 'home_kategori_draw.dart';
import 'home_profile_draw.dart';

class MenuDraw extends StatelessWidget {
  const MenuDraw({
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
    return Drawer(
      child: ListView(
        children: [
          ProfileDraw(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 24,
                ),
                BuildListItem(
                  title: "Ana Sayfa",
                  icon: Icons.home,
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                        (Route<dynamic> route) => false);
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                BuildListItem(
                  title: "Kafeler & Restoranlar",
                  icon: Icons.local_cafe_rounded,
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => CafeScreen(),
                        ),
                        (Route<dynamic> route) => false);
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                BuildListItem(
                  title: "Sepet",
                  icon: Icons.shopping_bag,
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => SepetScreen(),
                        ),
                        (Route<dynamic> route) => false);
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                BuildListItem(
                  title: "Siparişler",
                  icon: Icons.shopping_cart,
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => SiparisScreen(),
                        ),
                        (Route<dynamic> route) => false);
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                KategorilerDraw(),
                const SizedBox(
                  height: 24,
                ),
                if (kullanici.rol!.rolCafeSahibi!)
                  CafeSahibiIslemlerDraw(
                    kullanici: kullanici,
                  ),
                if (kullanici.rol!.rolCafeSahibi!)
                  const SizedBox(
                    height: 24,
                  ),
                if (kullanici.rol!.rolCafeCalisani!)
                  CafeCalisanlariIslemlerDraw(),
                if (kullanici.rol!.rolCafeCalisani!)
                  const SizedBox(
                    height: 24,
                  ),
                BuildListItem(
                  title: "Çıkış",
                  icon: Icons.logout,
                  onTap: () {
                    authService.logout();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
