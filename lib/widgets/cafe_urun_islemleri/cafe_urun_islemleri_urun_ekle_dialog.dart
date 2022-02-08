import 'dart:typed_data';

import 'package:cafemm/class/cafe.dart';
import 'package:cafemm/class/kategori.dart';
import 'package:cafemm/class/urun.dart';
import 'package:cafemm/services/urun_service.dart';
import 'package:cafemm/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CafeUrunIslemleriUrunEklemeDialog extends StatelessWidget {
  final Cafe kafe;
  final Kategori kategori;
  const CafeUrunIslemleriUrunEklemeDialog({
    Key? key,
    required this.kafe,
    required this.kategori,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String adi = "", aciklama = "";
    double fiyat = 0;
    List<Uint8List> resimler = <Uint8List>[];
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 12,
              ),
              Text("Ürün Adı : "),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                maxLines: 2,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Ürün Adı',
                ),
                onChanged: (value) {
                  adi = value;
                },
              ),
              SizedBox(
                height: 12,
              ),
              Text("Ürün Açıklaması : "),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                maxLines: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Ürün Açıklaması',
                ),
                onChanged: (value) {
                  aciklama = value;
                },
              ),
              SizedBox(
                height: 12,
              ),
              Text("Ürün Fiyatı : "),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                maxLines: 2,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Ürün Fiyatı',
                ),
                onChanged: (value) {
                  fiyat = double.parse(value);
                },
              ),
              SizedBox(
                height: 12,
              ),
              Text("Ürün Resimleri : "),
              SizedBox(
                height: 12,
              ),
              TextButton.icon(
                onPressed: () async {
                  resimler.add(await _getImage(context, ImageSource.camera));
                },
                icon: Icon(Icons.camera),
                label: Text("Kamera"),
              ),
              SizedBox(
                height: 12,
              ),
              TextButton.icon(
                onPressed: () async {
                  resimler = List.from(await _getMultiImage(context));
                },
                icon: Icon(Icons.image),
                label: Text("Galeri"),
              ),
              SizedBox(
                height: 12,
              ),
              SizedBox(
                height: 12,
              ),
              TextButton.icon(
                onPressed: () async {
                  Urun yeniUrun = Urun(
                      urunAdi: adi,
                      urunAciklama: aciklama,
                      urunFiyat: fiyat,
                      urunResimler: resimler);
                  bool res = urunService.cafeUrunKaydetme(
                      kafe.reference!, yeniUrun, kategori);
                  if (res) {
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(trueSnackbar);
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(falseSnackbar);
                  }
                },
                icon: Icon(Icons.save),
                label: Text("Kaydet"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Uint8List> _getImage(BuildContext context, ImageSource source) async =>
      await ImagePicker().pickImage(source: source, imageQuality: 50).then(
            (file) => file!.readAsBytes().then(
              (value) {
                return value;
              },
            ),
          );

  Future<List<Uint8List>> _getMultiImage(BuildContext context) async {
    final dosyalar = await ImagePicker().pickMultiImage(imageQuality: 50);
    List<Uint8List> resimler = <Uint8List>[];
    for (var dosya in dosyalar!) {
      Uint8List a = await dosya.readAsBytes();
      resimler.add(a);
    }
    return resimler;
  }
}
