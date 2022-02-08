import 'dart:typed_data';

import 'package:cafemm/class/kategori.dart';
import 'package:cafemm/services/kategori_service.dart';
import 'package:cafemm/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CafeKategoriIslemleriKategoriGuncellemeDialog extends StatelessWidget {
  final Kategori kategori;
  const CafeKategoriIslemleriKategoriGuncellemeDialog({
    Key? key,
    required this.kategori,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                initialValue: kategori.kategoriAdi,
                maxLines: 2,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Kategori Adı',
                ),
                onChanged: (value) {
                  kategori.kategoriAdi = value;
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
                initialValue: kategori.kategoriAciklama,
                maxLines: 8,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Kategori Açıklama',
                ),
                onChanged: (value) {
                  kategori.kategoriAciklama = value;
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
                  kategori.kategoriResim =
                      await _getImage(context, ImageSource.camera);
                },
                icon: Icon(Icons.camera),
                label: Text("Kamera"),
              ),
              SizedBox(
                height: 12,
              ),
              TextButton.icon(
                onPressed: () async {
                  kategori.kategoriResim =
                      await _getImage(context, ImageSource.gallery);
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
                  bool res = kategoriService.update(kategori);
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
}
