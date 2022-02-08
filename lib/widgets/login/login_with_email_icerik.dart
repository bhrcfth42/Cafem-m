import 'package:cafemm/services/auth_service.dart';
import 'package:cafemm/theme.dart';
import 'package:flutter/material.dart';

class LoginWithEmailIcerik extends StatefulWidget {
  const LoginWithEmailIcerik({Key? key}) : super(key: key);

  @override
  _LoginWithEmailIcerikState createState() => _LoginWithEmailIcerikState();
}

class _LoginWithEmailIcerikState extends State<LoginWithEmailIcerik> {
  String email = "";
  String password = "";
  @override
  Widget build(BuildContext context) {
    return Column(
      
      children: [
        TextFormField(
          maxLines: 1,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Email',
          ),
          onChanged: (value) {
            email = value;
          },
        ),
        SizedBox(
          height: 8,
        ),
        TextFormField(
          obscureText: true,
          maxLines: 1,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Parola',
          ),
          onChanged: (value) {
            password = value;
          },
        ),
        SizedBox(
          height: 8,
        ),
        TextButton.icon(
          onPressed: () {
            authService.loginWithEmail(email, password);
          },
          icon: Icon(Icons.email_outlined),
          label: Text("Giriş Yap"),
          style: TextButton.styleFrom(
            primary: kTextColor,
            backgroundColor: kPrimaryColor,
            elevation: 5,
          ),
        ),
      ],
    );
  }
}
