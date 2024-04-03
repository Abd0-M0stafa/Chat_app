import 'package:chat_app/Helper/CustomSnakeBar.dart';
import 'package:chat_app/cubits/auth_cubit/auth_cubit.dart';
import 'package:chat_app/views/chatView.dart';
import 'package:chat_app/views/loginView.dart';
import 'package:chat_app/widgets/customTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

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
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterLoading ||
            state is SignWithGoogleLoading ||
            state is SignWithFacebookLoading) {
          isloading = true;
        } else if (state is RegisterSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => ChatView(
                email: email!,
              ),
            ),
          );
          isloading = false;
        } else if (state is SignWithGoogleSuccess) {
          email = state.email;
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => ChatView(
                email: email!,
              ),
            ),
          );
          isloading = false;
        } else if (state is SignWithFacebookSuccess) {
          email = state.email;
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => ChatView(
                email: email!,
              ),
            ),
          );
          isloading = false;
        } else if (state is ResgisterFailure ||
            state is SignWithGoogleFailure ||
            state is SignWithFacebookFailure) {
          CustomSnakeBar(context, text: 'There was an error');
          isloading = false;
        }
      },
      builder: (context, state) {
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
                      height: 55,
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
                    const SizedBox(
                      height: 30,
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
                                color: const Color.fromARGB(255, 28, 228, 167),
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
                        return null;
                      },
                      onChanged: (data) {},
                      text: 'Confirm Password',
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 28, 228, 167),
                      ),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<AuthCubit>(context)
                              .regeterUser(email: email!, password: password!);
                          controller.clear();
                          controller2.clear();
                          controller3.clear();
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
                      height: 10,
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
                            onPressed: () async {
                              await BlocProvider.of<AuthCubit>(context)
                                  .signInWithGoogle();
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
                            onPressed: () async {
                              await BlocProvider.of<AuthCubit>(context)
                                  .signInWithFacebook();
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
      },
    );
  }
}
