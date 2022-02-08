import 'dart:typed_data';

import 'package:cafemm/class/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'auth_service.dart';
import 'database_service.dart';
import 'package:http/http.dart' as http;

class UserService {
  final FirebaseFirestore _firestore = databaseService.firestore;
  String _id = "";

  void setId(String id) {
    _id = id;
  }

  Stream<DocumentSnapshot> getUserDatabase() {
    return _firestore.collection("users").doc(_id).snapshots();
  }

  Future<QuerySnapshot> getAllUser() async {
    return await _firestore.collection("users").get();
  }

  Future<void> ilkKayit() async {
    try {
      final user = authService.auth.currentUser!;
      Uint8List? image;
      if (user.photoURL != null)
        await http
            .get(Uri.parse(user.photoURL!))
            .then((value) => image = value.bodyBytes);
      User kullanici = User(
        userAdi: user.displayName!,
        userSoyadi: user.displayName!.split(" ").last,
        userEposta: user.email!,
        userSepet: <Sepet>[],
        userSiparisler: <DocumentReference>[],
        userResim: image??null,
        rol: Rol(
          rolKullanici: true,
          rolAdmin: false,
          rolCafeSahibi: false,
          rolCafeCalisani: false,
        ),
      );
      _firestore.collection("users").doc(_id).set(kullanici.toJson());
    } catch (e) {
      print(e);
    }
  }

  bool update(User user) {
    try {
      user.reference!.update(user.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  bool delete() {
    try {
      _firestore.collection("users").doc(_id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }
}

final UserService userService = UserService();
