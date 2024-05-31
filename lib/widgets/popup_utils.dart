import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:kayra_stores/bluetooth/blue_print.dart';
import 'package:kayra_stores/widgets/string_editing.dart';

void openHataPopup(BuildContext context, String errorMessage) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          "HATA POPUP",
          textAlign: TextAlign.center,
        ),
        backgroundColor: const Color(0xFFFEECDE),
        content: SizedBox(
          height: 200,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  errorMessage,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF690B0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text("Tamam"),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

void openIrsaliyePopUp(
    BuildContext context, String irasliyeData, bool ifTrendyol) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          "BILGILNDIRME",
          textAlign: TextAlign.center,
        ),
        backgroundColor: const Color(0xFFFEECDE),
        content: SizedBox(
          height: 200,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ifTrendyol
                    ? Image.network(
                        'https://cdn.kayra.com/UserFiles/System/trendyol-400.jpg')
                    : const SizedBox(),
                Text(
                  irasliyeData,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF690B0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text("Tamam"),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

void showPopupPRINTINVOICE(
    BuildContext context,
    Map<String, dynamic> userOrderDetail,
    Map<String, dynamic> result,
    BluetoothDevice? bluetoothDevice) {
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
                        height: 4,
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
              onPressed: () async {
                DateTime now = DateTime.now();
                String formattedDate = "${now.day}/${now.month}/${now.year}";
                String formattedTime =
                    "${now.hour}:${now.minute}:${now.second}";

                String? name = replaceTurkishLetters(
                    userOrderDetail["TeslimAlanAdSoyad"]?.toString() ?? " ");
                String tel =
                    userOrderDetail["TeslimatTelefon"]?.toString() ?? "";
                String address1 =
                    userOrderDetail["TeslimatAdres1"]?.toString() ?? " ";
                address1 = replaceTurkishLetters(address1);
                String address2 =
                    userOrderDetail["TeslimatAdres2"]?.toString() ?? " ";
                address2 = replaceTurkishLetters(address2);
                String address3 =
                    userOrderDetail["TeslimatAdres3"]?.toString() ?? " ";
                address3 = replaceTurkishLetters(address3);

                List<String> parts = divideStringIntoFourEqualParts(
                    "$address1 $address2 $address3");
                address1 = parts[0];
                address2 = parts[1];
                address3 = parts[2];
                String address4 = parts[3];

                String faturaBarkodu = result["FaturaNo"]?.toString() ?? " ";
                String kargoBarkodu = result["CargoKey"]?.toString() ?? " ";
                String siparisNo = result["SiparisNo"]?.toString() ?? " ";
                String? sube =
                    replaceTurkishLetters(result["Sube"]?.toString() ?? " ");

                try {
                  final gen =
                      Generator(PaperSize.mm80, await CapabilityProfile.load());
                  final printer = BluePrint();

                  String bytes =
                      "SIZE 60 mm, 120 mm \nGAP 2 mm\nSET CUTTER 1\nCLS\nCODEPAGE 1254\n";
                  bytes +=
                      "TEXT 40, 10, \"3\", 0, 1, 1, \"SARE MAGAZACILIK\"\n";
                  bytes +=
                      "TEXT 40, 40, \"1\", 0, 1, 1, \"KONF. ITH. IHR. SAN. VE TIC.A.S.\"\n";
                  bytes +=
                      "TEXT 40, 80, \"2\", 0, 1, 1, \"Siparis Numarasi: $siparisNo\"\n";
                  bytes += "TEXT 40, 110, \"2\", 0, 1, 1, \"Sn: $name\"\n";
                  bytes += "TEXT 40, 140, \"2\", 0, 1, 1, \"Adres:\"\n";
                  bytes += "TEXT 40, 170, \"2\", 0, 1, 1, \"$address1\"\n";
                  bytes += "TEXT 40, 200, \"2\", 0, 1, 1, \"$address2\"\n";
                  bytes += "TEXT 40, 230, \"2\", 0, 1, 1, \"$address3\"\n";
                  bytes += "TEXT 40, 260, \"2\", 0, 1, 1, \"$address4\"\n";
                  bytes += "TEXT 40, 290, \"2\", 0, 1, 1, \"Tel: $tel\"\n";
                  bytes +=
                      "TEXT 40, 320, \"2\", 0, 1, 1, \"Cikis Magaza: $sube\"\n";

                  bytes +=
                      "TEXT 150, 380, \"2\", 0, 1, 1, \"FATURA BARKODU\"\n";
                  bytes +=
                      "BARCODE 80, 410, \"128\", 100, 1, 0, 2, 2, \"$faturaBarkodu\"\n";

                  bytes += "TEXT 150, 570, \"2\", 0, 1, 1, \"KARGO BARKODU\"\n";
                  bytes +=
                      "BARCODE 80, 600, \"128\", 100, 1, 0, 2, 2, \"$kargoBarkodu\"\n";

                  bytes +=
                      "TEXT 10, 760, \"2\", 0, 1, 1, \"Tarih-Saat: $formattedDate-$formattedTime\"\n";
                  bytes += "PRINT 1\n";
                  printer.add(gen.rawBytes(bytes.codeUnits));

                  try {
                    if (bluetoothDevice != null) {
                      await printer.printData(bluetoothDevice);
                    } else {
                      throw Exception("Bluetooth device is null");
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Problem Printing 1 $e"),
                      ),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Problem Printing 2 $e"),
                    ),
                  );
                }

                try {
                  final gen =
                      Generator(PaperSize.mm80, await CapabilityProfile.load());
                  final printer = BluePrint();

                  String bytes =
                      "SIZE 60 mm, 120 mm \nGAP 2 mm\nSET CUTTER 1\nCLS\nCODEPAGE 1254\n";
                  bytes +=
                      "TEXT 40, 10, \"3\", 0, 1, 1, \"SARE MAGAZACILIK\"\n";
                  bytes +=
                      "TEXT 40, 40, \"1\", 0, 1, 1, \"KONF. ITH. IHR. SAN. VE TIC.A.S.\"\n";
                  bytes +=
                      "TEXT 40, 80, \"2\", 0, 1, 1, \"Siparis Numarasi: $siparisNo\"\n";
                  bytes += "TEXT 40, 110, \"2\", 0, 1, 1, \"Sn: $name\"\n";
                  bytes += "TEXT 40, 140, \"2\", 0, 1, 1, \"Adres:\"\n";
                  bytes += "TEXT 40, 170, \"2\", 0, 1, 1, \"$address1\"\n";
                  bytes += "TEXT 40, 200, \"2\", 0, 1, 1, \"$address2\"\n";
                  bytes += "TEXT 40, 230, \"2\", 0, 1, 1, \"$address3\"\n";
                  bytes += "TEXT 40, 260, \"2\", 0, 1, 1, \"$address4\"\n";
                  bytes += "TEXT 40, 290, \"2\", 0, 1, 1, \"Tel: $tel\"\n";
                  bytes +=
                      "TEXT 40, 320, \"2\", 0, 1, 1, \"Cikis Magaza: $sube\"\n";

                  bytes +=
                      "TEXT 150, 380, \"2\", 0, 1, 1, \"FATURA BARKODU\"\n";
                  bytes +=
                      "BARCODE 80, 410, \"128\", 100, 1, 0, 2, 2, \"$faturaBarkodu\"\n";

                  bytes +=
                      "TEXT 0, 560, \"2\", 0, 1, 1, \"---------------------------------------------------------\"\n";
                  bytes +=
                      "TEXT 100, 590, \"2\", 0, 1, 1, \"IADE KODU: 20133551\"\n";
                  bytes +=
                      "TEXT 40, 620, \"2\", 0, 1, 1, \"KARGO FIRMASI: YURTICI KARGO\"\n";

                  bytes +=
                      "TEXT 30, 650, \"2\", 0, 1, 1, \"Iade icin bu barkodu paket\"\n";
                  bytes +=
                      "TEXT 30, 680, \"2\", 0, 1, 1, \"uzerine yapistirip kargo\"\n";
                  bytes +=
                      "TEXT 30, 710, \"2\", 0, 1, 1, \"firmasina teslim edebilirsiniz.\"\n";

                  bytes +=
                      "TEXT 0, 740, \"2\", 0, 1, 1, \"---------------------------------------------------------\"\n";

                  //  bytes +=
                  //    "BARCODE 80, 600, \"128\", 100, 1, 0, 2, 2, \"422412753\"\n";

                  bytes +=
                      "TEXT 10, 760, \"2\", 0, 1, 1, \"Tarih-Saat: $formattedDate-$formattedTime\"\n";
                  bytes += "PRINT 1\n";

                  printer.add(gen.rawBytes(bytes.codeUnits));

                  try {
                    if (bluetoothDevice != null) {
                      await printer.printData(bluetoothDevice);
                      ScaffoldMessenger.of(context).removeCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Done Printing"),
                        ),
                      );
                    } else {
                      throw Exception("Bluetooth device is null");
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Problem Printing 3 $e"),
                      ),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Problem Printing 4 $e"),
                    ),
                  );
                }
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
