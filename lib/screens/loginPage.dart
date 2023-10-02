import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kayra_stores/screens/homePage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false; // Initialize as not visible

  Future<void> login() async {
    final String apiUrl = 'https://apibeta.kayra.com/api/Users/Login';

    final Map<String, dynamic> requestData = {
      "CellPhone": "string",
      "EMail": emailController.text,
      "Password": passwordController.text,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'accept': '*/*',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              "Giriş başarısız oldu. Lütfen kimlik bilgilerinizi kontrol edin."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    alignment:
                        Alignment.centerRight, // Align the icon to the right
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
                        obscureText: !isPasswordVisible, // Toggle visibility
                      ),
                      IconButton(
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: isPasswordVisible
                              ? Color(0xFFF690B0)
                              : Colors.grey,
                        ),
                        onPressed: () {
                          // Toggle the password visibility
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
              Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: login,
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
    );
  }
}
