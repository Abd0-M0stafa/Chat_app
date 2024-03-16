// ignore_for_file: unused_local_variable, use_build_context_synchronously

import 'package:chat_app/Helper/CustomSnakeBar.dart';
import 'package:chat_app/views/chatView.dart';
import 'package:chat_app/views/loginView.dart';
import 'package:chat_app/widgets/customTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

// ignore: must_be_immutable.
class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool isloading = false;

  String? email;

  String? password;

  bool isShown = true;
  bool isShown2 = true;

  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();

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
                      'Create Account',
                      style: TextStyle(
                          color: Color.fromARGB(255, 28, 228, 167),
                          fontSize: 35,
                          fontFamily: 'BebasNeue'),
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    'Create an account so you can explore \nall the existing jobs',
                    style: TextStyle(
                        color: Color.fromARGB(255, 219, 227, 225),
                        fontSize: 20,
                        fontFamily: 'BebasNeue'),
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
                CustomTextField(
                  controller: controller,
                  validator: (value) {
                    email = value;
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Email';
                    } else if (RegExp(
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                        .hasMatch(value)) {
                      return null;
                    }
                    return 'Invalid Email';
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
                    password = value;
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Password';
                    }
                    if (value.length < 9) {
                      return 'The minimum password length is 9';
                    } else if (RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                        .hasMatch(value)) {
                      return null;
                    }
                    return 'Your password must contains Uppercase,\nLowercase, Special characters and Numbers';
                  },
                  onChanged: (data) {
                    password = data;
                  },
                  text: 'Password',
                ),
                CustomTextField(
                  obscureText: isShown2,
                  suffixIcon: isShown2
                      ? Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: IconButton(
                            color: const Color.fromARGB(255, 197, 192, 192),
                            icon: const Icon(Icons.visibility_off),
                            onPressed: () {
                              isShown2 = false;
                              setState(() {});
                            },
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: IconButton(
                            color: Color(0xffcd3a6c),
                            icon: const Icon(Icons.visibility),
                            onPressed: () {
                              isShown2 = true;
                              setState(() {});
                            },
                          ),
                        ),
                  controller: controller3,
                  validator: (value) {
                    password = value;
                    if (value == null || value.isEmpty) {
                      return 'Please enter the Password to confirm';
                    } else if (value != controller2.text) {
                      return 'Not Matching password';
                    }
                  },
                  onChanged: (data) {},
                  text: 'Confirm Password',
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
                            .createUserWithEmailAndPassword(
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
                        if (e.code == 'email-already-in-use') {
                          CustomSnakeBar(context,
                              text: 'the email already used');
                        } else if (e.code == 'weak-password') {
                          CustomSnakeBar(context,
                              text: 'The password is too weak.');
                        } else {
                          CustomSnakeBar(context,
                              text:
                                  'An error occurred. Please try again later.');
                        }
                      }

                      isloading = false;
                      setState(() {});
                      controller.clear();
                      controller2.clear();
                    }
                  },
                  child: const Text(
                    'Register',
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
                      'already have an account?',
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const LoginView(),
                          ),
                        );
                      },
                      child: const Text(
                        'Login',
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
