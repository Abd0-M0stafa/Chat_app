import 'package:chat_app/models/messagesModel.dart';
import 'package:flutter/material.dart';

class SecondChatMessage extends StatelessWidget {
  const SecondChatMessage({super.key, required this.message});
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          color: Color.fromARGB(255, 55, 168, 134),
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
