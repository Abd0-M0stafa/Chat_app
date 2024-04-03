import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/widgets/chat_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ChatView extends StatelessWidget {
  const ChatView({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit()..getMessages(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(115, 15, 15, 15),
          title: const Center(
            child: Text(
              '- CHAT APP -',
              style: TextStyle(
                color: Color.fromARGB(255, 28, 228, 167),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        body: ChatBody(email: email),
      ),
    );
  }
}
