import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:appnghich/Controller/RegisterController.dart';


class RegisterScreen extends StatelessWidget {
  final RegisterController controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đăng Ký'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                onChanged: controller.setUsername,
                decoration: InputDecoration(
                  labelText: 'Tên tài khoản',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                onChanged: controller.setPassword,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Mật khẩu',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),

              SizedBox(height: 20), //

              ElevatedButton(
                onPressed: () {
                  controller.registerAccount();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                ),
                child: Text('Đăng Ký'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
