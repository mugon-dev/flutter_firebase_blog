import 'package:flutter/material.dart';
import 'package:flutter_firebase_blog/controller/user/user_controller.dart';
import 'package:flutter_firebase_blog/domain/user/user.dart';
import 'package:flutter_firebase_blog/util/validator_util.dart';
import 'package:flutter_firebase_blog/view/components/custom_elevated_button.dart';
import 'package:flutter_firebase_blog/view/components/custom_text_form_field.dart';
import 'package:get/get.dart';

class UserInfoUpdatePage extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();
  final _nickname = TextEditingController();
  final _email = TextEditingController();
  UserModel user = Get.arguments;

  @override
  Widget build(BuildContext context) {
    _nickname.text = "${user.nickname}";
    _email.text = "${user.email}";
    return Scaffold(
        appBar: AppBar(
          title: Text("UserInfo Update"),
        ),
        body: ListView(
          children: [
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: _userInfoForm(),
              ),
            ),
          ],
        ));
  }

  Widget _userInfoForm() {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          CustomTextFormField(
            controller: _nickname,
            hint: "Nickname",
            funValidator: validatorUsername(),
          ),
          SizedBox(height: 15),
          CustomElevatedButton(
            text: "회원 정보 수정",
            funPageRoute: () async {
              _formkey.currentState!.validate();
              UserController.to.updateUserDetail(_nickname.text, user.uid!);
              // UserModel updateUser = await AuthController.to.getFirestoreUser();
              Get.back();
            },
          ),
          SizedBox(height: 15),
          CustomElevatedButton(
            text: "취소",
            funPageRoute: () {
              Get.back(closeOverlays: true);
            },
          ),
        ],
      ),
    );
  }
}
