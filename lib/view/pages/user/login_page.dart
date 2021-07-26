import 'package:flutter/material.dart';
import 'package:flutter_firebase_blog/controller/user/user_controller.dart';
import 'package:flutter_firebase_blog/main.dart';
import 'package:flutter_firebase_blog/util/validator_util.dart';
import 'package:flutter_firebase_blog/view/components/custom_elevated_button.dart';
import 'package:flutter_firebase_blog/view/components/custom_text_form_field.dart';
import 'package:flutter_firebase_blog/view/constants/colors.dart';
import 'package:flutter_firebase_blog/view/pages/user/join_page.dart';
import 'package:flutter_firebase_blog/view/size/size.dart';
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _socialLoginButton(context, "google"),
                _socialLoginButton(context, "apple"),
              ],
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

  Widget _socialLoginButton(BuildContext context, String social) {
    return InkWell(
      onTap: () async {
        int? result = await UserController.to.googleLogin();
        if (result != 1) {
          Get.to(Splash());
        }
      },
      child: Container(
        width: getGoogleOrAppleIconWidth(context),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: ContainerColor,
          border: Border.all(width: 2, color: BorderColor),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          width: 30,
          height: 30,
          child: Image.asset(
            'assets/images/$social.png',
            color: Colors.white,
          ),
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
