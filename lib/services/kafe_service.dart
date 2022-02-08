import 'package:cafemm/class/cafe.dart';
import 'package:cafemm/class/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'database_service.dart';

class KafeService {
  final FirebaseFirestore _firestore = databaseService.firestore;

  Stream<QuerySnapshot> getCafes() {
    return _firestore.collection("cafeler").snapshots();
  }

  Stream<DocumentSnapshot> getOneCafe(DocumentReference reference) {
    return reference.snapshots();
  }

  Stream<QuerySnapshot> getCafeCiroKismi(DocumentReference reference) {
    return reference.collection("satislar").snapshots();
  }

  Stream<QuerySnapshot> getCafeBilgiKismi(User kullanici) {
    return _firestore
        .collection("cafeler")
        .where("cafe_sahibi", isEqualTo: kullanici.reference)
        .snapshots();
  }

  Stream<QuerySnapshot> getCafeCalisanKismi(User kullanici) {
    return _firestore
        .collection("cafeler")
        .where("cafe_calisanlari", arrayContains: kullanici.reference)
        .snapshots();
  }

  bool ilkKurulum(Cafe kafe, User kullanici) {
    try {
      DocumentReference reference = _firestore.collection("cafeler").doc();
      reference.set(kafe.toJson());
      kullanici.reference!.update(kullanici.toJson());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  bool update(Cafe kafe) {
    try {
      kafe.reference!.update(kafe.toJson());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  void hataliUpdate() {
    _firestore
        .collection("cafeler")
        .get()
        .then((value) => value.docs.first.reference.update({"cafe_logo": " "}));
  }
}

final KafeService kafeService = KafeService();
