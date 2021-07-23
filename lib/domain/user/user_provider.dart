// 서버와 통신

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_blog/controller/dto/user/LoginReqDto.dart';
import 'package:flutter_firebase_blog/domain/user/user.dart';
import 'package:flutter_firebase_blog/settings/firebase.dart';

class UserProvider {
  Future<UserCredential> login(LoginReqDto dto) async =>
      await auth.signInWithEmailAndPassword(
          email: dto.email.toString(), password: dto.password.toString());

  Future<UserCredential> join(LoginReqDto dto) async =>
      await auth.createUserWithEmailAndPassword(
          email: dto.email.toString(), password: dto.password.toString());

  Future<void> joinDetail(UserModel user) async =>
      await firebaseFirestore.doc('/users/${user.uid}').set(user.toJson());
}
