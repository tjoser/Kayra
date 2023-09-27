import 'package:flutter/material.dart';
import 'package:kayra_stores/widgets/cards.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                height: 150,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
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
    {
      'date': '2023-09-27',
      'time': '12:00 PM',
      'productName': 'Second Product',
      'barcode': '123456789',
      'serialNumber': 'SN789',
      'color': 'Red',
      'size': '38',
      'photoLink':
          'https://britishretro.co.uk/wp-content/uploads/2019/10/red-1950s-style-dress.jpg'
    },
    {
      'date': '2023-09-28',
      'time': '10:45 AM',
      'productName': 'Third Product',
      'barcode': '555555555',
      'serialNumber': 'SN333',
      'color': 'Green',
      'size': '40',
      'photoLink':
          'https://assets.ajio.com/medias/sys_master/root/20230624/d2lM/64966b12a9b42d15c9ddcd02/-473Wx593H-465410816-burgundy-MODEL.jpg'
    },
    {
      'date': '2023-09-28',
      'time': '3:15 PM',
      'productName': 'Fourth Product',
      'barcode': '777777777',
      'serialNumber': 'SN777',
      'color': 'Yellow',
      'size': '44',
      'photoLink':
          'https://petalandpup.com.au/cdn/shop/products/petal-and-pup-au-dresses-julip-sheer-long-sleeve-maxi-dress-olive-31172542201967.jpg?v=1656632592'
    },
    {
      'date': '2023-09-29',
      'time': '9:30 AM',
      'productName': 'Fifth Product',
      'barcode': '444444444',
      'serialNumber': 'SN444',
      'color': 'Purple',
      'size': '36',
      'photoLink':
          'https://us.princesspolly.com/cdn/shop/products/DANIELA-MINI-DRESS-WHITE_e0b99c69-6874-4bdb-8aa2-821d60647a43.jpg?v=1614614522&width=767'
    },
    {
      'date': '2023-09-29',
      'time': '2:00 PM',
      'productName': 'Sixth Product',
      'barcode': '666666666',
      'serialNumber': 'SN666',
      'color': 'Orange',
      'size': '39',
      'photoLink':
          'https://us.princesspolly.com/cdn/shop/products/DANIELA-MINI-DRESS-WHITE_e0b99c69-6874-4bdb-8aa2-821d60647a43.jpg?v=1614614522&width=767'
    },
    {
      'date': '2023-09-30',
      'time': '8:45 AM',
      'productName': 'Seventh Product',
      'barcode': '111111111',
      'serialNumber': 'SN111',
      'color': 'Pink',
      'size': '37',
      'photoLink':
          'https://us.princesspolly.com/cdn/shop/products/DANIELA-MINI-DRESS-WHITE_e0b99c69-6874-4bdb-8aa2-821d60647a43.jpg?v=1614614522&width=767'
    },
    {
      'date': '2023-09-30',
      'time': '1:30 PM',
      'productName': 'Eighth Product',
      'barcode': '222222222',
      'serialNumber': 'SN222',
      'color': 'Black',
      'size': '41',
      'photoLink':
          'https://us.princesspolly.com/cdn/shop/products/DANIELA-MINI-DRESS-WHITE_e0b99c69-6874-4bdb-8aa2-821d60647a43.jpg?v=1614614522&width=767'
    },
    {
      'date': '2023-10-01',
      'time': '7:15 AM',
      'productName': 'Ninth Product',
      'barcode': '888888888',
      'serialNumber': 'SN888',
      'color': 'Brown',
      'size': '45',
      'photoLink':
          'https://us.princesspolly.com/cdn/shop/products/DANIELA-MINI-DRESS-WHITE_e0b99c69-6874-4bdb-8aa2-821d60647a43.jpg?v=1614614522&width=767'
    },
    {
      'date': '2023-10-01',
      'time': '4:00 PM',
      'productName': 'Tenth Product',
      'barcode': '999999999',
      'serialNumber': 'SN999',
      'color': 'Silver',
      'size': '38',
      'photoLink':
          'https://us.princesspolly.com/cdn/shop/products/DANIELA-MINI-DRESS-WHITE_e0b99c69-6874-4bdb-8aa2-821d60647a43.jpg?v=1614614522&width=767'
    },
    {
      'date': '2023-10-02',
      'time': '6:00 AM',
      'productName': 'Eleventh Product',
      'barcode': '123123123',
      'serialNumber': 'SN123',
      'color': 'Gold',
      'size': '40',
      'photoLink':
          'https://us.princesspolly.com/cdn/shop/products/DANIELA-MINI-DRESS-WHITE_e0b99c69-6874-4bdb-8aa2-821d60647a43.jpg?v=1614614522&width=767'
    },
    {
      'date': '2023-10-02',
      'time': '5:30 PM',
      'productName': 'Twelfth Product',
      'barcode': '456456456',
      'serialNumber': 'SN456',
      'color': 'White',
      'size': '42',
      'photoLink':
          'https://us.princesspolly.com/cdn/shop/products/DANIELA-MINI-DRESS-WHITE_e0b99c69-6874-4bdb-8aa2-821d60647a43.jpg?v=1614614522&width=767'
    },
    {
      'date': '2023-10-03',
      'time': '10:00 AM',
      'productName': 'Thirteenth Product',
      'barcode': '789789789',
      'serialNumber': 'SN789',
      'color': 'Blue',
      'size': '44',
      'photoLink':
          'https://us.princesspolly.com/cdn/shop/products/DANIELA-MINI-DRESS-WHITE_e0b99c69-6874-4bdb-8aa2-821d60647a43.jpg?v=1614614522&width=767'
    },
    {
      'date': '2023-10-03',
      'time': '3:45 PM',
      'productName': 'Fourteenth Product',
      'barcode': '654654654',
      'serialNumber': 'SN654',
      'color': 'Green',
      'size': '39',
      'photoLink':
          'https://us.princesspolly.com/cdn/shop/products/DANIELA-MINI-DRESS-WHITE_e0b99c69-6874-4bdb-8aa2-821d60647a43.jpg?v=1614614522&width=767'
    },
    {
      'date': '2023-10-04',
      'time': '9:30 AM',
      'productName': 'Fifteenth Product',
      'barcode': '987987987',
      'serialNumber': 'SN987',
      'color': 'Red',
      'size': '37',
      'photoLink':
          'https://us.princesspolly.com/cdn/shop/products/DANIELA-MINI-DRESS-WHITE_e0b99c69-6874-4bdb-8aa2-821d60647a43.jpg?v=1614614522&width=767'
    },
  ];
}
