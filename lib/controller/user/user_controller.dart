import 'package:flutter_firebase_blog/domain/user/user.dart';
import 'package:flutter_firebase_blog/domain/user/user_repository.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController get to => Get.find();
  final UserRepository _userRepository = UserRepository();
  final principal = UserModel().obs;

  Future<int?> googleLogin() async {
    Map<String, dynamic> result = await _userRepository.googleLogin();
    if (result.containsKey("success")) {
      principal.value = await result["success"];
      print(principal.value.uid);
      return 1;
    } else {
      print(await result["fail"].code);
      return -1;
    }
  }

  Future<void> login(String email, String password) async {
    String result = await _userRepository.login(email, password);
    if (result == "success") {
      print("success");
    } else if (result == "user-not-found") {
      print('No user found for that email.');
    } else if (result == "wrong-password") {
      print('Wrong password provided for that user.');
    } else {
      print(result);
    }
  }

  Future<void> join(String username, String email, String password) async {
    String result = await _userRepository.join(username, email, password);
    if (result == "success") {
      print("success");
    } else if (result == "user-not-found") {
      print('No user found for that email.');
    } else if (result == "wrong-password") {
      print('Wrong password provided for that user.');
    } else {
      print(result);
    }
  }
}
