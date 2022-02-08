import 'package:cafemm/class/kategori.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'database_service.dart';

class KategoriService {
  final FirebaseFirestore _firestore = databaseService.firestore;

  Stream<QuerySnapshot> getKategories() {
    return _firestore.collection("kategoriler").snapshots();
  }

  Stream<QuerySnapshot> getCafeKategorilerKismi() {
    return _firestore.collection("kategoriler").snapshots();
  }

  bool cafeKategoriKaydetme(Kategori kategori) {
    try {
      _firestore.collection("kategoriler").doc().set(kategori.toJson());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  bool update(Kategori kategori) {
    try {
      kategori.reference!.update(kategori.toJson());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // bool cafeKategoriSilme(Kategori kategori) {
  //   try {
  //     for (var urunReference in kategori.kategoriUrunler!) {
  //       urunReference.delete();
  //     }
  //     kategori.reference!.delete();
  //     return true;
  //   } catch (e) {
  //     print(e);
  //     return false;
  //   }
  // }
}

final KategoriService kategoriService = KategoriService();
