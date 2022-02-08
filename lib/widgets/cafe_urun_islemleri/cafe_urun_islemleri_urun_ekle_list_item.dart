import 'package:cafemm/class/cafe.dart';
import 'package:cafemm/class/kategori.dart';
import 'package:cafemm/theme.dart';
import 'package:flutter/material.dart';

import 'cafe_urun_islemleri_urun_ekle_dialog.dart';

class CafeUrunIslemleriUrunEkleListItem extends StatelessWidget {
  final Cafe kafe;
  final Kategori kategori;
  const CafeUrunIslemleriUrunEkleListItem({
    Key? key,
    required this.kafe,
    required this.kategori,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (_) => CafeUrunIslemleriUrunEklemeDialog(
              kafe: kafe,
              kategori: kategori,
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
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                "Urun Ekle",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
