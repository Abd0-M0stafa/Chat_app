import 'package:chat_app/models/messagesModel.dart';
import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({super.key, required this.message});
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
          color: Color.fromARGB(255, 28, 228, 167),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            message.message,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
