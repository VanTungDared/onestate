import 'package:app_real_estate/domain/usecases/get_user_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/api/api_client.dart';
import '../../../../core/utils/notifier.dart';
import '../../../../data/models/UserModel.dart';
import '../../../../domain/usecases/login_usecase.dart';
import '../../../routers/routerName.dart';

class LoginController extends GetxController {
  final LoginUseCase loginUseCase;
  final GetUserUseCase getUserUseCase;

  LoginController(this.loginUseCase, this.getUserUseCase);

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
  }

  void validateForm() {
    final phone = phoneController.text.trim();
    final password = passwordController.text.trim();
    isFormValid.value = phone.isNotEmpty && password.isNotEmpty;
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
        await Future.delayed(Duration(milliseconds: 100));
        final userInfo = await getUserUseCase.call();
        userInfo.fold(
          (errorMessage) {
            LoadingNotifier.showTopMessage(errorMessage, false);
            isLoading.value = false;
          },
          (data) {
            isLoading.value = false;
            Get.offAllNamed(
              RouterName.main,
              arguments: UserModel.fromJson(data),
            );
          },
        );
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

