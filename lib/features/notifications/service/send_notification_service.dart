import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sis/core/utils/constants.dart';
import 'package:sis/features/notifications/service/get_server_key.dart';

class SendNotificationService {
  static Future<void> sendNotificationServiceApi({
    required List<String>? tokens,
    required String? title,
    required String? body,
    required Map<String, dynamic>? data,
  }) async {
    if (tokens == null || tokens.isEmpty) {
      print("No tokens provided for notification.");
      return;
    }

    String serverKey = await GetServerKey().getServerKeyToken();
    print("Notification server key: $serverKey");

    var headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $serverKey',
    };

    for (String token in tokens) {
      Map<String, dynamic> message = {
        "message": {
          "token": token,
          "notification": {
            "title": title,
            "body": body,
          },
          "data": data,
        },
      };

      try {
        final http.Response response = await http.post(
          Uri.parse(PushNotification.url),
          headers: headers,
          body: jsonEncode(message),
        );

        if (response.statusCode == 200) {
          print('Notification sent successfully to token: $token');
        } else {
          print('Failed to send notification to token: $token');
          print('Error: ${response.statusCode} - ${response.body}');
        }
      } catch (e) {
        print('Exception while sending notification: $e');
      }
    }
  }
}
