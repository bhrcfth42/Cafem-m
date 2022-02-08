import 'package:cafemm/class/cafe.dart';
import 'package:cafemm/responsive.dart';
import 'package:cafemm/services/kafe_service.dart';
import 'package:cafemm/widgets/home/home_logo.dart';
import 'package:cafemm/widgets/home/home_menu_draw.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'cafe_list_item.dart';

class CafeBody extends StatefulWidget {
  const CafeBody({Key? key}) : super(key: key);

  @override
  _CafeBodyState createState() => _CafeBodyState();
}

class _CafeBodyState extends State<CafeBody> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: kafeService.getCafes(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Text("Hata");
        } else {
          return body(snapshot.data!,context);
        }
      },
    );
  }

  Widget body(QuerySnapshot querySnapshot, BuildContext context) {
    List<Cafe> cafeler;
    cafeler = querySnapshot.docs.map((e) => Cafe.fromSnapshot(e)).toList();
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
                  children: [
                    if (Responsive.isDesktop(context))
                      Container(
                        margin: EdgeInsets.all(8),
                        alignment: Alignment.center,
                        child: Logo(),
                      ),
                    Column(
                      children: [
                        for (var i = 0; i < cafeler.length; i++)
                          CafeListItem(
                            cafe: cafeler[i],
                          ),
                      ],
                    ),
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
