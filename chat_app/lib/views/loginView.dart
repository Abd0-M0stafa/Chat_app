// ignore_for_file: unused_local_variable, use_build_context_synchronously

import 'package:chat_app/Helper/CustomSnakeBar.dart';
import 'package:chat_app/views/chatView.dart';
import 'package:chat_app/views/registerView.dart';
import 'package:chat_app/widgets/customTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isloading = false;

  String? email;

  String? password;

  bool isShown = true;

  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      progressIndicator: const CircularProgressIndicator(
        color: Color.fromARGB(255, 28, 228, 167),
      ),
      inAsyncCall: isloading,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 100,
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 18),
                  child: Center(
                    child: Text(
                      'Login here',
                      style: TextStyle(
                          color: Color.fromARGB(255, 28, 228, 167),
                          fontSize: 35,
                          fontFamily: 'BebasNeue'),
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    'Welcome back you’ve been missed!',
                    style: TextStyle(
                        color: Color.fromARGB(255, 219, 227, 225),
                        fontSize: 20,
                        fontFamily: 'BebasNeue'),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                CustomTextField(
                  controller: controller,
                  validator: (value) {
                    email = value;
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Email';
                    }
                  },
                  onChanged: (data) {
                    email = data;
                  },
                  text: 'Email',
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextField(
                  obscureText: isShown,
                  suffixIcon: isShown
                      ? Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: IconButton(
                            color: const Color.fromARGB(255, 197, 192, 192),
                            icon: const Icon(Icons.visibility_off),
                            onPressed: () {
                              isShown = false;
                              setState(() {});
                            },
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: IconButton(
                            color: const Color.fromARGB(255, 28, 228, 167),
                            icon: const Icon(Icons.visibility),
                            onPressed: () {
                              isShown = true;
                              setState(() {});
                            },
                          ),
                        ),
                  controller: controller2,
                  validator: (value) {
                    email = value;
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                  },
                  onChanged: (data) {
                    password = data;
                  },
                  text: 'Password',
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 28, 228, 167),
                  ),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      isloading = true;
                      setState(() {});
                      try {
                        UserCredential user = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                          email: email!,
                          password: password!,
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => ChatView(
                              email: email,
                            ),
                          ),
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          CustomSnakeBar(context,
                              text: 'No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          CustomSnakeBar(context,
                              text: 'Wrong password provided for that user.');
                        }
                      } catch (ex) {
                        CustomSnakeBar(context, text: 'there was an error.');
                      }

                      isloading = false;
                      setState(() {});
                      controller.clear();
                      controller2.clear();
                    }
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account?',
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const RegisterView(),
                          ),
                        );
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          color: Color.fromARGB(255, 28, 228, 167),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                const Center(child: Text('Or continue with')),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {
                          signInWithGoogle();
                        },
                        child: SizedBox(
                          height: 20,
                          child: Image.asset(
                            'images/google_icon.png',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {
                          signInWithFacebook();
                        },
                        child: const Icon(
                          Icons.facebook,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  signInWithGoogle() async {
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
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => ChatView(
              email: googleSignInAccount.email,
            ),
          ),
        );
      }
    } catch (e) {
      CustomSnakeBar(context,
          text: 'An error occurred. Please try again later.');
    }
  }

  signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);

      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => ChatView(
            email: userCredential.user!.email,
          ),
        ),
      );
    } catch (e) {
      CustomSnakeBar(context,
          text: 'You already logged in with Google, Try to login with google');
    }
  }
}
