import 'package:cafemm/class/kategori.dart';
import 'package:cafemm/class/urun.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'database_service.dart';

class UrunService {
  final FirebaseFirestore _firestore = databaseService.firestore;

  Stream<QuerySnapshot> getUruns() {
    return _firestore.collectionGroup("urunler").snapshots();
  }

  Stream<QuerySnapshot> cafegetUruns(DocumentReference reference) {
    return reference.collection("urunler").snapshots();
  }

  Stream<QuerySnapshot> getCafeUrunlerKismi(DocumentSnapshot documentSnapshot) {
    return documentSnapshot.reference.collection("urunler").snapshots();
  }

  bool cafeUrunKaydetme(
      DocumentReference reference, Urun urun, Kategori kategori) {
    try {
      var newReference = reference.collection("urunler").doc();
      newReference.set(urun.toJson());
      kategori.kategoriUrunler!.add(newReference);
      kategori.reference!.update(kategori.toJson());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  bool cafeUrunSilme(DocumentReference reference, Kategori kategori) {
    try {
      kategori.kategoriUrunler!.remove(kategori.kategoriUrunler!
          .firstWhere((element) => element == reference));
      kategori.reference!.update(kategori.toJson());
      reference.delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  bool update(Urun urun) {
    try {
      urun.reference!.update(urun.toJson());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}

final UrunService urunService = UrunService();
