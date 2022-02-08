import 'package:cafemm/class/cafe.dart';
import 'package:flutter/material.dart';

import 'cafe_detay_button_kismi.dart';
import 'cafe_detay_isim_kismi.dart';
import 'cafe_icerik_aciklama_page.dart';
import 'cafe_icerik_urunler_list_page.dart';

class CafeIcerikDetay extends StatelessWidget {
  final Cafe cafe;
  const CafeIcerikDetay({
    required this.cafe,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: 0);
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: CafeDetayCafeIsimKismi(cafe: cafe),
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            flex: 1,
            child: CafeDetayButtonKismi(controller: controller),
          ),
          Expanded(
            flex: 7,
            child: PageView(
              controller: controller,
              children: [
                CafeIcerikAciklamaPage(
                  cafe: cafe,
                ),
                CafeIcerikUrunlerListPage(
                  reference: cafe.reference!,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
