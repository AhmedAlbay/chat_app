// ignore_for_file: camel_case_types, must_be_immutable, avoid_types_as_parameter_names, non_constant_identifier_names, dead_code

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/model/message.dart';
import 'package:scholar_chat/screens/cubits/cubit/chat_cubit.dart';
import 'package:scholar_chat/widgets/const.dart';
import '../widgets/chatBuble.dart';

class chatpage extends StatelessWidget {
  chatpage({Key? key}) : super(key: key);
  static String id = 'chatpage';

  List<Message> messageslist = [];
  final _controller = ScrollController();
  CollectionReference message =
      FirebaseFirestore.instance.collection(kMessageCollections);
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: KPrimlycolor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              klog,
              height: 50,
            ),
            const Text('Chat'),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                var messageslist =
                    BlocProvider.of<ChatCubit>(context).messageslist;

                return BlocBuilder<ChatCubit, ChatState>(
                  builder: (context, state) {
                    return ListView.builder(
                        reverse: true,
                        controller: _controller,
                        itemCount: messageslist.length,
                        itemBuilder: (context, Index) {
                          return messageslist[Index].id == email
                              ? chatBuble(
                                  message: messageslist[Index],
                                )
                              : chatBubleForFriend(
                                  message: messageslist[Index],
                                );
                        });
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller,
              onSubmitted: (data) {
                BlocProvider.of<ChatCubit>(context)
                    .sendMessage(messages: data, email: AutofillHints.email);

                // Implement your send message logic

                controller.clear();
                _controller.animateTo(
                  0,
                  duration: const Duration(seconds: 2),
                  curve: Curves.fastOutSlowIn,
                );
              },
              decoration: InputDecoration(
                hintText: 'send message',
                suffixIcon: CupertinoButton(
                    child: const Icon(Icons.send, color: KPrimlycolor),
                    onPressed: () {
                      String data = controller.text;

                      BlocProvider.of<ChatCubit>(context).sendMessage(
                          messages: data, email: AutofillHints.email);
                      sendMessage(data);
                    }),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: KPrimlycolor)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void sendMessage(String data) {
    // Implement your send message logic here
    controller.clear();
  }
}
