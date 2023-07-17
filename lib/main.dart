import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/screens/chat_page.dart';
import 'package:scholar_chat/screens/cubits/cubit/chat_cubit.dart';
import 'package:scholar_chat/screens/cubits/cubit_login/login_cubit.dart';
import 'package:scholar_chat/screens/cubits/cubit_register/register_cubit.dart';
import 'package:scholar_chat/screens/login_page.dart';
import 'package:scholar_chat/screens/register_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(),
        ),
        BlocProvider(
          create: (context) => ChatCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          LoginPage.id: (context) => LoginPage(),
          RegisterPage.id: (context) => RegisterPage(),
          chatpage.id: (context) => chatpage(),
        },
        initialRoute: LoginPage.id,
      ),
    );
  }
}
