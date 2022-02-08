import 'dart:convert';
import 'dart:typed_data';

import 'package:cafemm/noImage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Cafe {
  late String cafeAdi;
  late String cafeAciklama;
  late String cafeAdres;
  List<Uint8List>? cafeResimler;
  late GeoPoint cafeKonum;
  Uint8List? cafeLogo;
  late DocumentReference cafeSahibi;
  List<DocumentReference>? cafeCalisanlari;
  DocumentReference? reference;

  Cafe({
    required this.cafeAdi,
    required this.cafeAciklama,
    required this.cafeAdres,
    required this.cafeKonum,
    required this.cafeSahibi,
    this.cafeResimler,
    this.cafeLogo,
    this.cafeCalisanlari,
    this.reference,
  });

  Cafe.fromMap(DocumentSnapshot map, {required this.reference}) {
    assert(map['cafe_adi'] != null);
    assert(map['cafe_aciklama'] != null);
    assert(map['cafe_adres'] != null);
    assert(map['cafe_konum'] != null);
    assert(map['cafe_sahibi'] != null);
    cafeAdi = map['cafe_adi'];
    cafeAciklama = map['cafe_aciklama'];
    cafeAdres = map['cafe_adres'];
    cafeResimler = map['cafe_resim']
        .cast<String>()
        .map<Uint8List>((e) => Base64Decoder().convert(e ?? ""))
        .toList();
    cafeKonum = map['cafe_konum'];
    cafeSahibi = map['cafe_sahibi'];
    cafeCalisanlari = map['cafe_calisanlari'].cast<DocumentReference>();
    cafeLogo = Base64Decoder().convert(map['cafe_logo'] ?? "");
    if (cafeLogo!.isEmpty) cafeLogo = Base64Decoder().convert(noImage);
    if (cafeResimler!.isEmpty)
      cafeResimler!.add(Base64Decoder().convert(noImage));
  }

  Cafe.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot, reference: snapshot.reference);

  Map<String, dynamic> toJson() {
    if (this.cafeLogo!.isNotEmpty) if (this.cafeLogo ==
        Base64Decoder().convert(noImage)) this.cafeLogo = new Uint8List(0);
    if (this.cafeResimler!.isNotEmpty) if (this.cafeResimler![0] ==
        Base64Decoder().convert(noImage)) this.cafeResimler!.clear();
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cafe_adi'] = this.cafeAdi;
    data['cafe_aciklama'] = this.cafeAciklama;
    data['cafe_adres'] = this.cafeAdres;
    data['cafe_resim'] =
        this.cafeResimler!.map((e) => base64Encode(e)).toList();
    data['cafe_konum'] = this.cafeKonum;
    data['cafe_sahibi'] = this.cafeSahibi;
    data['cafe_calisanlari'] = this.cafeCalisanlari!;
    data['cafe_logo'] = base64Encode(this.cafeLogo!);
    return data;
  }
}
