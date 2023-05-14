import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/model/message.dart';
import 'package:scholar_chat/widgets/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/chatBuble.dart';
import 'package:flutter/src/widgets/scroll_controller.dart';

class chatpage extends StatelessWidget {
  chatpage({Key? key}) : super(key: key);
  static String id = 'chatpage';
  final  _controller= ScrollController();
  CollectionReference message =
      FirebaseFirestore.instance.collection(kMessageCollections);
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: message.orderBy(kCreatedAt,descending:true).snapshots(),
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
                  Text('Chat'),
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
                        return chatBuble(
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
                      });
                      controller.clear();
                      _controller.animateTo(
                        0,
                        duration: Duration(seconds: 2),
                        curve: Curves.fastOutSlowIn,
                      );
                    },
                    decoration: InputDecoration(
                      hintText: 'send message',
                      suffixIcon: Icon(
                        Icons.send,
                        color: KPrimlycolor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: KPrimlycolor)),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Text('Loading.....');
        }
      },
    );
  }
}
