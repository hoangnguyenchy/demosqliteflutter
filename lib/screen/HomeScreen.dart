import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/HomeController.dart';

class HomeScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Màn Hình Chính'),
      ),
      body: Obx(() => controller.accounts.isEmpty
          ? Center(child: Text('Không có tài khoản nào.'))
          : ListView.builder(
        itemCount: controller.accounts.length,
        itemBuilder: (context, index) {
          final account = controller.accounts[index];
          final username = account['username'];
          final password = account['password'];
          final age = account['age'];
          final imageUrl = account['imageUrl'];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ListTile(
                  title: Text('Tên tài khoản: $username'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Mật khẩu: $password'),
                      Text('Tuổi: $age'),
                      Text('Image: $imageUrl'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          controller.editAccount(account);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          controller.deleteAccount(account);
                        },
                      ),
                    ],
                  ),
                ),
                Divider(),
              ],
            ),
          );
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await controller.showAddAccountDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
