import 'package:cafemm/screens/home/home.dart';
import 'package:cafemm/screens/login/login.dart';
import 'package:cafemm/services/auth_service.dart';
import 'package:cafemm/services/user_service.dart';
import 'package:cafemm/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Text("Hata");
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return Uygulama();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class Uygulama extends StatelessWidget {
  const Uygulama({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cafemm',
      theme: lightThemeData,
      // darkTheme: ThemeData.dark(),
      home: new GirisKontrolu(),
    );
  }
}

class GirisKontrolu extends StatelessWidget {
  const GirisKontrolu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: authService.auth.authStateChanges(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          return VeriTabaniKullaniciBilgiSorgulama();
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Hata"),
          );
        } else {
          return LoginScreen();
        }
      },
    );
  }
}

class VeriTabaniKullaniciBilgiSorgulama extends StatelessWidget {
  const VeriTabaniKullaniciBilgiSorgulama({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = authService.auth.currentUser!;
    userService.setId(user.uid);
    return StreamBuilder<DocumentSnapshot>(
      stream: userService.getUserDatabase(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData && snapshot.data.data() != null) {
          return HomeScreen();
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Hata"),
          );
        } else {
          userService.ilkKayit();
          return Center(
            child: Text("Veri tabanı bilgi kayıt ekranı"),
          );
        }
      },
    );
  }
}
