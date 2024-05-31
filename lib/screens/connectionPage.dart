import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kayra_stores/bluetooth/blue_print.dart';
import 'package:kayra_stores/screens/homePage.dart';
import 'package:kayra_stores/widgets/drawer.dart';
import 'package:kayra_stores/bluetooth/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Map<DeviceIdentifier, ValueNotifier<bool>> isConnectingOrDisconnecting =
    {};
final Map<DeviceIdentifier, StreamController<bool>> isDiscoveringServices = {};
final Map<DeviceIdentifier, StreamController<List<BluetoothService>>>
    servicesStream = {};

class ScanPage extends StatelessWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BluetoothAdapterState>(
        stream: FlutterBluePlus.adapterState,
        initialData: BluetoothAdapterState.unknown,
        builder: (c, snapshot) {
          final adapterState = snapshot.data;
          if (adapterState == BluetoothAdapterState.on) {
            return const FindDevicesScreen();
          } else {
            FlutterBluePlus.stopScan();
            return BluetoothOffScreen(adapterState: adapterState);
          }
        });
  }
}

class BluetoothOffScreen extends StatelessWidget {
  const BluetoothOffScreen({Key? key, this.adapterState}) : super(key: key);

  final BluetoothAdapterState? adapterState;

  @override
  Widget build(BuildContext context) {
    final snackBarKeyA = GlobalKey<ScaffoldMessengerState>();

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
      backgroundColor: const Color(0xFFFEECDE),
      drawer: const CustomDrawer(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(
              Icons.bluetooth_disabled,
              size: 180.0,
              color: Color(0xFF552500),
            ),
            Text(
              'Bluetooth adaptörü is ${adapterState != null ? adapterState.toString().split(".").last : 'not available'}.',
              style: Theme.of(context)
                  .primaryTextTheme
                  .titleSmall
                  ?.copyWith(color: const Color(0xFF552500)),
            ),
            const SizedBox(
              height: 20,
            ),
            if (Platform.isAndroid)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF690B0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'aç',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () async {
                  try {
                    if (Platform.isAndroid) {
                      await FlutterBluePlus.turnOn();
                    }
                  } catch (e) {
                    final snackBar =
                        snackBarFail(prettyException("Error Turning On:", e));
                    snackBarKeyA.currentState?.removeCurrentSnackBar();
                    snackBarKeyA.currentState?.showSnackBar(snackBar);
                  }
                },
              ),
          ],
        ),
      ),
    );
  }
}

class FindDevicesScreen extends StatefulWidget {
  const FindDevicesScreen({Key? key}) : super(key: key);

  @override
  State<FindDevicesScreen> createState() => _FindDevicesScreenState();
}

class _FindDevicesScreenState extends State<FindDevicesScreen> {
  @override
  Widget build(BuildContext context) {
    final snackBarKeyA = GlobalKey<ScaffoldMessengerState>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFFEECDE),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          ),
          child: AppBar(
            title: const Text(
              'Cihazları bul',
              style: TextStyle(color: Color(0xFF552500)),
            ),
            backgroundColor: Colors.transparent,
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
        ),
      ),
      backgroundColor: Colors.white,
      drawer: const CustomDrawer(),
      body: RefreshIndicator(
        onRefresh: () {
          setState(() {});
          if (FlutterBluePlus.isScanningNow == false) {
            FlutterBluePlus.startScan(
                timeout: const Duration(seconds: 5),
                androidUsesFineLocation: false);
          }
          return Future.delayed(const Duration(milliseconds: 500));
        },
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              StreamBuilder<List<BluetoothDevice>>(
                stream:
                    Stream.fromFuture(FlutterBluePlus.connectedSystemDevices),
                initialData: const [],
                builder: (c, snapshot) => Column(
                  children: (snapshot.data ?? [])
                      .map((d) => ListTile(
                            title: Text(d.platformName),
                            subtitle: Text(d.remoteId.toString()),
                            trailing: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                StreamBuilder<BluetoothConnectionState>(
                                  stream: d.connectionState,
                                  initialData:
                                      BluetoothConnectionState.disconnected,
                                  builder: (c, snapshot) {
                                    if (snapshot.data ==
                                        BluetoothConnectionState.connected) {
                                      return Row(
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color(0xFFF690B0),
                                            ),
                                            child: const Text('Testi Yazdır'),
                                            onPressed: () {
                                              printTest(d);
                                            },
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color(0xFFF690B0),
                                            ),
                                            child: const Text('Bağlantıyı Kes'),
                                            onPressed: () async {
                                              isConnectingOrDisconnecting[
                                                      d.remoteId] ??=
                                                  ValueNotifier(true);
                                              isConnectingOrDisconnecting[
                                                      d.remoteId]!
                                                  .value = true;
                                              try {
                                                await d.disconnect();
                                                isConnectingOrDisconnecting[
                                                        d.remoteId] ??=
                                                    ValueNotifier(true);
                                                isConnectingOrDisconnecting[
                                                        d.remoteId]!
                                                    .value = true;
                                                d
                                                    .connect(
                                                        timeout: const Duration(
                                                            seconds: 35))
                                                    .catchError((e) {
                                                  final snackBar = snackBarFail(
                                                      prettyException(
                                                          "Bağlan Error:", e));
                                                  snackBarKeyA.currentState
                                                      ?.removeCurrentSnackBar();
                                                  snackBarKeyA.currentState
                                                      ?.showSnackBar(snackBar);
                                                }).whenComplete(() {
                                                  isConnectingOrDisconnecting[
                                                          d.remoteId] ??=
                                                      ValueNotifier(false);
                                                  isConnectingOrDisconnecting[
                                                          d.remoteId]!
                                                      .value = false;
                                                });
                                              } catch (e) {
                                                final snackBar = snackBarFail(
                                                    prettyException(
                                                        "Disconnect Error:",
                                                        e));
                                                snackBarKeyA.currentState
                                                    ?.removeCurrentSnackBar();
                                                snackBarKeyA.currentState
                                                    ?.showSnackBar(snackBar);
                                              }
                                              isConnectingOrDisconnecting[
                                                      d.remoteId] ??=
                                                  ValueNotifier(false);
                                              isConnectingOrDisconnecting[
                                                      d.remoteId]!
                                                  .value = false;
                                            },
                                          ),
                                        ],
                                      );
                                    }
                                    if (snapshot.data ==
                                        BluetoothConnectionState.disconnected) {
                                      return ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: Colors.black,
                                          backgroundColor:
                                              const Color(0xFFDEFCFE),
                                        ),
                                        child: const Text('Bağlan'),
                                        onPressed: () {
                                          isConnectingOrDisconnecting[
                                                  d.remoteId] ??=
                                              ValueNotifier(true);
                                          isConnectingOrDisconnecting[
                                                  d.remoteId]!
                                              .value = true;
                                          d
                                              .connect(
                                                  timeout: const Duration(
                                                      seconds: 35))
                                              .catchError((e) {
                                            final snackBar = snackBarFail(
                                                prettyException(
                                                    "Bağlan Error:", e));
                                            snackBarKeyA.currentState
                                                ?.removeCurrentSnackBar();
                                            snackBarKeyA.currentState
                                                ?.showSnackBar(snackBar);
                                          }).then((v) async {
                                            isConnectingOrDisconnecting[
                                                    d.remoteId] ??=
                                                ValueNotifier(false);
                                            isConnectingOrDisconnecting[
                                                    d.remoteId]!
                                                .value = false;
                                            navigateToHomePageWithBluetooth(d);
                                          });
                                        },
                                      );
                                    }
                                    return Text(snapshot.data
                                        .toString()
                                        .toUpperCase()
                                        .split('.')[1]);
                                  },
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ),
              StreamBuilder<List<ScanResult>>(
                stream: FlutterBluePlus.scanResults,
                initialData: const [],
                builder: (c, snapshot) => Column(
                  children: (snapshot.data ?? [])
                      .map(
                        (r) => ScanResultTile(
                            result: r,
                            onTap: () {
                              isConnectingOrDisconnecting[r.device.remoteId] ??=
                                  ValueNotifier(true);
                              isConnectingOrDisconnecting[r.device.remoteId]!
                                  .value = true;
                              r.device
                                  .connect(timeout: const Duration(seconds: 35))
                                  .catchError((e) {
                                final snackBar = snackBarFail(
                                    prettyException("Bağlan Error:", e));
                                snackBarKeyA.currentState
                                    ?.removeCurrentSnackBar();
                                snackBarKeyA.currentState
                                    ?.showSnackBar(snackBar);
                              }).then((v) {
                                isConnectingOrDisconnecting[
                                    r.device.remoteId] ??= ValueNotifier(false);
                                isConnectingOrDisconnecting[r.device.remoteId]!
                                    .value = false;
                                navigateToHomePageWithBluetooth(r.device);
                              });
                            }),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: StreamBuilder<bool>(
        stream: FlutterBluePlus.isScanning,
        initialData: false,
        builder: (c, snapshot) {
          if (snapshot.data ?? false) {
            return FloatingActionButton(
              child: const Icon(
                Icons.stop,
              ),
              onPressed: () async {
                try {
                  FlutterBluePlus.stopScan();
                } catch (e) {
                  final snackBar =
                      snackBarFail(prettyException("Stop Scan Error:", e));
                  snackBarKeyA.currentState?.removeCurrentSnackBar();
                  snackBarKeyA.currentState?.showSnackBar(snackBar);
                }
              },
            );
          } else {
            return SizedBox(
              height: 80,
              width: 80,
              child: FloatingActionButton(
                backgroundColor: const Color(0xFFF690B0),
                child: const Text(
                  "Taramak",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () async {
                  try {
                    await FlutterBluePlus.startScan(
                        timeout: const Duration(seconds: 5),
                        androidUsesFineLocation: false);
                  } catch (e) {
                    final snackBar =
                        snackBarFail(prettyException("Start Scan Error:", e));
                    snackBarKeyA.currentState?.removeCurrentSnackBar();
                    snackBarKeyA.currentState?.showSnackBar(snackBar);
                  }
                  setState(() {});
                },
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> navigateToHomePageWithBluetooth(
      BluetoothDevice bluetoothDevice) async {
    String bluetoothDeviceJson = (bluetoothDevice.remoteId).toString();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("bluetoothDeviceID", bluetoothDeviceJson);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => HomePage(bluetoothDevice: bluetoothDevice),
      ),
    );
  }
}

String prettyException(String prefix, dynamic e) {
  if (e is FlutterBluePlusException) {
    return "$prefix ${e.description}";
  } else if (e is PlatformException) {
    return "$prefix ${e.message}";
  }
  return prefix + e.toString();
}

printTest(BluetoothDevice bluetoothDevice) async {
  DateTime now = DateTime.now();
  String formattedDate = "${now.day}/${now.month}/${now.year}";
  String formattedTime = "${now.hour}:${now.minute}:${now.second}";

  final gen = Generator(PaperSize.mm80, await CapabilityProfile.load());

  final printer = BluePrint();
  String bytes =
      "SIZE 60 mm, 120 mm \nGAP 2 mm\nSET CUTTER 1\nCLS\nCODEPAGE 1254\n";
  bytes += "TEXT 40, 10, \"3\", 0, 1, 1, \"TESTING SARE MAGAZACILIK\"\n";
  bytes +=
      "TEXT 40, 40, \"1\", 0, 1, 1, \"KONF. ITH. IHR. SAN. VE TIC.A.S.\"\n";
  bytes += "TEXT 40, 100, \"2\", 0, 1, 1, \"Siparis Numarasi: 248224\"\n";
  bytes += "TEXT 40, 130, \"2\", 0, 1, 1, \"Sn: Zehra Bileyici\"\n";
  bytes += "TEXT 40, 160, \"2\", 0, 1, 1, \"Adres:\"\n";
  bytes += "TEXT 40, 190, \"2\", 0, 1, 1, \"Cumhuriyet Mh. Cay Sk. No:66\"\n";
  bytes += "TEXT 40, 220, \"2\", 0, 1, 1, \"Sahin Apt. Kat 1 Daire\"\n";
  bytes += "TEXT 40, 250, \"2\", 0, 1, 1, \"Tel: +90 5075170518\"\n";
  bytes += "TEXT 40, 280, \"2\", 0, 1, 1, \"Cikis Magaza: ANKAMALL\"\n";

  bytes += "TEXT 150, 320, \"2\", 0, 1, 1, \"FATURA BARKODU\"\n";
  bytes += "BARCODE 80, 350, \"128\", 100, 1, 0, 2, 2, \"2-R-7-785463\"\n";

  bytes += "TEXT 150, 500, \"2\", 0, 1, 1, \"KARGO BARKODU\"\n";
  bytes += "BARCODE 80, 530, \"128\", 100, 1, 0, 2, 2, \"MGZ4ec9f77\"\n";

  bytes += "TEXT 150, 680, \"2\", 0, 1, 1, \"IADE BARKODU\"\n";
  bytes += "BARCODE 80, 710, \"128\", 100, 1, 0, 2, 2, \"20133551\"\n";

  bytes +=
      "TEXT 0, 780, \"2\", 0, 1, 1, \"--------------------------------------\"\n";
  bytes +=
      "TEXT 10, 830, \"2\", 0, 1, 1, \"Tarih-Saat: $formattedDate-$formattedTime\"\n";

  bytes += "PRINT 1\n";
  printer.add(gen.rawBytes(bytes.codeUnits));
  EasyLoading.showInfo("bytes: ${bytes.codeUnits.length}");

  await printer.printData(bluetoothDevice);
}

printKayraEntry(BluetoothDevice bluetoothDevice) async {
  final gen = Generator(PaperSize.mm80, await CapabilityProfile.load());

  final printer = BluePrint();
  String bytes = "SIZE 60 mm, 40 mm\n";
  bytes += "GAP 2 mm\n";
  bytes += "SET CUTTER 1\n";
  bytes += "CLS\n";
  bytes += "CODEPAGE 1254\n";
/**
 * kayra QR CODE
   bytes +=
      "QRCODE 100,15,L,7,M,0,M1,S1,\"xAX52Hfllz7LHEcF+Y8avXlHjcJ+EwQrWlk1vGiLbjLMRMKjLgsryKeUlI+LEGBKXH0RZbelQkEKQhDGkecX2YFm2mfGwFZswQMfHg==\"\n";
 */
  bytes +=
      "QRCODE 100,15,L,7,M,0,M1,S1,\"xAX52Hfllz7LHEcF+Y8avXlHjcJ+EwQrWlk1vGiLbjLMRMKjLgsryKeUlI+LEGBKXH0RZbelQkEKQhDGkecX2YFm2mfGwFZswQMfHg==\"\n";

  bytes += "PRINT 1\n";

  printer.add(gen.rawBytes(bytes.codeUnits));
  await printer.printData(bluetoothDevice);
}

printLabel(
  BluetoothDevice connectedDevice,
) async {
  final gen = Generator(PaperSize.mm58, await CapabilityProfile.load());
  final printer = BluePrint();
  String bytes = "SIZE 60 mm, 40 mm\n";
  bytes += "GAP 2 mm\n";
  bytes += "SET CUTTER 1\n";
  bytes += "CLS\n";
  bytes += "CODEPAGE 1254\n";

  bytes += "TEXT 410, 15, \"2\", 90, 1, 1, \"LA261032\"\n"; // Y = 15
  bytes += "TEXT 380, 15, \"2\", 90, 1, 1, \"Elibse\"\n"; // Y = 15
  bytes += "TEXT 350, 15, \"2\", 90, 1, 1, \"25\"\n"; // Y = 15
  bytes += "TEXT 325, 15, \"2\", 90, 1, 1, \"Yesil\"\n"; // Y = 15

  bytes += "TEXT 305, 15, \"1\", 90, 1, 1, \"36-42-11116202\"\n"; // Y = 15

  bytes += "TEXT 285, 15, \"1\", 90, 1, 1, \"BEDEN/SIZE:\"\n"; // Y = 15
  bytes += "TEXT 285, 135, \"2\", 90, 1, 1, \"38\"\n"; // Y = 135
  bytes += "TEXT 165, 15, \"1\", 90, 1, 1, \"30.03.2023\"\n"; // Y = 15
  bytes += "TEXT 120, 15, \"3\", 90, 1, 1, \"3699 TL\"\n"; // Y = 15

  bytes +=
      "BARCODE 350, 300, \"EAN13\", 50, 1, 180, 3, 1, \"8683766321675\"\n"; // Y = 315

  bytes += "PRINT 1\n";

  printer.add(gen.rawBytes(bytes.codeUnits));

  await printer.printData(connectedDevice);
}
