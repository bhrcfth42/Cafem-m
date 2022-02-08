import 'dart:typed_data';

import 'package:cafemm/class/urun.dart';
import 'package:cafemm/services/urun_service.dart';
import 'package:cafemm/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CafeUrunIslemleriUrunGuncellemeDialog extends StatelessWidget {
  final Urun urun;
  const CafeUrunIslemleriUrunGuncellemeDialog({
    Key? key,
    required this.urun,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                initialValue: urun.urunAdi,
                maxLines: 2,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Ürün Adı',
                ),
                onChanged: (value) {
                  urun.urunAdi = value;
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
                initialValue: urun.urunAciklama,
                maxLines: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Ürün Açıklaması',
                ),
                onChanged: (value) {
                  urun.urunAciklama = value;
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
                initialValue: urun.urunFiyat.toString(),
                keyboardType: TextInputType.number,
                maxLines: 2,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Ürün Fiyatı',
                ),
                onChanged: (value) {
                  urun.urunFiyat = double.parse(value);
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
                  urun.urunResimler!
                      .add(await _getImage(context, ImageSource.camera));
                },
                icon: Icon(Icons.camera),
                label: Text("Kamera"),
              ),
              SizedBox(
                height: 12,
              ),
              TextButton.icon(
                onPressed: () async {
                  List<Uint8List> yeniResimler = await _getMultiImage(context);
                  for (Uint8List newResim in yeniResimler) {
                    urun.urunResimler!.add(newResim);
                  }
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
                  bool res = urunService.update(urun);
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
