import 'package:cafemm/class/satis.dart';
import 'package:cafemm/class/user.dart';
import 'package:cafemm/services/user_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// import 'database_service.dart';

class SatisService {
  Stream<QuerySnapshot> getCafeSatislarKismi(
      DocumentSnapshot documentSnapshot) {
    return documentSnapshot.reference.collection("satislar").snapshots();
  }

  bool yeniSiparis(Satis satis, User kullanici) {
    try {
      DocumentReference newRef = satis.urunler[0].satisUrunRef.parent.parent!
          .collection("satislar")
          .doc();
      newRef.set(satis.toJson());
      kullanici.userSiparisler!.add(newRef);
      kullanici.userSepet!.clear();
      kullanici.reference!.update(kullanici.toJson());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  bool update(Satis satis) {
    try {
      satis.reference!.update(satis.toJson());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  bool siparisSil(DocumentReference reference, User kullanici) {
    try {
      reference.delete();
      kullanici.userSiparisler!.remove(reference);
      userService.update(kullanici);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}

final SatisService satisService = SatisService();
