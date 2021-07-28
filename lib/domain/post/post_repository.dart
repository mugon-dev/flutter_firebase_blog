import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_blog/domain/post/post.dart';
import 'package:flutter_firebase_blog/domain/post/post_provider.dart';
import 'package:flutter_firebase_blog/domain/user/user.dart';

class PostRepository {
  final _postProvider = PostProvider();

  Future<void> findAll() async {
    List<QueryDocumentSnapshot<Post>> posts = await _postProvider.findAll();
    print(posts.toString());
  }

  Future<void> insert({
    required String title,
    required String content,
    required UserModel user,
  }) async {
    Post post = Post(
      title: title,
      content: content,
      user: user,
      created: DateTime.now(),
      updated: DateTime.now(),
    );
    await _postProvider.insert(post);
  }
}
