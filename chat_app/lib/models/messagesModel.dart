class MessageModel {
  final String message;
  // ignore: prefer_typing_uninitialized_variables
  var id;

  MessageModel(this.message, this.id);

  factory MessageModel.fromJson(jsonData) {
    return MessageModel(jsonData['message'], jsonData['id']);
  }
}
