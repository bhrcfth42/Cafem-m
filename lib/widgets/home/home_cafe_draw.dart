import 'package:cafemm/screens/cafe/cafe.dart';
import 'package:flutter/material.dart';

import 'home_build_draw_list_item.dart';

class CafelerDraw extends StatelessWidget {
  const CafelerDraw({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        "Cafeler",
      ),
      children: [
        for (var i = 0; i < 20; i++)
          BuildListItem(
            title: 'Cafe Adı $i',
            icon: Icons.local_cafe,
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => CafeScreen(),
                  ),
                  (Route<dynamic> route) => false);
            },
          ),
        const SizedBox(height: 24),
      ],
    );
  }
}
