import 'package:scholar_chat/widgets/const.dart';

class Message {
  final String message;
  Message(this.message);

  factory Message.fromJson(jsonData) {
    return Message(jsonData[kMessage]);
  }
}
