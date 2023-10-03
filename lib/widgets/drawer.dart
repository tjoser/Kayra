import 'package:flutter/material.dart';
import 'package:kayra_stores/screens/connectionPage.dart';
import 'package:kayra_stores/screens/homePage.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      shadowColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFFFEECDE),
            ),
            child: Image.asset(
              "lib/assests/logo.png",
              width: 120,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Color(0xFF552500),
            ),
            title: Text(
              'Ana sayfa',
              style: TextStyle(
                color: Color(0xFF552500),
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.bluetooth,
              color: Color(0xFF552500),
            ),
            title: Text(
              'Bir yazıcıya bağlan',
              style: TextStyle(
                color: Color(0xFF552500),
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ScanPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
