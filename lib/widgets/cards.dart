import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  final String date;
  final String time;
  final String productName;
  final String barcode;
  final String serialNumber;
  final String color;
  final String size;
  final String photoLink;

  OrderCard({
    required this.date,
    required this.time,
    required this.productName,
    required this.barcode,
    required this.serialNumber,
    required this.color,
    required this.size,
    required this.photoLink,
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
                padding: const EdgeInsets.all(8),
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    width: 80,
                    height: 80,
                    child: Image.network(
                      photoLink,
                      fit: BoxFit.cover,
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
                      productName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          color,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Beden: $size",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      barcode,
                      style: const TextStyle(),
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFFD3D3D3),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              "Sipariş No: ",
                            ),
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFFD3D3D3),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              serialNumber,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        _showPopupPRODUCT_ORDER_OUTPUT(context);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: const Color(0xFFDEFCFE),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: const Text(
                          "ONAYLA",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          _showPopupREPORTING_A_PROBLEM(context);
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
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              width: MediaQuery.of(context).size.width * 0.8,
              child: Center(
                child: Container(
                  height: 4,
                  color: const Color(0xFFFEECDE),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showPopupPRODUCT_ORDER_OUTPUT(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "ÜRÜN SİPARİŞ ÇIKIŞI",
            textAlign: TextAlign.center,
          ),
          backgroundColor: const Color(0xFFFEECDE),
          content: SizedBox(
            height: 150,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(
                      "BARKOD",
                      style: TextStyle(color: Color(0xFF76778C)),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        hintText: "1234566789",
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 15.0,
                        ),
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 8),
                    alignment: Alignment.center,
                    child: const Center(
                      child: Text(
                        "Seçmiş olduğunuz ürünün barkodunu okutup, tamam butonuna tıklayınız.",
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
                onPressed: () {
                  Navigator.of(context).pop();
                  _showPopupPRINT_INVOICE(context);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: const Color(0xFFF690B0),
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
      },
    );
  }

  void _showPopupPRINT_INVOICE(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "FATURA YAZDIR",
            textAlign: TextAlign.center,
          ),
          backgroundColor: const Color(0xFFFEECDE),
          content: SizedBox(
            height: 150,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 8),
                    alignment: Alignment.center,
                    child: const Center(
                      child: Text(
                        "Yazdır butonuna tıklayarak faturayı yazdırıp, yazıcıdan çıkan faturayı okutun.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Center(
                        child: Container(
                          height: 8,
                          color: const Color(0xFFFEECDE),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 8),
                    alignment: Alignment.center,
                    child: const Center(
                      child: Text(
                        "NOT : İşlemlerin yarıda kesilmesi durumunda yeni sipariş gönderimi kapanacaktır.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.red),
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
                onPressed: () {
                  Navigator.of(context).pop();

                  _showPopupINVOICE_BARCODE(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9890F7),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Fatura Yazdir",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  void _showPopupINVOICE_BARCODE(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "FATURA BARKOD",
            textAlign: TextAlign.center,
          ),
          backgroundColor: const Color(0xFFFEECDE),
          content: SizedBox(
            height: 150,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(
                      "FATURA BARKODUNU OKUTUN",
                      style: TextStyle(color: Color(0xFF76778C)),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        hintText: "1234566789",
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 15.0,
                        ),
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF690B0),
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
      },
    );
  }

  void _showPopupREPORTING_A_PROBLEM(BuildContext context) {
    String selectedValue = 'Eksin Ürün';
    String otherReason = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "SORUN BİLDİRME",
            textAlign: TextAlign.center,
          ),
          backgroundColor: const Color(0xFFFAC9A4),
          content: SizedBox(
            height: selectedValue == 'Diğer' ? 250 : 200,
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
                        selectedValue = newValue!;

                        if (newValue != 'Diğer') {
                          otherReason = '';
                        }
                      },
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15.0, horizontal: 5),
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
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          otherReason = value;
                        },
                        decoration: const InputDecoration(
                          hintText: "Diğer nedeni girin",
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 15.0,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
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
                onPressed: () {
                  Navigator.of(context).pop();
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
      },
    );
  }
}
