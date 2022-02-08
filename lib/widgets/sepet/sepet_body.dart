import 'package:cafemm/class/satis.dart';
import 'package:cafemm/class/user.dart';
import 'package:cafemm/responsive.dart';
import 'package:cafemm/services/satis_service.dart';
import 'package:cafemm/services/user_service.dart';
import 'package:cafemm/snackbar.dart';
import 'package:cafemm/theme.dart';
import 'package:cafemm/widgets/home/home_logo.dart';
import 'package:cafemm/widgets/home/home_menu_draw.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'sepet_list_item.dart';

class SepetBody extends StatelessWidget {
  const SepetBody({Key? key}) : super(key: key);

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
                    Container(
                      child: GridView.count(
                        crossAxisCount: Responsive.isDesktop(context) ? 4 : 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        padding: EdgeInsets.all(8),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          for (var i = 0; i < kullanici.userSepet!.length; i++)
                            SepetListItem(
                              sepetUrun: kullanici.userSepet![i],
                              kullanici: kullanici,
                            ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.all(8),
                          primary: Colors.white,
                          backgroundColor: kPrimaryColor,
                        ),
                        onPressed: () {
                          Satis satis = new Satis(
                            urunler: satisOnay(kullanici),
                            satisUrunDurumu: false,
                            satisZamani: DateTime.now(),
                            userRef: kullanici.reference!,
                          );
                          bool res = satisService.yeniSiparis(satis, kullanici);
                          if (res) {
                            ScaffoldMessenger.of(context)
                                .removeCurrentSnackBar();
                            ScaffoldMessenger.of(context)
                                .showSnackBar(trueSnackbar);
                          } else {
                            ScaffoldMessenger.of(context)
                                .removeCurrentSnackBar();
                            ScaffoldMessenger.of(context)
                                .showSnackBar(falseSnackbar);
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.shopping_bag),
                            Text("Siparişi Onayla"),
                          ],
                        ),
                      ),
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

  List<SatisUrun> satisOnay(User kullanici) {
    List<SatisUrun> liste = kullanici.userSepet!
        .map((e) => new SatisUrun(
            satisUrunAdet: e.sepetUrunAdet, satisUrunRef: e.sepetUrunRef))
        .toList();
    return liste;
  }
}
