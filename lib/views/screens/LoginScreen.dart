import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/login_controller.dart';

class LoginScreen extends StatelessWidget {
  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Top image (logo + illustration)
              // Center(
              //   child: Image.asset(
              //     'assets/images/login_header.png',
              //     height: 180,
              //   ),
              // ),
              const SizedBox(height: 16),

              Text(
                "Xin chào bạn",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              const SizedBox(height: 4),
              Text(
                "Đăng nhập để tiếp tục",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 28),

              /// Phone/email input
              TextField(
                controller: controller.phoneController,
                decoration: InputDecoration(
                  hintText: "SDT chính hoặc email",
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              /// Password input
              Obx(
                () => TextField(
                  controller: controller.passwordController,
                  obscureText: !controller.isPasswordVisible.value,
                  decoration: InputDecoration(
                    hintText: "Mật khẩu",
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordVisible.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: controller.isPasswordVisible.toggle,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              /// Remember + forgot
              Row(
                children: [
                  Checkbox(
                    value: controller.rememberMe.value,
                    onChanged:
                        (val) => controller.rememberMe.value = val ?? false,
                    activeColor: Color(0xFFDC1C2E),
                  ),
                  Text("Nhớ tài khoản"),
                  Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Quên mật khẩu?",
                      style: TextStyle(color: Color(0xFFDC1C2E)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              /// Login button
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:
                        controller.isFormValid.value &&
                                !controller.isLoading.value
                            ? controller.login
                            : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFDC1C2E),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child:
                        controller.isLoading.value
                            ? CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            )
                            : Text(
                              "Đăng nhập",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              /// Policy
              Text.rich(
                TextSpan(
                  text: 'Bằng việc tiếp tục, bạn đồng ý với ',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                  children: [
                    TextSpan(
                      text:
                          'Điều khoản sử dụng, Chính sách bảo mật, Quy chế, Chính sách',
                      style: TextStyle(color: Color(0xFFDC1C2E)),
                    ),
                    TextSpan(text: ' của chúng tôi.'),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              /// Register link
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: Text.rich(
                    TextSpan(
                      text: 'Chưa là thành viên? ',
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: 'Đăng ký tại đây',
                          style: TextStyle(
                            color: Color(0xFFDC1C2E),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
