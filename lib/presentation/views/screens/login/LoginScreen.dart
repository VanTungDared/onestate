import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      "assets/images/bg_login.png",
                      width: 430.w,
                      height: 80.h,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned.fill(
                    child: Image.asset(
                      "assets/images/icon_login.png",
                      width: 200.w,
                      height: 80.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 22.h),
            Text(
              'greeting'.tr,
              style: TextStyle(fontSize: 16.sp, color: Colors.black),
            ),
            SizedBox(height: 4.h),
            Text(
              "Đăng nhập để tiếp tục",
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 22.h),
            TextField(
              controller: controller.phoneController,
              decoration: InputDecoration(
                hintText: "SDT",
                hintStyle: TextStyle(color: Colors.grey[500]),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 16.h),

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
                    borderRadius: BorderRadius.circular(8.r),
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
            SizedBox(height: 8.h),
            Row(
              children: [
                Obx(
                  () => Checkbox(
                    value: controller.rememberMe.value,
                    onChanged:
                        (val) => controller.rememberMe.value = val ?? false,
                    activeColor: Color(0xFFDC1C2E),
                  ),
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
            SizedBox(height: 8.h),

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
                              fontSize: 16.sp,
                              color: Colors.white,
                            ),
                          ),
                ),
              ),
            ),
            SizedBox(height: 12.h),

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
            SizedBox(height: 12.h),
            Center(
              child: TextButton(
                onPressed: () {},
                child: Text.rich(
                  TextSpan(
                    text: 'Chưa là thành viên? ',
                    style: TextStyle(color: Colors.black, fontSize: 13.sp),
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
    );
  }
}
