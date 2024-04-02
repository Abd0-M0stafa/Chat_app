// ignore_for_file: unused_local_variable, use_build_context_synchronously

import 'package:chat_app/Helper/CustomSnakeBar.dart';
import 'package:chat_app/cubits/auth_cubit/auth_cubit.dart';
import 'package:chat_app/views/chatView.dart';
import 'package:chat_app/views/registerView.dart';
import 'package:chat_app/widgets/customTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginLoading ||
            state is SignWithGoogleLoading ||
            state is SignWithFacebookLoading) {
          isloading = true;
        } else if (state is LoginSuccess ||
            state is SignWithGoogleSuccess ||
            state is SignWithFacebookSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => ChatView(
                email: email,
              ),
            ),
          );
          isloading = false;
        } else if (state is LoginFailure ||
            state is SignWithGoogleFailure ||
            state is SignWithFacebookFailure) {
          CustomSnakeBar(context, text: 'Theere was an error');
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
                        return null;
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
                          return 'Please enter your password';
                        }
                        return null;
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
                        backgroundColor:
                            const Color.fromARGB(255, 28, 228, 167),
                      ),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<AuthCubit>(context)
                              .loginUser(email: email!, password: password!);

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
