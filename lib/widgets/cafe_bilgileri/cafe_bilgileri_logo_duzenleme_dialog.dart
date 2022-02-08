import 'package:cafemm/class/cafe.dart';
import 'package:cafemm/services/kafe_service.dart';
import 'package:cafemm/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CafeBilgileriLogoDuzenleme extends StatelessWidget {
  final Cafe kafe;
  const CafeBilgileriLogoDuzenleme({Key? key, required this.kafe})
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
            Text("Logo Seçiniz : "),
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
                kafe.cafeLogo = value;
                bool res = kafeService.update(kafe);
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
