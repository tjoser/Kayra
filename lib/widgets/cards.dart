import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kayra_stores/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderCard extends StatelessWidget {
  final String id;
  final String date;
  final String time;
  final String urunAdi;
  final String urunKodu;
  final String siparisId;
  final String resimAdi;
  final String barcode;

  const OrderCard({
    super.key,
    required this.date,
    required this.id,
    required this.time,
    required this.urunAdi,
    required this.urunKodu,
    required this.siparisId,
    required this.resimAdi,
    required this.barcode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            child: FittedBox(
              child: Container(
                color: const Color(0xFFDEFCFE),
                padding: const EdgeInsets.all(4),
                margin: const EdgeInsets.only(bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      date,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      time,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    _showImagePopup(context, resimAdi);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: Image.network(
                        resimAdi,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      urunAdi,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      urunKodu,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          showPopupReportingProblem(context, id);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF690B0),
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: const Text(
                            "SORUN\nBİLDİR",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void showPopupReportingProblem(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String selectedValue = 'Eksin Ürün';
        String aciklama = '';
        int sorunId = 1;
        bool showotherReason = false;
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: const Text(
              "SORUN BİLDİRME",
              textAlign: TextAlign.center,
            ),
            backgroundColor: const Color(0xFFFAC9A4),
            content: SizedBox(
              height: 200,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: DropdownButtonFormField<String>(
                        value: selectedValue,
                        onChanged: (newValue) {
                          setState(() {
                            selectedValue = newValue.toString();
                            switch (selectedValue) {
                              case 'Eksin Ürün':
                                sorunId = 1;
                                aciklama = '';
                                break;
                              case 'Defolu Ürün':
                                sorunId = 2;
                                aciklama = '';
                                break;
                              case 'Daha Önce Gönderilmiş':
                                sorunId = 3;
                                aciklama = '';
                                break;
                              case 'Diğer':
                                sorunId = 4;
                                aciklama = '';
                                break;
                            }
                            showotherReason = selectedValue == 'Diğer';
                          });
                        },
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 15.0,
                            horizontal: 5,
                          ),
                          border: InputBorder.none,
                        ),
                        items: <String>[
                          'Eksin Ürün',
                          'Defolu Ürün',
                          'Daha Önce Gönderilmiş',
                          'Diğer',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    if (selectedValue == 'Diğer')
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: (showotherReason)
                            ? TextFormField(
                                maxLines: 3,
                                textAlign: TextAlign.center,
                                decoration: const InputDecoration(
                                  hintText: "(Örnek) Ürün bulunamıyor.",
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 15.0,
                                  ),
                                  border: InputBorder.none,
                                ),
                                onChanged: (text) {
                                  aciklama = text;
                                },
                              )
                            : null,
                      ),
                    if (selectedValue != 'Diğer')
                      Container(
                        padding: const EdgeInsets.only(top: 8),
                        alignment: Alignment.center,
                        child: const Center(
                          child: Text(
                            "Ürün, sorun bildirdikten sonra mağaza ekranından kaldırılacaktır.",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();

                    try {
                      final result = await ApiService.reportProblem(
                        sorunId,
                        aciklama,
                        prefs.getInt('id')!,
                        id,
                      );
                      if (result.isNotEmpty) {
                        log("reportProblem API request for the product succeeded.");
                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                      } else {
                        log("reportProblem API request for the product failed.");
                      }
                    } catch (e) {
                      log("Error while processing reportProblem API request for the product $e");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFDEFCFE),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Tamam",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              )
            ],
          );
        });
      },
    );
  }
}

void _showImagePopup(BuildContext context, String resimAdi) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Image.network(
          resimAdi,
          fit: BoxFit.contain,
        ),
        actions: <Widget>[
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF9890F7),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Kapalı'),
            ),
          ),
        ],
      );
    },
  );
}
