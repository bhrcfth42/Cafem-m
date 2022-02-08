import 'package:cafemm/class/urun.dart';
import 'package:cafemm/class/user.dart';
import 'package:cafemm/services/user_service.dart';
import 'package:cafemm/snackbar.dart';
import 'package:cafemm/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UrunDetaySepetEklemeButon extends StatelessWidget {
  final Urun urun;
  const UrunDetaySepetEklemeButon({Key? key, required this.urun})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(8),
          primary: Colors.white,
          backgroundColor: kPrimaryColor,
        ),
        onPressed: () {
          bool res;
          Sepet yeniUrun;
          if (kullanici.userSepet!.length == 0) {
            Sepet yeniUrun =
                Sepet(sepetUrunRef: urun.reference!, sepetUrunAdet: 1);
            kullanici.userSepet!.add(yeniUrun);
            res = userService.update(kullanici);
          } else if (kullanici.userSepet!
              .singleWhere((element) => element.sepetUrunRef == urun.reference,
                  orElse: () {
                yeniUrun =
                    Sepet(sepetUrunRef: urun.reference!, sepetUrunAdet: 0);
                kullanici.userSepet!.add(yeniUrun);
                res = userService.update(kullanici);
                return yeniUrun;
              })
              .sepetUrunRef
              .id
              .isEmpty) {
            yeniUrun = Sepet(sepetUrunRef: urun.reference!, sepetUrunAdet: 1);
            kullanici.userSepet!.add(yeniUrun);
            res = userService.update(kullanici);
          } else {
            kullanici.userSepet!
                .singleWhere(
                    (element) => element.sepetUrunRef == urun.reference)
                .sepetUrunAdet++;
            res = userService.update(kullanici);
          }
          if (res) {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(trueSnackbar);
          } else {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(falseSnackbar);
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.shopping_bag),
            Text("Sepete Ekle"),
          ],
        ),
      ),
    );
  }
}
