import 'package:cafemm/class/satis.dart';
import 'package:cafemm/class/urun.dart';
import 'package:cafemm/class/user.dart';
import 'package:cafemm/responsive.dart';
import 'package:cafemm/screens/urun_detay/urun_detay.dart';
import 'package:cafemm/services/satis_service.dart';
import 'package:cafemm/snackbar.dart';
import 'package:cafemm/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SiparisListItem extends StatelessWidget {
  final DocumentReference reference;
  final User kullanici;
  const SiparisListItem({
    Key? key,
    required this.reference,
    required this.kullanici,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          return body(snapshot.data!, context);
        }
      },
    );
  }

  Widget body(DocumentSnapshot documentSnapshot, BuildContext context) {
    Satis satis = Satis.fromSnapshot(documentSnapshot);
    return ExpansionTile(
      title: Text(
        "${satis.satisZamani.day}/${satis.satisZamani.month}/${satis.satisZamani.year} ${satis.satisZamani.hour}:${satis.satisZamani.minute}",
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
      collapsedBackgroundColor:
          satis.satisUrunDurumu ? Colors.lightGreen[200] : Colors.red[200],
      backgroundColor:
          satis.satisUrunDurumu ? Colors.lightGreen[200] : Colors.red[200],
      children: [
        GridView.count(
          crossAxisCount: Responsive.isDesktop(context) ? 4 : 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          padding: EdgeInsets.all(8),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            if (!satis.satisUrunDurumu) siparisSil(context),
            for (var i = 0; i < satis.urunler.length; i++)
              StreamBuilder<DocumentSnapshot>(
                stream: satis.urunler[i].satisUrunRef.snapshots(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return Text("Hata");
                  } else {
                    return urunBody(snapshot.data!, satis.urunler[i], context);
                  }
                },
              ),
          ],
        ),
      ],
    );
  }

  Widget urunBody(
    DocumentSnapshot<Object?> documentSnapshot,
    SatisUrun satisUrun,
    BuildContext context,
  ) {
    Urun urun = Urun.fromSnapshot(documentSnapshot);
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

  Widget siparisSil(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          bool res = satisService.siparisSil(reference, kullanici);
          if (res) {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(trueSnackbar);
          } else {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(falseSnackbar);
          }
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  "Sipariş Sil",
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
