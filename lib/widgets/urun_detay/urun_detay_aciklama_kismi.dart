import 'package:flutter/material.dart';

class UrunDetayAciklamaKismi extends StatefulWidget {
  final String aciklama;
  const UrunDetayAciklamaKismi({
    Key? key,
    required this.aciklama,
  }) : super(key: key);

  @override
  _UrunDetayAciklamaKismiState createState() => _UrunDetayAciklamaKismiState();
}

class _UrunDetayAciklamaKismiState extends State<UrunDetayAciklamaKismi> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Text(widget.aciklama),
      ),
    );
  }
}
