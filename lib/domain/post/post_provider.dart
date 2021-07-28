import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_blog/domain/post/post.dart';
import 'package:flutter_firebase_blog/settings/firebase.dart';

class PostProvider {
  final postRef = firebaseFirestore.collection("post").withConverter<Post>(
        fromFirestore: (snapshot, options) => Post.fromJson(snapshot.data()!),
        toFirestore: (post, options) => post.toJson(),
      );

  Future<List<QueryDocumentSnapshot<Post>>> findAll() async =>
      await postRef.get().then((snapshot) => snapshot.docs);

  Future<void> insert(Post post) async => await postRef.add(post);
}
