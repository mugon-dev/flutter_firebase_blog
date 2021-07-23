import 'package:flutter/material.dart';
import 'package:flutter_firebase_blog/controller/user/user_controller.dart';
import 'package:flutter_firebase_blog/util/validator_util.dart';
import 'package:flutter_firebase_blog/view/components/custom_elevated_button.dart';
import 'package:flutter_firebase_blog/view/components/custom_text_form_field.dart';
import 'package:flutter_firebase_blog/view/pages/user/join_page.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              height: 200,
              child: Text(
                "로그인 페이지",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            _loginForm(),
            TextButton(
              onPressed: () {
                Get.to(() => JoinPage());
              },
              child: Text("아직 회원가입이 안되어 있나요?"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loginForm() {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          CustomTextFormField(
            controller: _email,
            hint: "Email",
            funValidator: validatorEmail(),
          ),
          CustomTextFormField(
            controller: _password,
            hint: "Password",
            funValidator: validatorPassword(),
          ),
          CustomElevatedButton(
            text: "로그인",
            funPageRoute: () async {
              _formkey.currentState!.validate();
              UserController.to
                  .login(_email.text.trim(), _password.text.trim());
              // Get.to(() => HomePage());
              // Get.snackbar("로그인 시도","로그인 실패");
            },
          ),
        ],
      ),
    );
  }
}
