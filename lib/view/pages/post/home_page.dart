import 'package:flutter/material.dart';
import 'package:flutter_firebase_blog/controller/auth_controller.dart';
import 'package:flutter_firebase_blog/controller/post/post_controller.dart';
import 'package:flutter_firebase_blog/domain/user/user.dart';
import 'package:flutter_firebase_blog/view/pages/post/write_page.dart';
import 'package:flutter_firebase_blog/view/pages/user/login_page.dart';
import 'package:flutter_firebase_blog/view/pages/user/user_info.dart';
import 'package:flutter_firebase_blog/view/size/size.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  PostController postController = Get.put(PostController());
  @override
  Widget build(BuildContext context) {
    postController.findAll();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(),
      drawer: _navigation(context),
      body: Obx(
        () => RefreshIndicator(
          key: refreshKey,
          onRefresh: () async {
            await postController.findAll();
          },
          child: ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    postController.findAll();
                  },
                  title: Text(
                      "${postController.posts[index].title} : ${postController.posts[index].id}"),
                  leading: Text("$index"),
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: postController.posts.length),
        ),
      ),
    );
  }

  Widget _navigation(BuildContext context) {
    return Container(
      width: getDrawerWidth(context),
      height: double.infinity,
      color: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  // binding ????????????
                  Get.to(() => WritePage(), binding: BindingsBuilder(() {
                    Get.put(PostController());
                  }));
                },
                child: Text(
                  '?????????',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
              Divider(),
              TextButton(
                onPressed: () async {
                  // ????????? ???????????? drawer ????????????
                  // Navigator.pop(context); // ?????? ?????? ?????? stack ??????
                  scaffoldKey.currentState!
                      .openEndDrawer(); // scaffold key??? ?????? ??????
                  UserModel user = await AuthController.to.getFirestoreUser();
                  Get.to(() => UserInfo(), arguments: user);
                },
                child: Text(
                  '??????????????????',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
              Divider(),
              TextButton(
                onPressed: () {
                  AuthController.to.signOut();
                  Get.to(() => LoginPage());
                },
                child: Text(
                  '????????????',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
