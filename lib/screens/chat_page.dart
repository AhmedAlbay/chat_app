// ignore_for_file: camel_case_types, must_be_immutable, avoid_types_as_parameter_names, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/model/message.dart';
import 'package:scholar_chat/widgets/const.dart';
import '../widgets/chatBuble.dart';

class chatpage extends StatelessWidget {
  chatpage({Key? key}) : super(key: key);
  static String id = 'chatpage';
  final _controller = ScrollController();
  CollectionReference message =
      FirebaseFirestore.instance.collection(kMessageCollections);
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: message.orderBy(kCreatedAt, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagelist = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagelist.add(Message.fromJson(snapshot.data!.docs[i]));
          }
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
                  child: ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemCount: messagelist.length,
                      itemBuilder: (context, Index) {
                        return messagelist[Index].id == email
                            ? chatBuble(
                                message: messagelist[Index],
                              )
                            : chatBubleForFriend(
                                message: messagelist[Index],
                              );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      message.add({
                        'message': data,
                        kCreatedAt: DateTime.now(),
                        'id': email,
                      });
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
                          child: Icon(Icons.send, color: KPrimlycolor),
                          onPressed: () {
                            // Handle send button press here
                            String data = controller.text;
                            message.add({
                              'message': data,
                              kCreatedAt: DateTime.now(),
                              'id': email,
                            });
                            // Implement your send message logic
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
        } else {
          return const Text('Loading.....');
        }
      },
    );
  }

  void sendMessage(String data) {
    // Implement your send message logic here
    controller.clear();
  }
}
