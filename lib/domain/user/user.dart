class UserModel {
  final String? uid;
  final String? email;
  final String? name;
  final String? nickname;
  final String? photoUrl;

  UserModel({this.uid, this.email, this.name, this.nickname, this.photoUrl});

  factory UserModel.fromMap(Map data) {
    return UserModel(
      uid: data['uid'],
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      nickname: data['nickname'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "name": name,
        "nickname": nickname,
        "photoUrl": photoUrl
      };
}
