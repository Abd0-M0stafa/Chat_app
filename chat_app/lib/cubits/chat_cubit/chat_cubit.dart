import 'package:bloc/bloc.dart';
import 'package:chat_app/models/messagesModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  void sendMessage({required String message, required String email}) {
    try {
      messages.add(
        {
          'message': message,
          'createdAt': DateTime.now(),
          'id': email,
        },
      );
    } on Exception catch (e) {
      print(e);
    }
  }

  void getMessages() {
    emit(ChatLoading());
    messages.orderBy('createdAt', descending: true).snapshots().listen((event) {
      List<MessageModel> messageList = [];
      for (var doc in event.docs) {
        messageList.add(MessageModel.fromJson(doc));
      }
      emit(ChatSuccess(messages: messageList));
    });
  }
}
