import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sis/core/utils/constants.dart';

Future<String?> uploadImageWeb(
    Uint8List imageBytes, String fileName, String folderName) async {
  try {
    final uri = Uri.parse(
        "https://api.cloudinary.com/v1_1/${CloudinaryConstants.cloudName}/image/upload");
    final request = http.MultipartRequest("POST", uri);

    request.fields['upload_preset'] = CloudinaryConstants.uploadPreset;
    request.fields['folder'] = folderName;

    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        imageBytes,
        filename: fileName,
      ),
    );

    final response = await request.send();
    if (response.statusCode == 200) {
      final res = await http.Response.fromStream(response);
      final data = jsonDecode(res.body);
      return data['secure_url'];
    } else {
      throw Exception("Failed to upload image: ${response.statusCode}");
    }
  } catch (e) {
    throw Exception("Image upload failed: $e");
  }
}
