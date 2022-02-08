import 'package:cafemm/class/user.dart';
import 'package:cafemm/services/user_service.dart';
import 'package:cafemm/snackbar.dart';
import 'package:flutter/material.dart';

class ProfilDuzenlemeAdi extends StatelessWidget {
  final User kullanici;
  const ProfilDuzenlemeAdi({
    Key? key,
    required this.kullanici,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 12,
            ),
            Text("Kullanıcı Adı : "),
            SizedBox(
              height: 12,
            ),
            kullaniciAdi(kullanici.userAdi),
            SizedBox(
              height: 12,
            ),
            IconButton(
              onPressed: () {
                bool res = userService.update(kullanici);
                if (res) {
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(trueSnackbar);
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(falseSnackbar);
                }
              },
              icon: Icon(Icons.save),
            ),
            SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget kullaniciAdi(String kullaniciAdi) {
    return TextFormField(
      initialValue: kullaniciAdi,
      maxLines: 2,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Adınız',
        hintText: kullaniciAdi,
      ),
      onChanged: (value) {
        kullanici.userAdi = value;
      },
    );
  }
}
