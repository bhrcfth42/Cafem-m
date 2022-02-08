import 'package:cafemm/class/cafe.dart';
import 'package:cafemm/theme.dart';
import 'package:flutter/material.dart';

class CafeDetayCafeIsimKismi extends StatelessWidget {
  const CafeDetayCafeIsimKismi({
    Key? key,
    required this.cafe,
  }) : super(key: key);

  final Cafe cafe;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.location_on,
          color: ksecondaryColor,
        ),
        SizedBox(
          width: 8,
        ),
        Flexible(
          child: Text(
            cafe.cafeAdi,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
