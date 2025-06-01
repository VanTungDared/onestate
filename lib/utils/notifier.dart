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

  static void showTopMessage(String message, bool isSuccess) {
    Get.rawSnackbar(
      messageText: Container(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSuccess ? Icons.check_circle : Icons.cancel,
              color: isSuccess ? Colors.green : Colors.red,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.transparent, // không dùng màu nền ngoài
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      borderRadius: 0.0,
      isDismissible: true,
      animationDuration: Duration.zero,
      duration: const Duration(seconds: 2),
    );
  }
}
