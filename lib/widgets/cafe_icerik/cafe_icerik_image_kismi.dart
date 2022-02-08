import 'dart:typed_data';

import 'package:cafemm/class/cafe.dart';
import 'package:flutter/material.dart';

class CafeIcerikImage extends StatelessWidget {
  final Cafe cafe;
  const CafeIcerikImage({
    Key? key,
    required this.cafe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imageBody(cafe.cafeResimler!);
  }

  Widget imageBody(List<Uint8List> cafeResim) {
    PageController controller = PageController(initialPage: 0);
    return PageView(
      controller: controller,
      children: cafeResim.map<Widget>((e) => image(e)).toList(),
    );
  }

  Widget image(Uint8List image) {
    return Container(
      margin: EdgeInsets.zero,
      child: Image.memory(
        image,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget noImageBody() {
    return Container(
      margin: EdgeInsets.zero,
      child: Image.network(
        "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1200px-No-Image-Placeholder.svg.png",
        fit: BoxFit.cover,
      ),
    );
  }
}
