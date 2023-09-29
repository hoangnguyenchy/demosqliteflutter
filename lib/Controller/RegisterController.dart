import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:appnghich/screen/login_screen.dart';
import 'package:appnghich/ Database Helper/Database Helper.dart';

class RegisterController extends GetxController {
  final RxString username = ''.obs;
  final RxString password = ''.obs;
  final RxBool isFormValid = false.obs;
  final RxBool isRegistered = false.obs;
  final RxBool isDuplicate = false.obs;

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

  void registerAccount() async {
    if (isFormValid.value) {
      bool isAccountExists = await checkIfAccountExists(username.value);

      if (!isAccountExists) {
        final account = {'username': username.value, 'password': password.value};
        int id = await DatabaseHelper.instance.insertAccount(account);
        print('Đã thêm tài khoản mới có ID: $id');
        isRegistered.value = true;

        Get.snackbar(
          'Thông báo',
          'Đăng ký thành công',
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM,
        );

        Future.delayed(Duration(seconds: 2), () {
          Get.off(LoginScreen());
        });
      } else {
        isDuplicate.value = true;
        Get.snackbar(
          'Thông báo',
          'Tài khoản đã tồn tại',
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } else {
      Get.snackbar(
        'Thông báo',
        'Vui lòng nhập đủ thông tin',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<bool> checkIfAccountExists(String username) async {
    List<Map<String, dynamic>> accounts =
    await DatabaseHelper.instance.queryAccountByUsername(username);
    return accounts.isNotEmpty;
  }
}
