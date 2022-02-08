import 'package:cafemm/class/kategori.dart';
import 'package:cafemm/screens/kategori/kategori.dart';
import 'package:cafemm/theme.dart';
import 'package:flutter/material.dart';

class CafeKategoriIslemleriListItem extends StatelessWidget {
  final Kategori kategori;
  const CafeKategoriIslemleriListItem({
    Key? key,
    required this.kategori,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: MemoryImage(kategori.kategoriResim!),
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => KategoriScreen(
                reference: kategori.reference!,
              ),
            ),
          );
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // IconButton(
                  //   icon: Icon(Icons.delete_forever_rounded),
                  //   onPressed: () {
                  //     bool res = kategoriService.cafeKategoriSilme(kategori);
                  //     if (res) {
                  //       ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  //       ScaffoldMessenger.of(context)
                  //           .showSnackBar(trueSnackbar);
                  //     } else {
                  //       ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  //       ScaffoldMessenger.of(context)
                  //           .showSnackBar(falseSnackbar);
                  //     }
                  //   },
                  // ),
                  // IconButton(
                  //   icon: Icon(Icons.update),
                  //   onPressed: () {
                  //     showDialog(
                  //       context: context,
                  //       builder: (_) =>
                  //           CafeKategoriIslemleriKategoriGuncellemeDialog(
                  //               kategori: kategori),
                  //     );
                  //   },
                  // ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  kategori.kategoriAdi,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
