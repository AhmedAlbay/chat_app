import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/screens/chat_page.dart';
import 'package:scholar_chat/screens/login_page.dart';
import 'package:scholar_chat/screens/register_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(ScholarChat());
}

class ScholarChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginPage.id: (context) => LoginPage(),
        Registerpage.id: (context) => Registerpage(),
         chatpage.id:(context) => chatpage(),
      },
      initialRoute: LoginPage.id,
    );
  }
}
