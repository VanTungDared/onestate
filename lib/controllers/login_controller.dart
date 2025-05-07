import 'package:app_real_estate/api/api_client.dart';
import 'package:app_real_estate/dblocal/shared_preferences.dart';
import 'package:app_real_estate/routers/routerName.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final apiClient = ApiClient();

  final isPasswordVisible = false.obs;
  final isLoading = false.obs;
  final isFormValid = false.obs;

  @override
  void onInit() {
    super.onInit();
    phoneController.text = "0985495876";
    passwordController.text = "Hao2000@8x";
    phoneController.addListener(validateForm);
    passwordController.addListener(validateForm);
  }

  void validateForm() {
    final phone = phoneController.text.trim();
    final password = passwordController.text;
    isFormValid.value = phone.isNotEmpty && password.isNotEmpty;
    isFormValid.value = true;
  }

  void login() async {
    if (!isFormValid.value) return;
    isLoading.value = true;
    Map<String, dynamic> result = await apiClient.login(
      phoneNumber: phoneController.text,
      password: passwordController.text,
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
    } else {
      await SharedPreferenceApp.handleSetString(
        'accessToken',
        result["accessToken"],
      );
      await SharedPreferenceApp.handleSetString(
        'refreshToken',
        result["refreshToken"],
      );
      isLoading.value = false;
      Get.offAllNamed(RouterName.main);
    }
  }

  @override
  void onClose() {
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
