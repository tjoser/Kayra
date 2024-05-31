import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:kayra_stores/api_service.dart';
import 'package:kayra_stores/widgets/cards.dart';
import 'package:kayra_stores/widgets/drawer.dart';
import 'package:kayra_stores/widgets/popup_utils.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final BluetoothDevice? bluetoothDevice;

  const HomePage({Key? key, this.bluetoothDevice}) : super(key: key);

  @override
  State<HomePage> createState() =>
      _HomePageState(bluetoothDevice: bluetoothDevice);
}

class _HomePageState extends State<HomePage> {
  BluetoothDevice? bluetoothDevice;

  _HomePageState({this.bluetoothDevice});
  Future<List<dynamic>>? _products;

  @override
  initState() {
    super.initState();
    _products = fetchData();
    fetchbluetoothDevice();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showBluetoothWarning(context);
    });
  }

  Future<List<dynamic>> fetchData() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final orders = await ApiService.getOrdersByStoreId(prefs.getInt('id')!);
      return orders;
    } catch (e) {
      log('Error fetching data: $e');
      return [];
    }
  }

  Future<void> fetchbluetoothDevice() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final bluetoothDeviceID = prefs.getString("bluetoothDeviceID");
      if (bluetoothDeviceID != null) {
        bluetoothDevice = BluetoothDevice.fromId(bluetoothDeviceID);
      }
    } catch (e) {
      log('Error fetching bluetoothDevice: $e');
    }
  }

  Future<void> _refreshData() async {
    setState(() {
      _products = fetchData();
      fetchbluetoothDevice();
    });
  }

  Future<void> showBluetoothWarning(BuildContext context) async {
    if (bluetoothDevice == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Uyarı'),
            content: const Text(
                'Lütfen yazdırmadan önce Bluetooth cihazına bağlandığınızdan emin olun.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Tamam'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFEECDE),
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
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
      drawer: const CustomDrawer(),
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
                            onPressed: () async {},
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
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
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
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshData,
                child: FutureBuilder<List<dynamic>>(
                  future: _products,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error fetching data: ${snapshot.error}'),
                      );
                    } else {
                      List<dynamic> products = snapshot.data ?? [];

                      Map<String, List<dynamic>> groupedProducts = {};

                      for (var product in products) {
                        String siparisId = product['SiparisId'].toString();
                        if (!groupedProducts.containsKey(siparisId)) {
                          groupedProducts[siparisId] = [];
                        }
                        groupedProducts[siparisId]?.add(product);
                      }
                      groupedProducts.forEach((key, value) {});
                      return ListView.builder(
                        itemCount: groupedProducts.length,
                        itemBuilder: (context, index) {
                          final siparisId =
                              groupedProducts.keys.elementAt(index);
                          final productsForSiparisId =
                              groupedProducts[siparisId];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              FittedBox(
                                  child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFD3D3D3),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Sipariş No ",
                                    ),
                                    Text(
                                      siparisId,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                              for (var product in productsForSiparisId!)
                                Column(
                                  children: [
                                    OrderCard(
                                      id: product["Id"].toString(),
                                      date: ((product["OncelikSonZaman"] ??
                                                  "             T               ")
                                              .toString())
                                          .split("T")[0],
                                      time: ((product["OncelikSonZaman"] ??
                                                  "             T               ")
                                              .toString())
                                          .split("T")[1]
                                          .substring(0, 8),
                                      urunAdi: product['UrunAdi'],
                                      urunKodu: product['UrunKodu'],
                                      siparisId:
                                          product['SiparisId'].toString(),
                                      resimAdi: product['ResimAdi'],
                                      barcode: product['Barcode'],
                                    ),
                                  ],
                                ),
                              ElevatedButton(
                                onPressed: () {
                                  showPopupProductOrderOutput(
                                      context, productsForSiparisId);
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.black,
                                  backgroundColor: const Color(0xFFDEFCFE),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: const Text(
                                    "ONAYLA",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Center(
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: Center(
                                    child: Container(
                                      height: 4,
                                      color: const Color(0xFFFEECDE),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _refreshData,
        backgroundColor: const Color(0xFF9890F7),
        child: const Icon(Icons.refresh),
      ),
    );
  }

  void showPopupProductOrderOutput(
      BuildContext context, List<dynamic> productsForSiparisId) {
    List<String> userInputs =
        List.generate(productsForSiparisId.length, (index) => "");
    var ids = productsForSiparisId.map((product) => product['Id']).toList();

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
            height: ((150 * productsForSiparisId.length.toDouble()) + 50),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  for (int i = 0; i < productsForSiparisId.length; i++)
                    Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text.rich(
                              TextSpan(
                                children: <InlineSpan>[
                                  const TextSpan(
                                    text: "ÜRÜN ADI: ",
                                    style: TextStyle(
                                      color: Color(0xFF76778C),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: productsForSiparisId[i]["UrunAdi"],
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text(
                            "BARKOD",
                            style: TextStyle(
                              color: Color(0xFF76778C),
                            ),
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
                              hintText: "123456789",
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0,
                              ),
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              userInputs[i] = value;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        )
                      ],
                    ),
                  Container(
                    padding: const EdgeInsets.only(top: 8),
                    alignment: Alignment.center,
                    child: const Center(
                      child: Text(
                        "Seçmiş olduğunuz ürünün barkodunu okutup, tamam butonuna tıklayınız.",
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
                onPressed: () async {
                  bool allMatch = true;

                  for (int i = 0; i < productsForSiparisId.length; i++) {
                    var product =
                        productsForSiparisId[i] as Map<String, dynamic>;
                    log(product['UrunAdi'] + " : " + product["Barcode"]);
                    if (userInputs[i] != product["Barcode"]) {
                      allMatch = false;
                      break;
                    }
                  }

                  if (allMatch) {
                    for (int i = 0; i < productsForSiparisId.length; i++) {
                      var product =
                          productsForSiparisId[i] as Map<String, dynamic>;
                      final barcode = userInputs[i];
                      final siparisId = product["SiparisId"].toString();

                      try {
                        final result =
                            await ApiService.barcodeControl(barcode, siparisId);
                        if (result.isNotEmpty) {
                          ScaffoldMessenger.of(context).removeCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "BarcodeControl API request for product ${product["UrunAdi"]} succeeded."),
                            ),
                          );
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).removeCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "Error while processing BarcodeControl API request for product ${product["UrunAdi"]}: $e"),
                        ));

                        allMatch = false;
                      }
                    }

                    if (allMatch) {
                      if (productsForSiparisId.length == 1) {
                        var product =
                            productsForSiparisId[0] as Map<String, dynamic>;
                        final prefs = await SharedPreferences.getInstance();

                        try {
                          final result = await ApiService.nebimAktar(
                            product["SiparisId"],
                            userInputs[0]?.toString() ?? '',
                            prefs.getInt('id') ?? 0,
                          );
                          if (result.isNotEmpty) {
                            ScaffoldMessenger.of(context)
                                .removeCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                "nebimAktar API request for product ${product["UrunAdi"] ?? 'Unknown Product'} succeeded.",
                              ),
                            ));

                            sendRequestToArasCargo(
                              result["FaturaNo"] ?? '',
                              result["Sube"] ?? '',
                              result["StoreId"] ?? '',
                            );

                            try {
                              if (result["InvoiceStatus"] == 0) {
                                // First Block
                                final userOrderDetail =
                                    await ApiService.getUserOrderDetail(
                                  product["SiparisId"],
                                  product["SiparisUyeId"],
                                  1,
                                );
                                Navigator.of(context).pop();
                                showPopupPRINTINVOICE(
                                  context,
                                  userOrderDetail,
                                  result,
                                  bluetoothDevice,
                                );
                              } else if (result["SiparisKaynakTipi"] == 6) {
                                // Third Block
                                String irasliyeData =
                                    "Bu Siparis ${result["SiparisKonumu"]} Siparişidir. Direkt olarak müşteriye kargolanacaktır. Kargoya vermeden önce lütfen Merkez depodan sipariş numarası ile birlikte trendyol barkod uzantılı belgeyi talep ediniz. Sipariş No : ${result["SiparisNo"] ?? ''}";
                                Navigator.of(context).pop();
                                openIrsaliyePopUp(context, irasliyeData, false);
                              } else if (result["TeslimatUlkeId"] != 213 ||
                                  result["FaturaUlkeId"] != 213) {
                                // Second Block
                                String irasliyeData =
                                    "Bu Siparis ${result["SiparisKonumu"]} Siparişidir, lütfen siparişi MERKEZ depoya gönderin. SiparişNo : ${result["SiparisNo"] ?? ''}";
                                Navigator.of(context).pop();
                                openIrsaliyePopUp(context, irasliyeData, false);
                              } else {
                                // Fourth Block
                                Navigator.of(context).pop();
                                openHataPopup(
                                    context,
                                    result["message"] ??
                                        'Unknown error occurred.');
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context)
                                  .removeCurrentSnackBar();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                  "getUserOrderDetail API request for product ${product["UrunAdi"] ?? 'Unknown Product'} failed.",
                                ),
                              ));
                            }
                          } else {
                            ScaffoldMessenger.of(context)
                                .removeCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                "nebimAktar API request for product ${product["UrunAdi"] ?? 'Unknown Product'} failed.",
                              ),
                            ));
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).removeCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              "Error while processing API request for product ${product["UrunAdi"] ?? 'Unknown Product'}: $e",
                            ),
                          ));
                        }
                      } else if (productsForSiparisId.length > 1) {
                        var product =
                            productsForSiparisId[0] as Map<String, dynamic>;
                        final prefs = await SharedPreferences.getInstance();

                        try {
                          final result = await ApiService.nebimAktarList(
                              userInputs, ids.cast<int>(), prefs.getInt('id')!);
                          if (result.isNotEmpty) {
                            ScaffoldMessenger.of(context)
                                .removeCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "nebimAktarList API request for product ${product["UrunAdi"]} succeeded."),
                            ));

                            sendRequestToArasCargo(
                              result["FaturaNo"] ?? '',
                              result["Sube"] ?? '',
                              result["StoreId"] ?? '',
                            );

                            try {
                              if (result["InvoiceStatus"] == 0) {
                                // First Block
                                final userOrderDetail =
                                    await ApiService.getUserOrderDetail(
                                        product["SiparisId"],
                                        product["SiparisUyeId"],
                                        1);
                                Navigator.of(context).pop();
                                showPopupPRINTINVOICE(context, userOrderDetail,
                                    result, bluetoothDevice);
                              } else if (result["SiparisKaynakTipi"] == 6) {
                                // Third Block
                                String irasliyeData =
                                    "Bu Siparis ${result["SiparisKonumu"]}  Siparişidir. Direkt olarak müşteriye kargolanacaktır. Kargoya vermeden önce lütfen Merkez depodan sipariş numarası ile birlikte trendyol barkod uzantılı belgeyi talep ediniz. Sipariş No :  ${result["SiparisNo"]}";
                                Navigator.of(context).pop();
                                openIrsaliyePopUp(context, irasliyeData, false);
                              } else if (result["TeslimatUlkeId"] != 213 ||
                                  result["FaturaUlkeId"] != 213) {
                                // Second Block
                                String irasliyeData =
                                    "Bu Siparis ${result["SiparisKonumu"]} Siparişidir, lütfen siparişi MERKEZ depoya gönderin. SiparişNo : ${result["SiparisNo"]}";
                                Navigator.of(context).pop();

                                openIrsaliyePopUp(context, irasliyeData, false);
                              } else {
                                // Fourth Block
                                Navigator.of(context).pop();
                                openHataPopup(context, result["message"]);
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context)
                                  .removeCurrentSnackBar();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                    "getUserOrderDetail API request for product ${product["UrunAdi"]} failed."),
                              ));
                            }
                          } else {
                            ScaffoldMessenger.of(context)
                                .removeCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "nebimAktarList API request for product ${product["UrunAdi"]} failed."),
                            ));
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).removeCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "Error while processing nebimAktarList API request for product ${product["UrunAdi"]}: $e"),
                          ));
                        }
                      }
                    }
                  } else {
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Girdiğiniz barkod(lar) yanlış"),
                      ),
                    );
                  }
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

  Future<void> sendRequestToArasCargo(
      String faturaNo, String sube, String storeCode) async {
    try {
      String url = "http://172.10.1.51:2020/Cpanel/Fatura/Print?FaturaNo=" +
          faturaNo +
          '&isPrint=OK&sube=' +
          sube +
          '&StoreCode=' +
          storeCode;
      log(url);
      Uri urL = Uri.parse(url);
      var response = await http.get(urL);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Cargo request send successfully in background"),
        ));
      } else {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text("Cargo request: Error fetching URL: ${response.statusCode}"),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Cargo request: Exception occurred: $e"),
      ));
    }
  }
}
