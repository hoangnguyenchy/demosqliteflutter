import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:appnghich/Controller/LoginController.dart';
import 'package:appnghich/screen/register_screen.dart';

class LoginScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đăng Nhập'),
      ),
      body: Center(
        child: SizedBox(
          width: 350,
          height:350,
          child: Card(
            elevation: 5.0,
            margin: EdgeInsets.all(20.0),
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
                  SizedBox(height: 20),

                  // Nút Đăng nhập
                  ElevatedButton(
                    onPressed: () {
                      controller.login();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      onPrimary: Colors.white,
                    ),
                    child: Text('Đăng Nhập'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterScreen()),
                      );
                    },
                    child: Text('Đăng Ký'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
