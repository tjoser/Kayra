import 'package:flutter/material.dart';
import 'package:kayra_stores/screens/connectionPage.dart';
import 'package:kayra_stores/screens/homePage.dart';
import 'package:kayra_stores/screens/loginPage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    PackageInfo _packageInfo = PackageInfo(
      appName: 'Unknown',
      packageName: 'Unknown',
      version: 'Unknown',
      buildNumber: 'Unknown',
      buildSignature: 'Unknown',
      installerStore: 'Unknown',
    );
    return Drawer(
      backgroundColor: Colors.white,
      shadowColor: Colors.white,
      child: Column(
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFFFEECDE),
            ),
            child: Image.asset(
              "lib/assests/logo.png",
              width: double.infinity,
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                ListTile(
                  leading: const Icon(
                    Icons.home,
                    color: Color(0xFF552500),
                  ),
                  title: const Text(
                    'Ana sayfa',
                    style: TextStyle(
                      color: Color(0xFF552500),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const HomePage()));
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.bluetooth,
                    color: Color(0xFF552500),
                  ),
                  title: const Text(
                    'Bir yazıcıya bağlan',
                    style: TextStyle(
                      color: Color(0xFF552500),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ScanPage()));
                  },
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.exit_to_app,
              color: Color(0xFF552500),
            ),
            title: const Text(
              'Oturumu Kapat',
              style: TextStyle(
                color: Color(0xFF552500),
              ),
            ),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('id');
              if (context.mounted) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              }
            },
          ),
          FutureBuilder<PackageInfo>(
            future: PackageInfo.fromPlatform(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  return Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Version: ${snapshot.data!.version}',
                      style: const TextStyle(
                        color: Color(0xFF552500),
                      ),
                    ),
                  );
                default:
                  return const SizedBox();
              }
            },
          ),
          const SizedBox(
            height: 16,
          )
        ],
      ),
    );
  }

  Widget _infoTile(String title) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF552500),
        ),
      ),
    );
  }
}
