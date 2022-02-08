import 'package:cafemm/class/cafe.dart';
import 'package:cafemm/class/user.dart';
import 'package:cafemm/services/kafe_service.dart';
import 'package:cafemm/services/user_service.dart';
import 'package:cafemm/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CafeCAlisanEklemeDialog extends StatelessWidget {
  final Cafe kafe;
  const CafeCAlisanEklemeDialog({
    Key? key,
    required this.kafe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: FutureBuilder(
        future: userService.getAllUser(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<User> kullanicilar =
                snapshot.data!.docs.map((e) => User.fromSnapshot(e)).toList();
            return ListView.builder(
              shrinkWrap: true,
              itemCount: kullanicilar.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: () {
                    User calisan = kullanicilar[index];
                    calisan.rol!.rolCafeCalisani = true;
                    kafe.cafeCalisanlari!.add(calisan.reference!);
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
                  title: Text(
                    kullanicilar[index].userAdi,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  leading: CircleAvatar(
                    backgroundImage:
                        MemoryImage(kullanicilar[index].userResim!),
                  ),
                );
              },
            );
          } else {
            return Container(
              margin: EdgeInsets.all(8),
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
