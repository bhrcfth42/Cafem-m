import 'package:cafemm/class/cafe.dart';
import 'package:cafemm/services/kafe_service.dart';
import 'package:cafemm/snackbar.dart';
import 'package:flutter/material.dart';

class CafeBilgileriAciklamaDuzenleme extends StatelessWidget {
  final Cafe kafe;
  const CafeBilgileriAciklamaDuzenleme({Key? key, required this.kafe})
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
            Text("Kafe & Restoran Açıklaması : "),
            SizedBox(
              height: 12,
            ),
            duzenlemeText(kafe.cafeAciklama),
            SizedBox(
              height: 12,
            ),
            IconButton(
              onPressed: () {
                bool res = kafeService.update(kafe);
                if (res) {
                  ScaffoldMessenger.of(context).showSnackBar(trueSnackbar);
                  Navigator.of(context).pop();
                } else {
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

  Widget duzenlemeText(String text) {
    return TextFormField(
      initialValue: text,
      maxLines: 8,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Kafe & Restoran Açıklaması',
        hintText: text,
      ),
      onChanged: (value) {
        kafe.cafeAciklama = value;
      },
    );
  }
}
