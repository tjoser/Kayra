import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kayra_stores/api_service.dart';
import 'package:kayra_stores/screens/homePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;
  bool saveCredentials = false;

  Future<void> login() async {
    try {
      final Map<String, dynamic> response = await ApiService.login(
        emailController.text,
        passwordController.text,
      );
      if (response.containsKey('Id')) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('id', response["Id"]);

        if (saveCredentials) {
          await prefs.setString('email', emailController.text);
          await prefs.setString('password', passwordController.text);
        }

        if (context.mounted) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const HomePage()));
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  "Giriş başarısız oldu. Lütfen kimlik bilgilerinizi kontrol edin."),
            ),
          );
        }
      }
    } catch (e) {
      log(e.toString());
      if (context.mounted) {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text("Giriş sırasında bir hata oluştu. Lütfen tekrar deneyin."),
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadCredentials();
  }

  Future<void> _loadCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final String? email = prefs.getString('email');
    final String? password = prefs.getString('password');
    if (email != null && password != null) {
      emailController.text = email;
      passwordController.text = password;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: const Color(0xFFfeecde),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Online Sipariş",
                    style: TextStyle(
                      fontSize: 24,
                      color: Color(0xFF552500),
                    ),
                  ),
                  const Text(
                    "MAĞAZA SİPARİŞİ",
                    style: TextStyle(
                      fontSize: 30,
                      color: Color(0xFF222841),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: TextFormField(
                        controller: emailController,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          hintText: "Mail",
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 15.0,
                          ),
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          TextFormField(
                            controller: passwordController,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              hintText: "Şifre",
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 15.0,
                              ),
                              border: InputBorder.none,
                            ),
                            obscureText: !isPasswordVisible,
                          ),
                          IconButton(
                            icon: Icon(
                              isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: isPasswordVisible
                                  ? const Color(0xFFF690B0)
                                  : Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CheckboxListTile(
                    title: const Text("Kimlik bilgilerimi kaydet"),
                    value: saveCredentials,
                    onChanged: (bool? value) {
                      setState(() {
                        saveCredentials = value ?? false;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            login();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF690B0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 15.0,
                            ),
                            child: const Center(
                              child: Text(
                                "GİRİŞ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
