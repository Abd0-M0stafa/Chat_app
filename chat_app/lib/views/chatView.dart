import 'package:chat_app/models/messagesModel.dart';
import 'package:chat_app/widgets/FirstchatMessage.dart';
import 'package:chat_app/widgets/secondChatMessage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class ChatView extends StatelessWidget {
  ChatView({super.key, this.email});

  // ignore: prefer_typing_uninitialized_variables
  var email;
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();

  String? finalMessage;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy('createdAt', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<MessageModel> messageList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messageList.add(MessageModel.fromJson(snapshot.data!.docs[i]));
          }
          return Scaffold(
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
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: scrollController,
                    physics: const BouncingScrollPhysics(),
                    itemCount: messageList.length,
                    itemBuilder: (context, index) {
                      return messageList[index].id == email
                          ? ChatMessage(
                              message: messageList[index],
                            )
                          : SecondChatMessage(
                              message: messageList[index],
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
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 197, 192, 192)),
                      suffixIcon: IconButton(
                        onPressed: () {
                          messages.add(
                            {
                              'message': finalMessage,
                              'createdAt': DateTime.now(),
                              'id': email,
                            },
                          );
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
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Color.fromARGB(255, 28, 228, 167),
            ),
          );
        }
      },
    );
  }
}
