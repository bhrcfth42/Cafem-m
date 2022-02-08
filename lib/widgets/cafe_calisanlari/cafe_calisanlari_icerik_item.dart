import 'package:cafemm/class/cafe.dart';
import 'package:cafemm/class/user.dart';
import 'package:cafemm/services/kafe_service.dart';
import 'package:cafemm/services/user_service.dart';
import 'package:cafemm/snackbar.dart';
import 'package:flutter/material.dart';

class CafeCalisanlariIcerikListItem extends StatelessWidget {
  final User calisan;
  final Cafe kafe;
  const CafeCalisanlariIcerikListItem({
    Key? key,
    required this.calisan,
    required this.kafe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        '${calisan.userAdi} ${calisan.userSoyadi}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      leading: CircleAvatar(
        backgroundImage: MemoryImage(calisan.userResim!),
      ),
      subtitle: Text(
        '${calisan.userEposta}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: IconButton(
        onPressed: () {
          kafe.cafeCalisanlari!.remove(calisan.reference);
          calisan.rol!.rolCafeCalisani = false;
          bool res = kafeService.update(kafe);
          bool res2 = userService.update(calisan);
          if (res && res2) {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(trueSnackbar);
          } else {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(falseSnackbar);
          }
        },
        icon: Icon(Icons.remove_circle_rounded),
      ),
    );
  }
}
