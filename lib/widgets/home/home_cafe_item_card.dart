import 'package:cafemm/class/cafe.dart';
import 'package:cafemm/screens/cafe_icerik/cafe_icerik.dart';
import 'package:cafemm/theme.dart';
import 'package:flutter/material.dart';

class CafeItemCard extends StatelessWidget {
  final Cafe cafe;
  const CafeItemCard({
    Key? key,
    required this.cafe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 250,
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: MemoryImage(cafe.cafeResimler![0]),
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CafeIcerikScreen(
                cafe: cafe,
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
          child: Row(
            children: [
              Expanded(
                child: CircleAvatar(
                  radius: 75,
                  backgroundImage: MemoryImage(cafe.cafeLogo!),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        cafe.cafeAdi,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        cafe.cafeAciklama,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        cafe.cafeAdres,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
