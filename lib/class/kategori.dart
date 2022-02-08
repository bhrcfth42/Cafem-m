import 'dart:convert';
import 'dart:typed_data';

import 'package:cafemm/noImage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Kategori {
  late String kategoriAdi;
  late String kategoriAciklama;
  Uint8List? kategoriResim;
  List<DocumentReference>? kategoriUrunler;
  DocumentReference? reference;

  Kategori(
      {required this.kategoriAdi,
      required this.kategoriAciklama,
      this.kategoriResim,
      this.kategoriUrunler,
      this.reference});

  Kategori.fromMap(DocumentSnapshot map, {required this.reference}) {
    assert(map['kategori_adi'] != null);
    assert(map['kategori_aciklama'] != null);
    kategoriAdi = map['kategori_adi'];
    kategoriAciklama = map['kategori_aciklama'];
    kategoriResim = Base64Decoder().convert(map['kategori_resim']??"");
    kategoriUrunler = map['kategori_urunler']!.cast<DocumentReference>();
    if (kategoriResim!.isEmpty)
      kategoriResim = Base64Decoder().convert(noImage);
  }

  Kategori.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(
          snapshot,
          reference: snapshot.reference,
        );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.kategoriResim! == Base64Decoder().convert(noImage))
      this.kategoriResim = new Uint8List(0);
    data['kategori_adi'] = this.kategoriAdi;
    data['kategori_aciklama'] = this.kategoriAciklama;
    data['kategori_resim'] = base64Encode(this.kategoriResim!);
    data['kategori_urunler'] = this.kategoriUrunler;
    return data;
  }
}
