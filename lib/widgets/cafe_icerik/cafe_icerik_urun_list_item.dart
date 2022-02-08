import 'package:cafemm/class/urun.dart';
import 'package:cafemm/screens/urun_detay/urun_detay.dart';
import 'package:cafemm/theme.dart';
import 'package:flutter/material.dart';

class CafeIcerikUrunlerListItem extends StatefulWidget {
  final Urun urun;
  const CafeIcerikUrunlerListItem({
    Key? key,
    required this.urun,
  }) : super(key: key);

  @override
  _CafeIcerikUrunlerListItemState createState() =>
      _CafeIcerikUrunlerListItemState();
}

class _CafeIcerikUrunlerListItemState extends State<CafeIcerikUrunlerListItem> {
  @override
  Widget build(BuildContext context) {
    return body(context);
  }

  Widget body(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: MemoryImage(widget.urun.urunResimler![0]),
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => UrunDetayScreen(
                reference: widget.urun.reference!,
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  widget.urun.urunAdi,
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
