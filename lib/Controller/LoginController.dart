import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:appnghich/screen/HomeScreen.dart';

import '../ Database Helper/Database Helper.dart';

class LoginController extends GetxController {
  final RxString username = ''.obs;
  final RxString password = ''.obs;
  final RxBool isFormValid = false.obs;

  void setUsername(String value) {
    username.value = value;
    validateForm();
  }

  void setPassword(String value) {
    password.value = value;
    validateForm();
  }

  void validateForm() {
    if (username.isNotEmpty && password.isNotEmpty) {
      isFormValid.value = true;
    } else {
      isFormValid.value = false;
    }
  }

  void login() async {
    if (isFormValid.value) {
      bool isLoginSuccessful = await checkLogin(username.value, password.value);

      if (isLoginSuccessful) {
        Get.offAll(HomeScreen());
        showSuccessSnackbar('Đăng nhập thành công');
      } else {
        showErrorSnackbar('Đăng nhập thất bại');
      }
    } else {
      showErrorSnackbar('Vui lòng nhập đủ thông tin');
    }
  }

  void showSuccessSnackbar(String message) {
    Get.snackbar(
      'Thông báo',
      message,
      backgroundColor: Colors.green,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void showErrorSnackbar(String message) {
    Get.snackbar(
      'Thông báo',
      message,
      backgroundColor: Colors.red,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future<bool> checkLogin(String username, String password) async {
    var user = await DatabaseHelper.instance.queryAccount(username, password);
    print(user.toString());
    return !user.isEmpty;
  }
}
