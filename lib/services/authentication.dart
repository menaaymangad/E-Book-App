import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final auth = FirebaseAuth.instance;
  Future<UserCredential> registerUser(
      {required String emailAddress, required String password}) async {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
    return credential;
  }

  Future<UserCredential> loginUser(
      {required String emailAddress, required String password}) async {
    final credential = await auth.signInWithEmailAndPassword(
        email: emailAddress, password: password);

    return credential;
  }
   Future<User?> getUser() async {
    final user= await auth.currentUser;
    return user;
  }
}
