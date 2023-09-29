
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ Database Helper/Database Helper.dart';

class HomeController extends GetxController {
  final RxList<Map<String, dynamic>> accounts = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadAccounts();
  }

  Future<void> loadAccounts() async {
    final accountList = await DatabaseHelper.instance.getAccounts();
    accounts.assignAll(accountList);
  }

  Future<void> editAccount(Map<String, dynamic> account) async {
    String username = account['username'] ?? '';
    String password = account['password'] ?? '';
    String age = account['age'] ?? '';
    String imageUrl = account['imageUrl'] ?? '';
    String email = account['email'] ?? '';

    await showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        String updatedUsername = username;
        String updatedPassword = password;
        String updatedAge = age;
        String updatedImageUrl = imageUrl;
        String updatedEmail = email;

        return AlertDialog(
          title: Text('Sửa Tài Khoản'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  updatedUsername = value;
                },
                controller: TextEditingController(text: username),
                decoration: InputDecoration(labelText: 'Tên tài khoản'),
              ),
              TextField(
                onChanged: (value) {
                  updatedPassword = value;
                },
                controller: TextEditingController(text: password),
                decoration: InputDecoration(labelText: 'Mật khẩu'),
                obscureText: true,
              ),
              TextField(
                onChanged: (value) {
                  updatedAge = value;
                },
                controller: TextEditingController(text: age),
                decoration: InputDecoration(labelText: 'Tuổi'),
              ),
              TextField(
                onChanged: (value) {
                  updatedImageUrl = value;
                },
                controller: TextEditingController(text: imageUrl),
                decoration: InputDecoration(labelText: 'Image URL'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                if (updatedUsername.isNotEmpty && updatedPassword.isNotEmpty) {
                  final updatedAccount = {
                    'id': account['id'],
                    'username': updatedUsername,
                    'password': updatedPassword,
                    'age': updatedAge,
                    'imageUrl': updatedImageUrl,
                  };
                  await DatabaseHelper.instance.updateAccount(updatedAccount);
                  print('Đã cập nhật tài khoản có ID: ${account['id']}');
                  Navigator.of(context).pop();
                  await _updateAccountsList();
                }
              },
              child: Text('Lưu'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Hủy'),
            ),
          ],
        );
      },
    );
  }


  Future<void> showAddAccountDialog(BuildContext context) async {
    String username = '';
    String password = '';
    String age = '';
    String imageUrl = '';

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Thêm Tài Khoản'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  username = value;
                },
                decoration: InputDecoration(labelText: 'Tên tài khoản'),
              ),
              TextField(
                onChanged: (value) {
                  password = value;
                },
                decoration: InputDecoration(labelText: 'Mật khẩu'),
                obscureText: true,
              ),
              TextField(
                onChanged: (value) {
                  age = value;
                },
                decoration: InputDecoration(labelText: 'Tuổi'),
              ),
              TextField(
                onChanged: (value) {
                  imageUrl = value;
                },
                decoration: InputDecoration(labelText: 'URL Hình ảnh'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                if (username.isNotEmpty && password.isNotEmpty) {
                  final account = {
                    'username': username,
                    'password': password,
                    'age': age,
                    'imageUrl': imageUrl,
                  };
                  final id = await DatabaseHelper.instance.insertAccount(account);
                  print('Đã thêm tài khoản mới có ID: $id');
                  Navigator.of(context).pop();
                  await _updateAccountsList();
                }
              },
              child: Text('Thêm'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _updateAccountsList();
              },
              child: Text('Hủy'),
            ),
          ],
        );
      },
    );

    await loadAccounts();
  }

  Future<void> _updateAccountsList() async {
    await loadAccounts();
  }
  void deleteAccount(Map<String, dynamic> account) async {
    final accountId = account['id'];
    final rowsDeleted = await DatabaseHelper.instance.deleteAccount(accountId);
    if (rowsDeleted > 0) {
      print('Đã xóa tài khoản có ID: $accountId');
      await _updateAccountsList();
    } else {
      print('Không có tài khoản nào được xóa.');
    }
  }

}
