// Copyright 2023, Charles Weinberger & Paul DeMarco.
// All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:kayra_stores/bluetooth/blue_print.dart';
import 'package:kayra_stores/widgets/drawer.dart';

import 'package:kayra_stores/bluetooth/widgets.dart';

final snackBarKeyA = GlobalKey<ScaffoldMessengerState>();
final snackBarKeyB = GlobalKey<ScaffoldMessengerState>();
final snackBarKeyC = GlobalKey<ScaffoldMessengerState>();
final Map<DeviceIdentifier, ValueNotifier<bool>> isConnectingOrDisconnecting =
    {};
final Map<DeviceIdentifier, StreamController<bool>> isDiscoveringServices = {};
final Map<DeviceIdentifier, StreamController<List<BluetoothService>>>
    servicesStream = {};

class BluetoothAdapterStateObserver extends NavigatorObserver {
  StreamSubscription<BluetoothAdapterState>? _btStateSubscription;

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (route.settings.name == '/deviceScreen') {
      // Start listening to Bluetooth state changes when a new route is pushed
      _btStateSubscription ??= FlutterBluePlus.adapterState.listen((state) {
        if (state != BluetoothAdapterState.on) {
          // Pop the current route if Bluetooth is off
          navigator?.pop();
        }
      });
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    // Cancel the subscription when the route is popped
    _btStateSubscription?.cancel();
    _btStateSubscription = null;
  }
}

class ScanPage extends StatelessWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.lightBlue,
      home: StreamBuilder<BluetoothAdapterState>(
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
          }),
      navigatorObservers: [BluetoothAdapterStateObserver()],
    );
  }
}

class BluetoothOffScreen extends StatelessWidget {
  const BluetoothOffScreen({Key? key, this.adapterState}) : super(key: key);

  final BluetoothAdapterState? adapterState;

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: snackBarKeyA,
      child: Scaffold(
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
        backgroundColor: Color(0xFFFEECDE),
        drawer: CustomDrawer(),
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
                    ?.copyWith(color: Color(0xFF552500)),
              ),
              SizedBox(
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
    return ScaffoldMessenger(
      key: snackBarKeyB,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Cihazları bul',
            style: TextStyle(color: Color(0xFF552500)),
          ),
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
        backgroundColor: Color(0xFFFEECDE),
        drawer: CustomDrawer(),
        body: RefreshIndicator(
          onRefresh: () {
            setState(() {}); // force refresh of connectedSystemDevices
            if (FlutterBluePlus.isScanningNow == false) {
              FlutterBluePlus.startScan(
                  timeout: const Duration(seconds: 5),
                  androidUsesFineLocation: false);
            }
            return Future.delayed(
                Duration(milliseconds: 500)); // show refresh icon breifly
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
                              trailing: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    StreamBuilder<BluetoothConnectionState>(
                                      stream: d.connectionState,
                                      initialData:
                                          BluetoothConnectionState.disconnected,
                                      builder: (c, snapshot) {
                                        if (snapshot.data ==
                                            BluetoothConnectionState
                                                .connected) {
                                          return Row(
                                            children: [
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      const Color(0xFFF690B0),
                                                ),
                                                child:
                                                    const Text('Testi Yazdır'),
                                                onPressed: () {
                                                  printTest(d);
                                                },
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      const Color(0xFFF690B0),
                                                ),
                                                child: const Text(
                                                    'Bağlantıyı Kes'),
                                                onPressed: () async {
                                                  isConnectingOrDisconnecting[
                                                          d.remoteId] ??=
                                                      ValueNotifier(true);
                                                  isConnectingOrDisconnecting[
                                                          d.remoteId]!
                                                      .value = true;
                                                  try {
                                                    await d.disconnect();
                                                    final snackBar = snackBarGood(
                                                        "Disconnect: Success");
                                                    snackBarKeyC.currentState
                                                        ?.removeCurrentSnackBar();
                                                    snackBarKeyC.currentState
                                                        ?.showSnackBar(
                                                            snackBar);
                                                  } catch (e) {
                                                    final snackBar = snackBarFail(
                                                        prettyException(
                                                            "Disconnect Error:",
                                                            e));
                                                    snackBarKeyC.currentState
                                                        ?.removeCurrentSnackBar();
                                                    snackBarKeyC.currentState
                                                        ?.showSnackBar(
                                                            snackBar);
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
                                            BluetoothConnectionState
                                                .disconnected) {
                                          return ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.black,
                                              shape: RoundedRectangleBorder(),
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
                                                      timeout:
                                                          Duration(seconds: 35))
                                                  .catchError((e) {
                                                final snackBar = snackBarFail(
                                                    prettyException(
                                                        "Bağlan Error:", e));
                                                snackBarKeyC.currentState
                                                    ?.removeCurrentSnackBar();
                                                snackBarKeyC.currentState
                                                    ?.showSnackBar(snackBar);
                                              }).then((v) {
                                                isConnectingOrDisconnecting[
                                                        d.remoteId] ??=
                                                    ValueNotifier(false);
                                                isConnectingOrDisconnecting[
                                                        d.remoteId]!
                                                    .value = false;
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
                                isConnectingOrDisconnecting[
                                    r.device.remoteId] ??= ValueNotifier(true);
                                isConnectingOrDisconnecting[r.device.remoteId]!
                                    .value = true;
                                r.device
                                    .connect(timeout: Duration(seconds: 35))
                                    .catchError((e) {
                                  final snackBar = snackBarFail(
                                      prettyException("Bağlan Error:", e));
                                  snackBarKeyC.currentState
                                      ?.removeCurrentSnackBar();
                                  snackBarKeyC.currentState
                                      ?.showSnackBar(snackBar);
                                }).then((v) {
                                  isConnectingOrDisconnecting[r.device
                                      .remoteId] ??= ValueNotifier(false);
                                  isConnectingOrDisconnecting[
                                          r.device.remoteId]!
                                      .value = false;
                                });
                                ;
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
                child: const Icon(Icons.stop),
                onPressed: () async {
                  try {
                    FlutterBluePlus.stopScan();
                  } catch (e) {
                    final snackBar =
                        snackBarFail(prettyException("Stop Scan Error:", e));
                    snackBarKeyB.currentState?.removeCurrentSnackBar();
                    snackBarKeyB.currentState?.showSnackBar(snackBar);
                  }
                },
                backgroundColor: Colors.red,
              );
            } else {
              return SizedBox(
                height: 80,
                width: 80,
                child: FloatingActionButton(
                    backgroundColor: Color(0xFFF690B0),
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
                        final snackBar = snackBarFail(
                            prettyException("Start Scan Error:", e));
                        snackBarKeyB.currentState?.removeCurrentSnackBar();
                        snackBarKeyB.currentState?.showSnackBar(snackBar);
                      }
                      setState(
                          () {}); // force refresh of connectedSystemDevices
                    }),
              );
            }
          },
        ),
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
  final gen = Generator(PaperSize.mm58, await CapabilityProfile.load());
  final printer = BluePrint();
  String bytes =
      "SIZE 80 mm, 20 mm\nGAP 2 mm\nSET CUTTER 1\nCLS\nCODEPAGE 1254\nTEXT 25, 100, \"1\", 0, 1, 1, \" Khafagaz  \"\nTEXT 25, 50, \"2\", 0, 1, 1, \"\"\nPRINT 1\n";
  printer.add(gen.rawBytes(bytes.codeUnits));
  await printer.printData(bluetoothDevice);
}
