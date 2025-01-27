import 'package:core/utils/result_data.dart';
import 'package:data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../util/error_message.dart';
import '../../util/firebase_options.dart';

class AuthService {
  late FirebaseAuth _auth;
  late GoogleSignIn googleSignIn;

  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    _auth = FirebaseAuth.instance;
    googleSignIn = GoogleSignIn();
  }

  Future<bool> checkVerification() async {
    final user = _auth.currentUser;
    await user?.reload();
    if(user?.emailVerified==true){
      return true;
    }else{
      return false;
    }
    // setState(() {
    //   _isEmailVerified = user?.emailVerified ?? false;
    // });
  }

  Future<bool> sendVerificationEmail() async {
    if (_auth.currentUser != null && !_auth.currentUser!.emailVerified) {
      try {
        await _auth.currentUser!.sendEmailVerification();
        return true;
      } catch (e) {
        return false;
      }
    } else {
      return true;
    }
  }

  Future<ResultData<User?>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;
      return Success(user);
    } on FirebaseAuthException catch (e) {
      return Failure(errorMessages[e.code] ?? e.message);
    }
  }

  Future<ResultData<User?>> createUser(
      {required String email, required String password}) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return Success(result.user);
    } on FirebaseAuthException catch (e) {
      return Failure(errorMessages[e.code] ?? e.message);
    }
  }

  Future<ResultData<User?>> loginUser(
      {required String email, required String password}) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return Success(result.user);
    } on FirebaseAuthException catch (e) {
      return Failure(errorMessages[e.code] ?? e.message);
    }
  }

  Future<ResultData<bool>> signOut() async {
    try {
      final result = await _auth.signOut();
      return Success(true);
    } on FirebaseAuthException catch (e) {
      return Failure(errorMessages[e.code] ?? e.message);
    }
  }
}
