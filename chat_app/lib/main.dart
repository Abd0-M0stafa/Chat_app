import 'package:chat_app/cubits/login/login_cubit.dart';
import 'package:chat_app/cubits/register/register_cubit.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/views/welcomeView.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (BuildContext context) => LoginCubit(),
        ),
        BlocProvider<RegisterCubit>(
          create: (BuildContext context) => RegisterCubit(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: const WelcomeView(),
      ),
    );
  }
}
