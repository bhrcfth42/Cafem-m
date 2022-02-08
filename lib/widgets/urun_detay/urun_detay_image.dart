import 'dart:typed_data';

import 'package:flutter/material.dart';

class UrunDetayImage extends StatefulWidget {
  final List<Uint8List> resimler;
  const UrunDetayImage({
    Key? key,
    required this.resimler,
  }) : super(key: key);

  @override
  _UrunDetayImageState createState() => _UrunDetayImageState();
}

class _UrunDetayImageState extends State<UrunDetayImage> {
  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: 0);
    return PageView(
      controller: controller,
      children: widget.resimler.map((e) => body(e)).toList(),
    );
  }

  Widget body(Uint8List e) {
    return Container(
      margin: EdgeInsets.zero,
      child: Image.memory(
        e,
        fit: BoxFit.contain,
      ),
    );
  }
}
