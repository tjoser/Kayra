import 'package:flutter/material.dart';
import 'package:kayra_stores/screens/homePage.dart';

class LoginPage extends StatelessWidget {
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
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      hintText: "Şifre",
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 15.0,
                      ),
                      border: InputBorder.none,
                    ),
                    obscureText: true,
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
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
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
    );
  }
}
