// 서버 통신 결과 json -> dart object
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_blog/controller/dto/user/LoginReqDto.dart';
import 'package:flutter_firebase_blog/domain/user/user.dart';
import 'package:flutter_firebase_blog/domain/user/user_provider.dart';

class UserRepository {
  final UserProvider _userProvider = UserProvider();

  Future<String> login(String email, String password) async {
    LoginReqDto dto = LoginReqDto(email, password);
    try {
      await _userProvider.login(dto);
      return "success";
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  Future<String> join(String username, String email, String password) async {
    LoginReqDto dto = LoginReqDto(email, password);
    try {
      UserCredential userCredential = await _userProvider.join(dto);
      UserModel _newUser = UserModel(
        uid: userCredential.user!.uid,
        email: userCredential.user!.email!,
        name: username,
        photoUrl: "photoUrl",
      );
      await _userProvider.joinDetail(_newUser);
      return "success";
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }
}
