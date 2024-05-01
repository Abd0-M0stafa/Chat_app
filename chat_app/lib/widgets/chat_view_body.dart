import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/models/messagesModel.dart';
import 'package:chat_app/widgets/FirstchatMessage.dart';
import 'package:chat_app/widgets/secondChatMessage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBody extends StatefulWidget {
  const ChatBody({super.key, required this.email});

  final String email;

  @override
  State<ChatBody> createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  TextEditingController controller = TextEditingController();

  ScrollController scrollController = ScrollController();

  List<MessageModel> messageList = [];

  String? finalMessage;

  bool isFound = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BlocConsumer<ChatCubit, ChatState>(
            listener: (context, state) {
              if (state is ChatSuccess) {
                messageList = state.messages;
              }
            },
            builder: (context, state) {
              return ListView.builder(
                reverse: true,
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                itemCount: messageList.length,
                itemBuilder: (context, index) {
                  return messageList[index].id == widget.email
                      ? ChatMessage(
                          message: messageList[index],
                        )
                      : SecondChatMessage(
                          message: messageList[index],
                        );
                },
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: TextField(
            style: const TextStyle(
              color: Color.fromARGB(255, 28, 228, 167),
            ),
            cursorColor: const Color.fromARGB(255, 28, 228, 167),
            controller: controller,
            onChanged: (data) {
              finalMessage = data;
            },
            decoration: InputDecoration(
              hintText: 'Message',
              hintStyle:
                  const TextStyle(color: Color.fromARGB(255, 197, 192, 192)),
              suffixIcon: IconButton(
                onPressed: () {
                  BlocProvider.of<ChatCubit>(context)
                      .sendMessage(message: finalMessage!, email: widget.email);
                  controller.clear();
                  scrollController.animateTo(0,
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeIn);
                },
                icon: const Icon(
                  Icons.send,
                  color: Color.fromARGB(255, 28, 228, 167),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(color: Colors.white)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 28, 228, 167),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
