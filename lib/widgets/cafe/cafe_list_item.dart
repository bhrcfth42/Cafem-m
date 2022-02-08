import 'package:cafemm/class/cafe.dart';
import 'package:cafemm/screens/cafe_icerik/cafe_icerik.dart';
import 'package:cafemm/theme.dart';
import 'package:flutter/material.dart';

class CafeListItem extends StatelessWidget {
  final Cafe cafe;
  const CafeListItem({
    Key? key,
    required this.cafe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          fit: BoxFit.cover,
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                flex: 4,
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: CircleAvatar(
                    backgroundImage: MemoryImage(
                      cafe.cafeLogo!,
                    ),
                    maxRadius: 100,
                  ),
                ),
              ),
              Flexible(
                flex: 7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      cafe.cafeAdi,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      cafe.cafeAciklama,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
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
