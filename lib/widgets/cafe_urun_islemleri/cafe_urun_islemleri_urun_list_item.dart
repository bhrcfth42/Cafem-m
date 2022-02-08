import 'dart:convert';

import 'package:cafemm/class/kategori.dart';
import 'package:cafemm/class/urun.dart';
import 'package:cafemm/noImage.dart';
import 'package:cafemm/screens/urun_detay/urun_detay.dart';
import 'package:cafemm/services/urun_service.dart';
import 'package:cafemm/snackbar.dart';
import 'package:cafemm/theme.dart';
import 'package:cafemm/widgets/cafe_urun_islemleri/cafe_urun_islemleri_urun_guncelleme_dialog.dart';
import 'package:flutter/material.dart';

class CafeUrunIslemleriUrunListItem extends StatelessWidget {
  final Urun urun;
  final Kategori kategori;
  const CafeUrunIslemleriUrunListItem({
    Key? key,
    required this.urun,
    required this.kategori,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: MemoryImage(urun.urunResimler!.isNotEmpty
              ? urun.urunResimler![0]
              : Base64Decoder().convert(noImage)),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.delete_forever_rounded),
                    onPressed: () async {
                      bool res =
                          urunService.cafeUrunSilme(urun.reference!, kategori);
                      if (res) {
                        ScaffoldMessenger.of(context).removeCurrentSnackBar();
                        ScaffoldMessenger.of(context)
                            .showSnackBar(trueSnackbar);
                      } else {
                        ScaffoldMessenger.of(context).removeCurrentSnackBar();
                        ScaffoldMessenger.of(context)
                            .showSnackBar(falseSnackbar);
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.update),
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (_) => CafeUrunIslemleriUrunGuncellemeDialog(
                          urun: urun,
                        ),
                      );
                    },
                  ),
                ],
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
