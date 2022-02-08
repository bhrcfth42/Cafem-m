import 'package:flutter/material.dart';

import 'home_kategori.dart';

class HomeKategoriListesi extends StatelessWidget {
  const HomeKategoriListesi({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var i = 0; i < 20; i++)
            i == 0
                ? KategoriListesi(
                    title: "Combo Meal",
                    isActive: true,
                    press: () {},
                  )
                : KategoriListesi(
                    title: "Combo Meal",
                    isActive: false,
                    press: () {},
                  ),
        ],
      ),
    );
  }
}
