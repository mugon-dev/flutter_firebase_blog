// 서버 통신 결과 json -> dart object
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_blog/controller/dto/user/JoinReqDto.dart';
import 'package:flutter_firebase_blog/controller/dto/user/LoginReqDto.dart';
import 'package:flutter_firebase_blog/controller/dto/user/UpdateReqDto.dart';
import 'package:flutter_firebase_blog/domain/user/user.dart';
import 'package:flutter_firebase_blog/domain/user/user_provider.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {
  final UserProvider _userProvider = UserProvider();

  Future<void> updateUserDetail(String nickname, String uid) async {
    UpdateReqDto updateUser = UpdateReqDto(nickname: nickname, uid: uid);
    await _userProvider.updateUserDetail(updateUser);
  }

  Future<Map<String, dynamic>> googleLogin() async {
    GoogleSignInAccount? googleUser = await _userProvider.googleLogin();
    GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    try {
      UserModel _newUser = UserModel(
        uid: userCredential.user!.uid,
        email: userCredential.user!.email,
        name: userCredential.user!.displayName,
        nickname: userCredential.user!.displayName,
        photoUrl: "photoUrl",
      );
      await _userProvider.joinDetail(_newUser);

      return {"success": _newUser};
    } on FirebaseAuthException catch (e) {
      return {"fail": e};
    }
  }

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
    JoinReqDto dto = JoinReqDto(username, email, password);
    try {
      UserCredential userCredential = await _userProvider.join(dto);
      UserModel _newUser = UserModel(
        uid: userCredential.user!.uid,
        email: email,
        name: username,
        nickname: username,
        photoUrl: "photoUrl",
      );
      await _userProvider.joinDetail(_newUser);
      return "success";
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }
}
