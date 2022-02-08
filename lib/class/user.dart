import 'dart:convert';
import 'dart:typed_data';

import 'package:cafemm/noImage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  late String userAdi;
  late String userSoyadi;
  late String userEposta;
  Uint8List? userResim;
  List<DocumentReference>? userSiparisler;
  List<Sepet>? userSepet;
  Rol? rol;
  DocumentReference? reference;

  User(
      {required this.userAdi,
      required this.userSoyadi,
      required this.userEposta,
      this.userResim,
      this.userSiparisler,
      this.userSepet,
      this.rol,
      this.reference});

  User.fromMap(DocumentSnapshot doc, {required this.reference}) {
    assert(doc['user_adi'] != null);
    assert(doc['user_soyadi'] != null);
    assert(doc['user_e-posta'] != null);
    userAdi = doc['user_adi'];
    userSoyadi = doc['user_soyadi'];
    userEposta = doc['user_e-posta'];
    userSepet = doc['user_sepet']!.map<Sepet>((e) => Sepet.fromMap(e)).toList();
    rol = Rol.fromMap(doc['Rol']!);
    userSiparisler = doc['siparisler'].cast<DocumentReference>();
    userResim = Base64Decoder().convert(doc['user_resim'] ?? "");
    if (userResim!.isEmpty) userResim = Base64Decoder().convert(noImage);
  }

  User.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(
          snapshot,
          reference: snapshot.reference,
        );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userResim == null ||
        this.userResim! == Base64Decoder().convert(noImage))
      this.userResim = new Uint8List(0);
    data['user_adi'] = this.userAdi;
    data['user_soyadi'] = this.userSoyadi;
    data['user_e-posta'] = this.userEposta;
    data['user_sepet'] = this.userSepet!.map((e) => e.toJson()).toList();
    data['siparisler'] = this.userSiparisler!;
    data["Rol"] = this.rol!.toJson();
    data['user_resim'] = base64Encode(this.userResim!);
    return data;
  }
}

class Sepet {
  DocumentReference sepetUrunRef;
  int sepetUrunAdet;

  Sepet({required this.sepetUrunRef, required this.sepetUrunAdet});

  Sepet.fromMap(Map<String, dynamic> doc)
      : assert(doc['sepet_urun_ref'] != null),
        assert(doc['sepet_urun_adet'] != null),
        sepetUrunRef = doc['sepet_urun_ref'],
        sepetUrunAdet = int.parse(doc['sepet_urun_adet'].toString());

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sepet_urun_ref'] = this.sepetUrunRef;
    data['sepet_urun_adet'] = this.sepetUrunAdet;
    return data;
  }
}

class Rol {
  bool? rolAdmin;
  bool? rolCafeSahibi;
  bool? rolCafeCalisani;
  bool? rolKullanici;

  Rol({
    this.rolAdmin,
    this.rolCafeSahibi,
    this.rolCafeCalisani,
    this.rolKullanici,
  });

  Rol.fromMap(Map<String, dynamic> doc)
      : rolAdmin = doc['rol_admin'],
        rolCafeSahibi = doc['rol_cafe_sahibi'],
        rolCafeCalisani = doc['rol_cafe_calisani'],
        rolKullanici = doc['rol_kullanici'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rol_admin'] = this.rolAdmin!;
    data['rol_cafe_sahibi'] = this.rolCafeSahibi!;
    data['rol_cafe_calisani'] = this.rolCafeCalisani!;
    data['rol_kullanici'] = this.rolKullanici!;
    return data;
  }
}
