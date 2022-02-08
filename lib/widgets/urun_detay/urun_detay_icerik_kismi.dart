import 'package:cafemm/class/urun.dart';
import 'package:flutter/material.dart';

import 'urun_detay_aciklama_kismi.dart';
import 'urun_detay_ad_fiyat_kismi.dart';
import 'urun_detay_cafe_bilgi_kismi.dart';
import 'urun_detay_sepet_buton.dart';

class UrunDetayIcerik extends StatefulWidget {
  final Urun urun;
  const UrunDetayIcerik({
    Key? key,
    required this.urun,
  }) : super(key: key);

  @override
  _UrunDetayIcerikState createState() => _UrunDetayIcerikState();
}

class _UrunDetayIcerikState extends State<UrunDetayIcerik> {
  @override
  Widget build(BuildContext context) {
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
          UrunDetayCafeBilgiKismi(
            urun: widget.urun,
          ),
          const SizedBox(
            height: 8,
          ),
          UrunDetayIsimFiyatKismi(
            urun: widget.urun,
          ),
          const SizedBox(
            height: 8,
          ),
          UrunDetayAciklamaKismi(
            aciklama: widget.urun.urunAciklama,
          ),
          UrunDetaySepetEklemeButon(
            urun: widget.urun,
          ),
        ],
      ),
    );
  }
}
