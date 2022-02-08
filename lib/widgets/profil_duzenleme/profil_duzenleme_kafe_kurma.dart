import 'dart:typed_data';

import 'package:cafemm/class/cafe.dart';
import 'package:cafemm/class/user.dart';
import 'package:cafemm/services/kafe_service.dart';
import 'package:cafemm/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
// import 'package:location/location.dart';

class ProfilDuzenlemeKafeKurma extends StatelessWidget {
  final User kullanici;
  const ProfilDuzenlemeKafeKurma({
    Key? key,
    required this.kullanici,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String adi = "", aciklama = "", adres = "";
    Uint8List logo = new Uint8List(0);
    List<Uint8List> kafeResimler = <Uint8List>[];
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
              Text("Kafe & Restoran Adı : "),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                maxLines: 2,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Kafe & Restoran Adı',
                ),
                onChanged: (value) {
                  adi = value;
                },
              ),
              SizedBox(
                height: 12,
              ),
              Text("Kafe & Restoran Açıklaması : "),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                maxLines: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Kafe & Restoran Açıklaması',
                ),
                onChanged: (value) {
                  aciklama = value;
                },
              ),
              SizedBox(
                height: 12,
              ),
              Text("Kafe & Restoran Adresi : "),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                maxLines: 2,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Kafe & Restoran Adresi',
                ),
                onChanged: (value) {
                  adres = value;
                },
              ),
              SizedBox(
                height: 12,
              ),
              Text("Kafe & Restoran Logo : "),
              SizedBox(
                height: 12,
              ),
              TextButton.icon(
                onPressed: () async {
                  logo = await _getImage(context, ImageSource.camera);
                },
                icon: Icon(Icons.camera),
                label: Text("Kamera"),
              ),
              SizedBox(
                height: 12,
              ),
              TextButton.icon(
                onPressed: () async {
                  logo = await _getImage(context, ImageSource.gallery);
                },
                icon: Icon(Icons.image),
                label: Text("Galeri"),
              ),
              SizedBox(
                height: 12,
              ),
              Text("Kafe & Restoran Resimleri : "),
              SizedBox(
                height: 12,
              ),
              TextButton.icon(
                onPressed: () async {
                  kafeResimler
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
                  kafeResimler = List.from(await _getMultiImage(context));
                },
                icon: Icon(Icons.image),
                label: Text("Galeri"),
              ),
              SizedBox(
                height: 12,
              ),
              TextButton.icon(
                onPressed: () async {
                  LocationData location = await Location().getLocation();
                  Cafe newKafe = Cafe(
                    cafeAdi: adi,
                    cafeAciklama: aciklama,
                    cafeAdres: adres,
                    cafeKonum:
                        new GeoPoint(location.latitude!, location.longitude!),
                    cafeSahibi: kullanici.reference!,
                    cafeLogo: logo,
                    cafeResimler: kafeResimler,
                    cafeCalisanlari: <DocumentReference>[],
                  );
                  kullanici.rol!.rolCafeSahibi = true;
                  bool res = kafeService.ilkKurulum(newKafe, kullanici);
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
