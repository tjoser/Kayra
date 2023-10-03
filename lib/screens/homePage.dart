import 'package:flutter/material.dart';
import 'package:kayra_stores/widgets/cards.dart';
import 'package:kayra_stores/widgets/drawer.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFEECDE),
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                Icons.menu,
                color: Color(0xFF552500),
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: CustomDrawer(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: Container(
                color: const Color(0xFFFEECDE),
                height: 80,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Online Sipariş",
                            style: TextStyle(
                              fontSize: 17,
                              color: Color(0xFF552500),
                            ),
                          ),
                          Text(
                            "MAĞAZA SİPARİŞİ",
                            style: TextStyle(
                              fontSize: 23,
                              color: Color(0xFF222841),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 140,
                        child: FittedBox(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: const Color(0xFF9890F7),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                "KARGO\nTESLİM\nTUTANAĞI",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return OrderCard(
                    date: product['date']!,
                    time: product['time']!,
                    productName: product['productName']!,
                    barcode: product['barcode']!,
                    serialNumber: product['serialNumber']!,
                    color: product['color']!,
                    size: product['size']!,
                    photoLink: product['photoLink']!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  final List<Map<String, String>> products = [
    {
      'date': '2023-09-27',
      'time': '11:30 AM',
      'productName': 'First Product',
      'barcode': '987654321',
      'serialNumber': 'SN456',
      'color': 'Blue Blue',
      'size': '42',
      'photoLink':
          'https://us.princesspolly.com/cdn/shop/products/DANIELA-MINI-DRESS-WHITE_e0b99c69-6874-4bdb-8aa2-821d60647a43.jpg?v=1614614522&width=767'
    },
  ];
}
