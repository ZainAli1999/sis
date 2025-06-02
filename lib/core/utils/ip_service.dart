import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sis/core/utils/constants.dart';

class IPCheckService {
  static const List<String> allowedIPs = Constants.allowedIPs;

  static Future<String?> getPublicIP() async {
    try {
      final response =
          await http.get(Uri.parse("https://api.ipify.org?format=json"));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        log(data['ip']);
        return data['ip'];
      }
    } catch (e) {
      log("Error getting IP: $e");
    }
    return null;
  }

  static Future<bool> isAllowed() async {
    final ip = await getPublicIP();
    return ip != null && allowedIPs.contains(ip);
  }
}
