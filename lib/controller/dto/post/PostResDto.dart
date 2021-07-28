import 'package:flutter_firebase_blog/domain/user/user.dart';

class PostResDto {
  final String? id;
  final String? title;
  final String? content;
  final UserModel? user;
  final DateTime? created;
  final DateTime? updated;

  PostResDto({
    this.id,
    this.title,
    this.content,
    this.user,
    this.created,
    this.updated,
  });

  PostResDto.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        content = json['content'],
        user = UserModel.fromMap(json['user']),
        created = json['created'].toDate(),
        updated = json['updated'].toDate();

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
