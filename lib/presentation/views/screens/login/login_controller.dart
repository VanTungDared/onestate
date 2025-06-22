import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../../core/utils/api/api_client.dart';
import '../../../../core/utils/notifier.dart';
import '../../../../data/datasources/dblocal/shared_preferences.dart';
import '../../../../data/models/UserModel.dart';
import '../../../routers/routerName.dart';


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
      LoadingNotifier.showTopMessage(result["error"], false);
      isLoading.value = false;
      return;
    }

    await SharedPreferenceApp.handleSetString(
      'accessToken',
      result["accessToken"],
    );
    final result2 = await apiClient.getCurrentUser();
    if (result2.containsKey("error")) {
      LoadingNotifier.showTopMessage(result2["error"], false);
      isLoading.value = false;
      return;
    }
    isLoading.value = false;
    Get.offAllNamed(RouterName.main, arguments: UserModel.fromJson(result2));
  }

  @override
  void onClose() {
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
