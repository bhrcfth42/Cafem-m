import 'package:cafemm/class/urun.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class UrunDetayIsimFiyatKismi extends StatefulWidget {
  final Urun urun;
  const UrunDetayIsimFiyatKismi({
    Key? key,
    required this.urun,
  }) : super(key: key);

  @override
  _UrunDetayIsimFiyatKismiState createState() =>
      _UrunDetayIsimFiyatKismiState();
}

class _UrunDetayIsimFiyatKismiState extends State<UrunDetayIsimFiyatKismi> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.urun.urunAdi,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              RatingBar.builder(
                initialRating: 3,
                itemCount: 5,
                itemSize: 20,
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return Icon(
                        Icons.sentiment_very_dissatisfied,
                        color: Colors.red,
                      );
                    case 1:
                      return Icon(
                        Icons.sentiment_dissatisfied,
                        color: Colors.redAccent,
                      );
                    case 2:
                      return Icon(
                        Icons.sentiment_neutral,
                        color: Colors.amber,
                      );
                    case 3:
                      return Icon(
                        Icons.sentiment_satisfied,
                        color: Colors.lightGreen,
                      );
                    case 4:
                      return Icon(
                        Icons.sentiment_very_satisfied,
                        color: Colors.green,
                      );
                    default:
                      return Icon(Icons.ac_unit);
                  }
                },
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
            ],
          ),
        ),
        Text(
          "${widget.urun.urunFiyat} ₺",
          style: TextStyle(
            fontSize: 20,
          ),
        )
      ],
    );
  }
}
