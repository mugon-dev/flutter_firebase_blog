import 'package:flutter/material.dart';
import 'package:flutter_firebase_blog/controller/auth_controller.dart';
import 'package:flutter_firebase_blog/domain/user/user.dart';
import 'package:get/get.dart';

class UserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // UserController u = Get.put(UserController()); 앱 재시작할때 데이터가 없음
    AuthController a = Get.put(AuthController());
    UserModel user = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("userInfo"),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(height: 50),
            Container(
              width: 120,
              height: 120,
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Container(
                    width: 100,
                    height: 100,
                    child: Image.network(
                      "https://i.stack.imgur.com/l60Hf.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            Text("회원 argument 유저네임: ${user.name}"),
            Text("회원 argument 이메일: ${user.email}"),
            Text("회원 유저네임 : ${a.firestoreUser.value!.name}"),
            Text("회원 이메일 : ${a.firestoreUser.value!.email}"),
            // Text("회원 가입날짜 : ${u.principal.value.created}"),
          ],
        ),
      ),
    );
  }
}
