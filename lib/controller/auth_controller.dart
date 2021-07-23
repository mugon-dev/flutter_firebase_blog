import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_blog/domain/user/user.dart';
import 'package:flutter_firebase_blog/settings/firebase.dart';
import 'package:flutter_firebase_blog/view/pages/post/home_page.dart';
import 'package:flutter_firebase_blog/view/pages/user/login_page.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();
  Rxn<User> firebaseUser = Rxn<User>();
  Rxn<UserModel> firestoreUser = Rxn<UserModel>();
  RxBool isLoggedIn = false.obs;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    //run every time auth state changes
    ever(firebaseUser, handleAuthChanged);
    firebaseUser.bindStream(user);
  }

  handleAuthChanged(_firebaseUser) async {
    //get user data from firestore
    // if (_firebaseUser?.uid != null) {
    //   firestoreUser.bindStream(streamFirestoreUser());
    // }
    if (_firebaseUser == null) {
      Get.offAll(() => LoginPage());
    } else {
      Get.offAll(() => HomePage());
    }
  }

  // Firebase user one-time fetch
  Future<User> get getUser async => auth.currentUser!;

  // Firebase user a realtime stream
  Stream<User?> get user => auth.authStateChanges();

  //Streams the firestore user from the firestore collection
  Stream<UserModel> streamFirestoreUser() {
    print('streamFirestoreUser()');

    return firebaseFirestore
        .doc('/users/${firebaseUser.value!.uid}')
        .snapshots()
        .map((snapshot) => UserModel.fromMap(snapshot.data()!));
  }

  //get the firestore user from the firestore collection
  Future<UserModel> getFirestoreUser() {
    return firebaseFirestore
        .doc('/users/${firebaseUser.value!.uid}')
        .get()
        .then(
            (documentSnapshot) => UserModel.fromMap(documentSnapshot.data()!));
  }

  // Sign out
  Future<void> signOut() {
    return auth.signOut();
  }
}
