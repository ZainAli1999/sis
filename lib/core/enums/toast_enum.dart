import 'package:toastification/toastification.dart';

enum ToastType { success, error, info, warning }

extension ToastTypeExtension on ToastType {
  ToastificationType get toToastificationType {
    switch (this) {
      case ToastType.success:
        return ToastificationType.success;
      case ToastType.error:
        return ToastificationType.error;
      case ToastType.info:
        return ToastificationType.info;
      case ToastType.warning:
        return ToastificationType.warning;
    }
  }
}
