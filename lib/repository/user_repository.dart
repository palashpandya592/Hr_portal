import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  FirebaseAuth? firebaseAuth;

  UserRepository() {
    firebaseAuth = FirebaseAuth.instance;
  }

  Future<User> createUser(String? email, String? password) async {
    var result;
    try {
      result = await firebaseAuth!
          .createUserWithEmailAndPassword(email: email!, password: password!);
      return result.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print("weak-password");
      } else if (e.code == 'email-already-in-use') {
        print("email-already-in-use");
      } else if (e.code == 'user-not-found') {
        print("user-not-found");
      } else if (e.code == 'wrong-password') {
        print("Wrong Password");
      }
    } catch (e) {
      print(e);
    }
    return result.user!;
  }

  Future<User> signInUser(String? email, String? password) async {
    var result;
    try {
      result = await firebaseAuth!
          .signInWithEmailAndPassword(email: email!, password: password!);
      return result.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print("weak-password");
      } else if (e.code == 'email-already-in-use') {
        print("email-already-in-use");
      } else if (e.code == 'user-not-found') {
        print("user-not-found");
      } else if (e.code == 'wrong-password') {
        print("Wrong Password");
      }
    } catch (e) {
      print(e);
    }
    return result.user!;
  }

  Future<void> signOut() async {
    await firebaseAuth!.signOut();
  }

  Future<bool> isSignedIn() async {
    var currentUser = await firebaseAuth!.currentUser;
    return currentUser != null;
  }

  Future<User> getCurrentUser() async {
    return await firebaseAuth!.currentUser!;
  }
}
