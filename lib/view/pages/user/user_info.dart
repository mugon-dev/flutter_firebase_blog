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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
