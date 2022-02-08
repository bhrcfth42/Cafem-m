import 'package:cafemm/services/auth_service.dart';
import 'package:cafemm/theme.dart';
import 'package:cafemm/widgets/home/home_logo.dart';
import 'package:cafemm/widgets/login/login_with_email_icerik.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Logo(),
            SizedBox(
              height: 12,
            ),
            LoginWithEmailIcerik(),
            SizedBox(
              height: 12,
            ),
            TextButton.icon(
              onPressed: () {
                authService.loginWithGoogle();
              },
              icon: FaIcon(FontAwesomeIcons.google),
              label: Text("Google Hesabı ile Giriş Yap"),
              style: TextButton.styleFrom(
                primary: kTextColor,
                backgroundColor: kPrimaryColor,
                elevation: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
