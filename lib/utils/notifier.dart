import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingNotifier {
  static bool isLoading = false;

  /// Hiển thị loading hoặc thông báo thành công/thất bại
  static void showLoading({
    required bool isLoad,
    String? message,
    bool isSuccess = true,
  }) {
    if (isLoad && !isLoading) {
      isLoading = true;
      showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );
    } else if (!isLoad && isLoading) {
      isLoading = false;
      Get.back(); // Đóng loading dialog

      // Hiển thị thông báo Success hoặc Error
      if (message != null && message.isNotEmpty) {
        _showTopNotification(message: message, isSuccess: isSuccess);
      }
    }
  }

  static void _showTopNotification({
    required String message,
    bool isSuccess = true,
  }) {
    Get.snackbar(
      isSuccess ? 'Thành công' : 'Thất bại',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: isSuccess ? Colors.green : Colors.red,
      colorText: Colors.white,
      icon: Icon(
        isSuccess ? Icons.check_circle : Icons.error,
        color: Colors.white,
      ),
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(12),
      borderRadius: 8,
    );
  }
}
