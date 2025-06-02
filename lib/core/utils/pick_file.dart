import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

Future<FilePickerResult?> pickFile(FileType type) async {
  if (kIsWeb) {
    final image = await FilePicker.platform.pickFiles(type: type);
    return image;
  } else if (Platform.isAndroid || Platform.isIOS) {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      if (androidInfo.version.sdkInt >= 29) {
        final image = await FilePicker.platform.pickFiles(type: type);
        return image;
      } else {
        var status = await Permission.storage.status;

        if (!status.isGranted) {
          status = await Permission.storage.request();
        }

        if (status.isGranted) {
          final image = await FilePicker.platform.pickFiles(type: type);

          if (image != null && image.files.isNotEmpty) {
            return image;
          }
        }
      }
    } else if (Platform.isIOS) {
      var status = await Permission.photos.status;

      if (!status.isGranted) {
        status = await Permission.photos.request();
      }

      if (status.isGranted) {
        final image = await FilePicker.platform.pickFiles(type: type);

        if (image != null && image.files.isNotEmpty) {
          return image;
        }
      }
    }
  }

  return null;
}
