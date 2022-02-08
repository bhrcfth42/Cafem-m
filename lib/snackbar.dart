import 'package:flutter/material.dart';

const trueSnackbar = SnackBar(
  content: Text(
    "İşleminiz başarı ile tamamlandı.",
    style: TextStyle(
      color: Colors.white,
    ),
  ),
  backgroundColor: Colors.green,
  duration: Duration(seconds: 1),
);

const falseSnackbar = SnackBar(
  content: Text(
    "İşleminiz sırasında hata oluştu",
    style: TextStyle(
      color: Colors.white,
    ),
  ),
  backgroundColor: Colors.red,
  duration: Duration(seconds: 1),
);
