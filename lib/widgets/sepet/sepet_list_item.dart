import 'package:cafemm/class/urun.dart';
import 'package:cafemm/class/user.dart';
import 'package:cafemm/screens/urun_detay/urun_detay.dart';
import 'package:cafemm/services/user_service.dart';
import 'package:cafemm/snackbar.dart';
import 'package:cafemm/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SepetListItem extends StatefulWidget {
  final Sepet sepetUrun;
  final User kullanici;
  const SepetListItem({
    Key? key,
    required this.sepetUrun,
    required this.kullanici,
  }) : super(key: key);

  @override
  _SepetListItemState createState() => _SepetListItemState();
}

class _SepetListItemState extends State<SepetListItem> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.sepetUrun.sepetUrunRef.snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Text("Hata");
        } else {
          return body(snapshot.data!, context);
        }
      },
    );
  }

  Widget body(
      DocumentSnapshot documentSnapshot, BuildContext context) {
    Urun urun = Urun.fromSnapshot(documentSnapshot);
    return Container(
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: MemoryImage(urun.urunResimler![0]),
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => UrunDetayScreen(
                reference: urun.reference!,
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
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          widget.sepetUrun.sepetUrunAdet++;
                          userService.update(widget.kullanici);
                        },
                        icon: Icon(Icons.add_circle_rounded),
                      ),
                      Text(
                        widget.sepetUrun.sepetUrunAdet.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (widget.sepetUrun.sepetUrunAdet - 1 == 0) {
                            widget.kullanici.userSepet!.removeWhere(
                                (element) => element == widget.sepetUrun);
                          } else {
                            widget.sepetUrun.sepetUrunAdet--;
                          }
                          userService.update(widget.kullanici);
                        },
                        icon: Icon(Icons.remove_circle_rounded),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.delete_forever_rounded),
                    onPressed: () {
                      widget.kullanici.userSepet!.removeWhere(
                          (element) => element == widget.sepetUrun);
                      bool res = userService.update(widget.kullanici);
                      if (res) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(trueSnackbar);
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(falseSnackbar);
                      }
                    },
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  urun.urunAdi,
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
