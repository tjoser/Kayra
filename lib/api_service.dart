import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'https://apibeta.kayra.com/api';
  static String user = '?gil(dLAH]~WUBkHi6o`hfYX6@iea%';
  static String password = 'Jn;*7(W%![>-]%>qQyI_Wy\$A_6mK';
  static String basicAuthCredentials =
      base64Encode(utf8.encode('$user:$password'));
//login
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    const String apiUrl = '$baseUrl/Users/Login';

    final Map<String, dynamic> requestData = {
      "CellPhone": "string",
      "EMail": email,
      "Password": password,
    };
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'accept': '*/*',
        'Content-Type': 'application/json',
        'Authorization': 'Basic $basicAuthCredentials',
      },
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      return data;
    } else {
      log(response.statusCode.toString());
      throw Exception("Login failed");
    }
  }

//barcodeControl
  static Future<Map<String, dynamic>> barcodeControl(
      String barcode, String siparisId) async {
    final Map<String, String> queryParams = {
      "barcode": barcode,
      "siparisId": siparisId,
    };

    final uri = Uri.https(
        'apibeta.kayra.com', '/api/Store/BarcodeControl', queryParams);

    final response = await http.post(
      uri,
      headers: {
        'accept': 'text/plain',
        'Authorization': 'Basic $basicAuthCredentials',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return responseData;
    } else {
      throw Exception(response.statusCode);
    }
  }

//getOrdersByStoreId
  static Future<List<Map<String, dynamic>>> getOrdersByStoreId(
      int userId) async {
    final Map<String, String> queryParams = {
      "userId": userId.toString(),
    };

    final Uri uri = Uri.https(
        'apibeta.kayra.com', '/api/Store/GetOrdersByStoreId', queryParams);
    print(uri.toString());

    final response = await http.get(
      uri,
      headers: {
        'accept': 'text/plain',
        'Authorization': 'Basic $basicAuthCredentials',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> orderData = json.decode(response.body);

      return List<Map<String, dynamic>>.from(orderData);
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else {
      throw Exception(response.statusCode);
    }
  }

//nebimAktar
  static Future<Map<String, dynamic>> nebimAktar(
      int siparisId, String barcode, int userId) async {
    final Map<String, String> queryParams = {
      "siparisId": siparisId.toString(),
      "barcode": barcode.toString(),
      "userId": userId.toString(),
    };

    final uri =
        Uri.https('apibeta.kayra.com', '/api/Store/NebimAktar', queryParams);
    log(uri.toString());

    final response = await http.post(
      uri,
      headers: {
        'accept': 'text/plain',
        'Authorization': 'Basic $basicAuthCredentials',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      log(responseData.toString());
      return responseData;
    } else {
      throw Exception(response.statusCode);
    }
  }

//nebimAktarList
  static Future<Map<String, dynamic>> nebimAktarList(
      List<String> barcodes, List<int> ids, int userId) async {
    const String apiUrl = '$baseUrl/Store/NebimAktarList';

    final Map<String, dynamic> requestBody = {
      "barcodes": barcodes.join(','),
      "ids": ids,
      "UserId": userId,
    };
    log(requestBody.toString());

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'accept': 'text/plain',
        'Content-Type': 'application/json',
        'Authorization': 'Basic $basicAuthCredentials',
      },
      body: json.encode(requestBody),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      log(responseData.toString());
      return responseData;
    } else {
      throw Exception(response.statusCode);
    }
  }

//reportProblem
  static Future<Map<String, dynamic>> reportProblem(
      int sorunId, String aciklama, int userId, String sorunluUrun) async {
    final Map<String, String> queryParams = {
      "sorunId": sorunId.toString(),
      "aciklama": aciklama,
      "userId": userId.toString(),
      "sorunluUrun": sorunluUrun.toString(),
    };

    final uri =
        Uri.https('apibeta.kayra.com', '/api/Store/ReportProblem', queryParams);

    log(uri.toString());

    final response = await http.post(
      uri,
      headers: {
        'accept': 'text/plain',
        'Authorization': 'Basic $basicAuthCredentials',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return responseData;
    } else {
      throw Exception(response.statusCode);
    }
  }

//getUserOrderDetail
  static Future<Map<String, dynamic>> getUserOrderDetail(
      int siparisId, int userId, int langId) async {
    const String apiUrl = '$baseUrl/Order/GetUserOrderDetail';

    final Map<String, String> queryParams = {
      'siparisId': siparisId.toString(),
      'UserId': userId.toString(),
      'langId': langId.toString(),
    };

    final Uri uri = Uri.parse(apiUrl).replace(queryParameters: queryParams);

    final response = await http.get(
      uri,
      headers: {
        'accept': 'text/plain',
        'Authorization': 'Basic $basicAuthCredentials',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return responseData;
    } else {
      throw Exception(response.statusCode);
    }
  }
}
