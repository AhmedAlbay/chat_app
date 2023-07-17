// ignore_for_file: empty_catches

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:scholar_chat/model/message.dart';

import '../../../widgets/const.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference message =
      FirebaseFirestore.instance.collection(kMessageCollections);
  List<Message> messageslist = [];
  void sendMessage({required String messages, required String email}) {
    try {
      message.add({
        'message': messages,
        kCreatedAt: DateTime.now(),
        'id': email,
      });
    } catch (e) {}
  }

  void getMessage() {
    message.orderBy(kCreatedAt, descending: true).snapshots().listen((event) {
      messageslist.clear();
      for (var doc in event.docs) {
        messageslist.add(Message.fromJson(doc));
      }

      emit(ChatSuccess(messages: messageslist));
    });
  }
}
