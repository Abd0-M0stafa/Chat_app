import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> regeterUser(
      {required String email, required String password}) async {
    emit(RegisterLoading());
    try {
      UserCredential user =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'email-already-in-use') {
        emit(ResgisterFailure(errorMessage: 'the email already used'));
      } else if (ex.code == 'weak-password') {
        emit(ResgisterFailure(errorMessage: 'The password is too weak.'));
      }
    } catch (e) {
      emit(ResgisterFailure(
          errorMessage: 'An error occurred. Please try again later.'));
    }
  }

  Future<void> loginUser(
      {required String email, required String password}) async {
    emit(LoginLoading());
    try {
      UserCredential user =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailure(errorMessage: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailure(
            errorMessage: 'Wrong password provided for that user.'));
      }
    } catch (e) {
      emit(LoginFailure(errorMessage: 'there was an error.'));
    }
  }

  signInWithGoogle() async {
    emit(SignWithGoogleLoading());
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        await FirebaseAuth.instance.signInWithCredential(credential);
      }
      emit(SignWithGoogleSuccess());
    } catch (e) {
      emit(SignWithGoogleFailure(errorMessage: e.toString()));
    }
  }

  signInWithFacebook() async {
    emit(SignWithFacebookLoading());
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
      emit(SignWithFacebookSuccess());
    } catch (e) {
      emit(SignWithGoogleFailure(errorMessage: e.toString()));
    }
  }
}
