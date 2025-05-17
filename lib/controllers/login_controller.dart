import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_real_estate/api/api_client.dart';
import 'package:app_real_estate/dblocal/shared_preferences.dart';
import 'package:app_real_estate/routers/routerName.dart';

class LoginController extends GetxController {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final isPasswordVisible = false.obs;
  final isLoading = false.obs;
  final isFormValid = false.obs;
  final rememberMe = false.obs;

  final apiClient = ApiClient();

  @override
  void onInit() {
    super.onInit();
    phoneController.addListener(validateForm);
    passwordController.addListener(validateForm);
    phoneController.text = "0985495876";
    passwordController.text = "123";
  }

  void validateForm() {
    final phone = phoneController.text.trim();
    final password = passwordController.text.trim();
    isFormValid.value = phone.isNotEmpty && password.isNotEmpty;
  }

  void login() async {
    if (!isFormValid.value) return;

    isLoading.value = true;
    final result = await apiClient.login(
      phoneNumber: phoneController.text.trim(),
      password: passwordController.text.trim(),
    );

    if (result.containsKey("error")) {
      Get.snackbar(
        "Lỗi",
        result["error"],
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );
      isLoading.value = false;
      return;
    }

    await SharedPreferenceApp.handleSetString(
      'accessToken',
      result["accessToken"],
    );
    // await SharedPreferenceApp.handleSetString(
    //   'refreshToken',
    //   result["refreshToken"],
    // );
    isLoading.value = false;
    Get.offAllNamed(RouterName.main);
  }

  @override
  void onClose() {
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
