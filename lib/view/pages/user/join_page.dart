import 'package:flutter/material.dart';
import 'package:flutter_firebase_blog/controller/user/user_controller.dart';
import 'package:flutter_firebase_blog/util/validator_util.dart';
import 'package:flutter_firebase_blog/view/components/custom_elevated_button.dart';
import 'package:flutter_firebase_blog/view/components/custom_text_form_field.dart';
import 'package:get/get.dart';

class JoinPage extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

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
                "회원가입 페이지",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            _joinForm(),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text("이미 가입했어요"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _joinForm() {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          CustomTextFormField(
            controller: _username,
            hint: "Username",
            funValidator: validatorUsername(),
          ),
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
            text: "회원가",
            funPageRoute: () async {
              _formkey.currentState!.validate();
              UserController.to.join(_username.text.trim(), _email.text.trim(),
                  _password.text.trim());
              Get.snackbar("로그인 시도", "로그인 실패");
            },
          ),
        ],
      ),
    );
  }
}
