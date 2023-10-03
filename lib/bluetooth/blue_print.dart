import 'dart:math';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

extension WriteLarge on BluetoothCharacteristic {
  Future<void> writeLarge(List<int> value, int mtu, {int timeout = 15}) async {
    int chunk = mtu - 3;
    /*print("mtu: $mtu");
    print("chunk: $chunk");
    print(value.toString());*/
    try {
      for (int i = 0; i < value.length; i += chunk) {
/*      print("i: $i");
        print("i+chunk = ${i += chunk}");
        print("value.length: ${value.length}");
        print("min value: ${min(value.length, i + chunk)}");*/
        List<int> subvalue = value.sublist(i, min(value.length, i + chunk));
        // print("subvalue length: ${subvalue.length}");
        await write(subvalue, withoutResponse: false, timeout: timeout);
      }
    } catch (e) {
      print("exception in writeLarge");
      print(e.toString());
    }
  }
}

class BluePrint {
  BluePrint({this.chunkLen = 512});

  final int chunkLen;
  final _data = List<int>.empty(growable: true);

  void add(List<int> data) {
    _data.addAll(data);
  }

  List<List<int>> getChunks() {
    final chunks = List<List<int>>.empty(growable: true);
    for (var i = 0; i < _data.length; i += chunkLen) {
      chunks.add(_data.sublist(i, min(i + chunkLen, _data.length)));
    }
    return chunks;
  }

  Future<void> printData(BluetoothDevice device) async {
    final data = getChunks();
    final characs = await _getCharacteristics(device);
    var services = characs
        .where((element) =>
            element.properties.write == true ||
            element.properties.writeWithoutResponse == true)
        .toList();
    print("data length: ${data.length}");
    print(data.toString());
    data.forEach((element) {
      print(element.length);
    });
    for (var i = 0; i < services.length; i++) {
      if (services[i].properties.writeWithoutResponse) {
        if (await _tryPrint(services[i], data, await device.mtu.first)) {
          break;
        }
      }
    }
  }

  Future<bool> _tryPrint(
    BluetoothCharacteristic charac,
    List<List<int>> data,
    int mtuSize,
  ) async {
    for (var i = 0; i < data.length; i++) {
      try {
        // await charac.write(data[i]);
        await charac.writeLarge(data[i], mtuSize);
      } catch (e) {
        print(e.toString());
        return false;
      }
    }
    return true;
  }

  Future<List<BluetoothCharacteristic>> _getCharacteristics(
    BluetoothDevice device,
  ) async {
    final services = await device.discoverServices();
    final res = List<BluetoothCharacteristic>.empty(growable: true);
    for (var i = 0; i < services.length; i++) {
      res.addAll(services[i].characteristics);
    }
    return res;
  }
}
