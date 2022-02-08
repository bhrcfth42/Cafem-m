import 'package:cafemm/responsive.dart';
import 'package:cafemm/widgets/home/home_logo.dart';
import 'package:cafemm/widgets/home/home_menu_draw.dart';
import 'package:flutter/material.dart';

import 'cafe_satislar_icerik.dart';

class CafeSatislarBody extends StatefulWidget {
  const CafeSatislarBody({Key? key}) : super(key: key);

  @override
  _CafeSatislarBodyState createState() => _CafeSatislarBodyState();
}

class _CafeSatislarBodyState extends State<CafeSatislarBody> {
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
                    CafeSatislarIcerik(),
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
