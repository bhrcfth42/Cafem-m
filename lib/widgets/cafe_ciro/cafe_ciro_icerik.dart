import 'package:cafemm/class/cafe.dart';
import 'package:cafemm/class/satis.dart';
import 'package:cafemm/class/urun.dart';
import 'package:cafemm/class/user.dart';
import 'package:cafemm/responsive.dart';
import 'package:cafemm/screens/urun_detay/urun_detay.dart';
import 'package:cafemm/services/kafe_service.dart';
import 'package:cafemm/services/user_service.dart';
import 'package:cafemm/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CafeCiroIcerik extends StatefulWidget {
  const CafeCiroIcerik({Key? key}) : super(key: key);

  @override
  _CafeCiroIcerikState createState() => _CafeCiroIcerikState();
}

class _CafeCiroIcerikState extends State<CafeCiroIcerik> {
  double toplam = 0;
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
          return cafeBilgiStream(snapshot.data!, context);
        }
      },
    );
  }

  Widget cafeBilgiStream(
      DocumentSnapshot<Object?> documentSnapshot, BuildContext context) {
    User kullanici = User.fromSnapshot(documentSnapshot);
    return StreamBuilder<QuerySnapshot>(
      stream: kafeService.getCafeBilgiKismi(kullanici),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Text("Hata");
        } else {
          return cafeSatislarStream(snapshot.data!.docs.first, context);
        }
      },
    );
  }

  Widget cafeSatislarStream(
      DocumentSnapshot documentSnapshot, BuildContext context) {
    Cafe kafe = Cafe.fromSnapshot(documentSnapshot);
    return StreamBuilder<QuerySnapshot>(
      stream: kafeService.getCafeCiroKismi(kafe.reference!),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Text("Hata");
        } else {
          return satislarList(snapshot.data!, context);
        }
      },
    );
  }

  Widget satislarList(QuerySnapshot snapshot, BuildContext context) {
    List<Satis> satislar =
        snapshot.docs.map((e) => Satis.fromSnapshot(e)).toList();
    // return satislar.map((e) => satisItem(e)).first;
    return ListView(
      padding: EdgeInsets.all(8),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: satislar.map((e) => satisItem(e)).toList(),
    );
  }

  Widget satisItem(Satis satis) {
    toplam = 0;
    return ExpansionTile(
      title: Text(
        "${satis.satisZamani.day}/${satis.satisZamani.month}/${satis.satisZamani.year} ${satis.satisZamani.hour}:${satis.satisZamani.minute}",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      children: [
        GridView.count(
          crossAxisCount: Responsive.isDesktop(context) ? 4 : 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          padding: EdgeInsets.all(8),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: satis.urunler
              .map((e) => satilmisUrunlerStream(e.satisUrunRef, e))
              .toList(),
        ),
        Padding(
          padding: EdgeInsets.all(5),
          child: Text(
            "Toplam Tutar: ${toplam.toString()} ₺",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget satilmisUrunlerStream(
      DocumentReference reference, SatisUrun satisUrun) {
    return StreamBuilder<DocumentSnapshot>(
      stream: reference.snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Text("Hata");
        } else {
          return urunBody(snapshot.data!, satisUrun, context);
        }
      },
    );
  }

  Widget urunBody(
    DocumentSnapshot<Object?> documentSnapshot,
    SatisUrun satisUrun,
    BuildContext context,
  ) {
    Urun urun = Urun.fromSnapshot(documentSnapshot);
    toplam += satisUrun.satisUrunAdet * urun.urunFiyat;
    return Container(
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: MemoryImage(urun.urunResimler![0]),
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => UrunDetayScreen(
                reference: urun.reference!,
              ),
            ),
          );
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [
                Color(0xFFFF961F).withOpacity(0.7),
                kPrimaryColor.withOpacity(0.7),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  "${satisUrun.satisUrunAdet.toString()} Adet",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  urun.urunAdi,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
