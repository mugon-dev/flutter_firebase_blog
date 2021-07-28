import 'package:flutter_firebase_blog/domain/post/post_repository.dart';
import 'package:flutter_firebase_blog/domain/user/user.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  static PostController get to => Get.find();
  final _postRepository = PostRepository();

  Future<void> findAll() async {
    await _postRepository.findAll();
  }

  Future<void> insert({
    required String title,
    required String content,
    required UserModel user,
  }) async {
    await _postRepository.insert(title: title, content: content, user: user);
  }
}
