import 'package:flutter/material.dart';
import 'package:flutter_firebase_blog/controller/auth_controller.dart';
import 'package:flutter_firebase_blog/controller/post/post_controller.dart';
import 'package:flutter_firebase_blog/util/validator_util.dart';
import 'package:flutter_firebase_blog/view/components/custom_elevated_button.dart';
import 'package:flutter_firebase_blog/view/components/custom_text_form_field.dart';
import 'package:flutter_firebase_blog/view/components/custom_textarea.dart';
import 'package:get/get.dart';

import 'home_page.dart';

class WritePage extends GetView<PostController> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _content = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Write page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomTextFormField(
                controller: _title,
                hint: "title",
                funValidator: validatorTitle(),
              ),
              CustomTextarea(
                controller: _content,
                hint: "content",
                funValidator: validatorContent(),
              ),
              CustomElevatedButton(
                  text: "글쓰기",
                  funPageRoute: () {
                    controller.insert(
                        title: _title.text,
                        content: _content.text,
                        user: AuthController.to.firestoreUser()!);
                    Get.to(() => HomePage());
                  }),
              SizedBox(height: 15),
              CustomElevatedButton(text: "취소", funPageRoute: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
