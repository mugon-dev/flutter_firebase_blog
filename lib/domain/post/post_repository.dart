import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_blog/controller/dto/post/PostResDto.dart';
import 'package:flutter_firebase_blog/domain/post/post.dart';
import 'package:flutter_firebase_blog/domain/post/post_provider.dart';
import 'package:flutter_firebase_blog/domain/user/user.dart';

class PostRepository {
  final _postProvider = PostProvider();

  Future<List<PostResDto>> findAll() async {
    List<QueryDocumentSnapshot<Post>> posts = await _postProvider.findAll();
    List<PostResDto> result = posts
        .map((e) => PostResDto(
            id: e.reference.id,
            title: e.data().title,
            content: e.data().content,
            user: e.data().user,
            created: e.data().created,
            updated: e.data().updated))
        .toList();
    print(posts.map((e) => e.reference.id));
    return result;
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
