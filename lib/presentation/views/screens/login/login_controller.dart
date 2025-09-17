import 'package:app_real_estate/core/utils/constants/pref_keys.dart';
import 'package:app_real_estate/data/datasources/dblocal/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/api/api_client.dart';
import '../../../../core/utils/notifier.dart';
import '../../../../domain/usecases/login_usecase.dart';
import '../../../routers/routerName.dart';

class LoginController extends GetxController {
  final LoginUseCase loginUseCase;

  LoginController(this.loginUseCase);

  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final isPasswordVisible = false.obs;
  final isLoading = false.obs;
  final isFormValid = false.obs;
  final rememberMe = false.obs;

  final apiClient = DioClient();

  @override
  void onInit() {
    super.onInit();
    phoneController.addListener(validateForm);
    passwordController.addListener(validateForm);
    _loadSavedCredentials();
  }

  void validateForm() {
    final phone = phoneController.text.trim();
    final password = passwordController.text.trim();
    isFormValid.value = phone.isNotEmpty && password.isNotEmpty;
  }

  Future<void> _loadSavedCredentials() async {
    final savedRemember =
        SharedPreferenceApp.handleGetBool(PrefKeys.rememberMe) ?? false;
    rememberMe.value = savedRemember;

    if (savedRemember) {
      final savedUser =
          SharedPreferenceApp.handleGetString(PrefKeys.username) ?? '';
      final savedPass =
          SharedPreferenceApp.handleGetString(PrefKeys.password) ?? '';

      phoneController.text = savedUser;
      passwordController.text = savedPass;
    }
  }

  void login() async {
    if (!isFormValid.value) return;

    isLoading.value = true;

    final result = await loginUseCase.call(
      phoneController.text.trim(),
      passwordController.text.trim(),
    );

    result.fold(
      (errorMessage) {
        LoadingNotifier.showTopMessage(errorMessage, false);
        isLoading.value = false;
      },
      (data) async {
        /// xử lý rememberMe
        if (rememberMe.value) {
          await SharedPreferenceApp.handleSetBool(PrefKeys.rememberMe, true);
          await SharedPreferenceApp.handleSetString(
            PrefKeys.username,
            phoneController.text.trim(),
          );
          await SharedPreferenceApp.handleSetString(
            PrefKeys.password,
            passwordController.text.trim(),
          );
        } else {
          await SharedPreferenceApp.handleRemove(PrefKeys.rememberMe);
          await SharedPreferenceApp.handleRemove(PrefKeys.username);
          await SharedPreferenceApp.handleRemove(PrefKeys.password);
        }

        isLoading.value = false;
        Get.offAllNamed(RouterName.main);
      },
    );
  }

  @override
  void onClose() {
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
