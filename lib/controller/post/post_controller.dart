import 'package:flutter_firebase_blog/controller/dto/post/PostResDto.dart';
import 'package:flutter_firebase_blog/domain/post/post.dart';
import 'package:flutter_firebase_blog/domain/post/post_repository.dart';
import 'package:flutter_firebase_blog/domain/user/user.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  static PostController get to => Get.find();
  final _postRepository = PostRepository();
  final posts = <PostResDto>[].obs;
  final post = Post().obs;

  Future<void> findAll() async {
    List<PostResDto> posts = await _postRepository.findAll();
    this.posts.value = posts;
  }

  Future<void> insert({
    required String title,
    required String content,
    required UserModel user,
  }) async {
    await _postRepository.insert(title: title, content: content, user: user);
  }
}
