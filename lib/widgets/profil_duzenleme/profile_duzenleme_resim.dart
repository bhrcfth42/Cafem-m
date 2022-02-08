import 'package:cafemm/class/user.dart';
import 'package:cafemm/services/user_service.dart';
import 'package:cafemm/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilDuzenlemeResim extends StatelessWidget {
  final User kullanici;
  const ProfilDuzenlemeResim({Key? key, required this.kullanici})
      : super(key: key);

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
            Text("Profil Resmi Seçiniz : "),
            SizedBox(
              height: 12,
            ),
            TextButton.icon(
              onPressed: () {
                _getImage(context, ImageSource.camera);
              },
              icon: Icon(Icons.camera),
              label: Text("Kamera"),
            ),
            SizedBox(
              height: 12,
            ),
            TextButton.icon(
              onPressed: () {
                _getImage(context, ImageSource.gallery);
              },
              icon: Icon(Icons.image),
              label: Text("Galeri"),
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

  _getImage(BuildContext context, ImageSource source) async {
    // ignore: deprecated_member_use
    await ImagePicker().pickImage(source: source).then(
          (file) => file!.readAsBytes().then(
            (value) {
              if (value.length > 0) {
                kullanici.userResim = value;
                bool res = userService.update(kullanici);
                if (res) {
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(trueSnackbar);
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(falseSnackbar);
                }
              }
            },
          ),
        );
  }
}
