import 'package:cafemm/responsive.dart';
import 'package:cafemm/widgets/cafe_kategori_islemleri/cafe_kategori_islemleri_icerik.dart';
import 'package:cafemm/widgets/home/home_logo.dart';
import 'package:cafemm/widgets/home/home_menu_draw.dart';
import 'package:flutter/material.dart';

class CafeKategoriIslemleriBody extends StatelessWidget {
  const CafeKategoriIslemleriBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (Responsive.isDesktop(context))
            Expanded(
              flex: 2,
              child: MenuDraw(),
            ),
          Expanded(
            flex: 7,
            child: Container(
              margin: EdgeInsets.all(20),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (Responsive.isDesktop(context))
                      Container(
                        margin: EdgeInsets.all(8),
                        alignment: Alignment.center,
                        child: Logo(),
                      ),
                    CafeKategoriIslemleriIcerik(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
