import 'package:cafemm/class/satis.dart';
import 'package:cafemm/services/satis_service.dart';
import 'package:cafemm/snackbar.dart';
import 'package:cafemm/theme.dart';
import 'package:flutter/material.dart';

class CalisanSiparislerOnaylamaListItem extends StatelessWidget {
  final Satis satis;
  const CalisanSiparislerOnaylamaListItem({
    Key? key,
    required this.satis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap: () {
          satis.satisUrunDurumu = true;
          bool res = satisService.update(satis);
          if (res) {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(trueSnackbar);
          } else {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(falseSnackbar);
          }
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [
                Color(0xFFFF961F).withOpacity(0.7),
                kPrimaryColor.withOpacity(0.7),
              ],
            ),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                "Siparişi Tamamla",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
