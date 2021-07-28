// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_firebase_blog/domain/user/user.dart';
import 'package:flutter_firebase_blog/settings/firebase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

void main() {
  test("post insert", () async {
    final postRef = firebaseFirestore.collection("post").withConverter<Post>(
          fromFirestore: (snapshot, options) => Post.fromJson(snapshot.data()!),
          toFirestore: (post, options) => post.toJson(),
        );

    // Add a movie
    await postRef.add(
      Post(
        title: "json['title']",
        content: "json['content']",
      ),
    );
  });
}

class Post {
  final int? id;
  final String? title;
  final String? content;
  final UserModel? user;
  final DateTime? created;
  final DateTime? updated;

  Post({
    this.id,
    this.title,
    this.content,
    this.user,
    this.created,
    this.updated,
  });

  Post.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        content = json['content'],
        user = UserModel.fromMap(json['user']),
        created = DateFormat("yyyy-mm-dd").parse(json['created']),
        updated = DateFormat("yyyy-mm-dd").parse(json['updated']);

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'user': user!.toJson(),
      'created': created,
      'updated': updated,
    };
  }
}
