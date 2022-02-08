import 'package:cafemm/screens/cafe/cafe.dart';
import 'package:cafemm/screens/home/home.dart';
import 'package:cafemm/theme.dart';
import 'package:cafemm/widgets/home/home_build_draw_list_item.dart';
import 'package:flutter/material.dart';

class HomeEndDrawer extends StatelessWidget {
  const HomeEndDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: kPrimaryColor,
            ),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage:
                      NetworkImage('https://picsum.photos/250?image=9'),
                  maxRadius: 40,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Önder Fatih BUHURCU",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "fatihbuhurcu539@gmail.com",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 24,
                ),
                BuildListItem(
                  title: "Ana Sayfa",
                  icon: Icons.home,
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                        (Route<dynamic> route) => false);
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                BuildListItem(
                  title: "Kafeler & Restoranlar",
                  icon: Icons.local_cafe_rounded,
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => CafeScreen(),
                        ),
                        (Route<dynamic> route) => false);
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                BuildListItem(
                  title: "Sepet",
                  icon: Icons.shopping_bag,
                  onTap: () {},
                ),
                const SizedBox(
                  height: 24,
                ),
                BuildListItem(
                  title: "Çıkış",
                  icon: Icons.logout,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
