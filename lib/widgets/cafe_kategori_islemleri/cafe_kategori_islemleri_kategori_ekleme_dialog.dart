import 'dart:typed_data';

import 'package:cafemm/class/cafe.dart';
import 'package:cafemm/class/kategori.dart';
import 'package:cafemm/services/kategori_service.dart';
import 'package:cafemm/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CafeKategoriIslemleriKategoriEkleme extends StatelessWidget {
  final Cafe kafe;
  const CafeKategoriIslemleriKategoriEkleme({
    Key? key,
    required this.kafe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String adi = "", aciklama = "";
    Uint8List resim = new Uint8List(0);
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 12,
              ),
              Text("Kategori Adı : "),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                maxLines: 2,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Kategori Adı',
                ),
                onChanged: (value) {
                  adi = value;
                },
              ),
              SizedBox(
                height: 12,
              ),
              Text("Kategori Açıklama : "),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                maxLines: 8,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Kategori Açıklama',
                ),
                onChanged: (value) {
                  aciklama = value;
                },
              ),
              SizedBox(
                height: 12,
              ),
              Text("Kategori Resim : "),
              SizedBox(
                height: 12,
              ),
              TextButton.icon(
                onPressed: () async {
                  resim = await _getImage(context, ImageSource.camera);
                },
                icon: Icon(Icons.camera),
                label: Text("Kamera"),
              ),
              SizedBox(
                height: 12,
              ),
              TextButton.icon(
                onPressed: () async {
                  resim = await _getImage(context, ImageSource.gallery);
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
                  Kategori newKategori = Kategori(
                    kategoriAdi: adi,
                    kategoriAciklama: aciklama,
                    kategoriResim: resim.isEmpty ? new Uint8List(0) : resim,
                    kategoriUrunler: <DocumentReference>[],
                  );
                  bool res = kategoriService.cafeKategoriKaydetme(newKategori);
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
      await ImagePicker().pickImage(source: source,imageQuality: 50).then(
            (file) => file!.readAsBytes().then(
              (value) {
                return value;
              },
            ),
          );
}
