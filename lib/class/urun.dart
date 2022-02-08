import 'dart:convert';
import 'dart:typed_data';

import 'package:cafemm/noImage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Urun {
  late String urunAdi;
  late String urunAciklama;
  late double urunFiyat;
  List<Uint8List>? urunResimler;
  DocumentReference? reference;

  Urun(
      {required this.urunAdi,
      required this.urunAciklama,
      required this.urunFiyat,
      List<Uint8List>? urunResimler,
      this.reference})
      : this.urunResimler =
            urunResimler ?? <Uint8List>[Base64Decoder().convert(noImage)];

  Urun.fromMap(DocumentSnapshot map, {required this.reference}) {
    assert(map['urun_adi'] != null);
    assert(map['urun_aciklama'] != null);
    assert(map['urun_fiyat'] != null);
    assert(map['urun_resim'] != null);
    urunAdi = map['urun_adi'];
    urunAciklama = map['urun_aciklama'];
    urunFiyat = double.parse(map['urun_fiyat'].toString());
    urunResimler = map['urun_resim']
        .cast<String>()
        .map<Uint8List>((e) => Base64Decoder().convert(e))
        .toList();
    if (urunResimler!.isEmpty)
      urunResimler!.add(Base64Decoder().convert(noImage));
  }

  Urun.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(
          snapshot,
          reference: snapshot.reference,
        );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.urunResimler!.isNotEmpty) if (this.urunResimler![0] ==
        Base64Decoder().convert(noImage)) this.urunResimler!.clear();
    data['urun_adi'] = this.urunAdi;
    data['urun_aciklama'] = this.urunAciklama;
    data['urun_fiyat'] = this.urunFiyat;
    data['urun_resim'] =
        this.urunResimler!.map((e) => base64Encode(e)).toList();
    return data;
  }
}
