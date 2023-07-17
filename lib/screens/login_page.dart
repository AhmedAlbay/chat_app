// ignore_for_file: unnecessary_string_escapes, must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/screens/chat_page.dart';
import 'package:scholar_chat/screens/cubits/cubit/chat_cubit.dart';
import 'package:scholar_chat/screens/cubits/cubit_login/login_cubit.dart';
import 'package:scholar_chat/screens/register_page.dart';
import 'package:scholar_chat/widgets/custom_button.dart';
import 'package:scholar_chat/widgets/custom_textfield.dart';

import '../helper/Show_SnakBar.dart';
import '../widgets/const.dart';

class LoginPage extends StatelessWidget {
  bool isloading = false;
  static String id = "Login";
  String? email;
  String? password;
  GlobalKey<FormState> formkey = GlobalKey();

  LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isloading = true;
        } else if (state is LoginSuccess) {
          BlocProvider.of<ChatCubit>(context).getMessage();
          Navigator.pushNamed(context, chatpage.id, arguments: email);
          isloading = false;
        } else if (state is LoginFailure) {
          ShowSnakBar(context, state.errMessage);
          isloading = false;
        }
      },
      child: ModalProgressHUD(
        inAsyncCall: isloading,
        child: Scaffold(
          backgroundColor: KPrimlycolor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Form(
              key: formkey,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 75,
                  ),
                  Image.asset(
                    klog,
                    height: 100,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Scholar Chat",
                        style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontFamily: 'Pacifico'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 75,
                  ),
                  const Row(
                    children: [
                      Text(
                        "LOGIN",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  textformfield(
                    onchanged: (data) {
                      email = data;
                    },
                    hinttext: 'Email',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  textformfield(
                    obscureText: true,
                    onchanged: (data) {
                      password = data;
                    },
                    hinttext: 'Password',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  button(
                    onTap: () async {
                      if (formkey.currentState!.validate()) {
                        BlocProvider.of<LoginCubit>(context)
                            .loginuser(email: email!, password: password!);
                      } else {}
                    },
                    tittle: 'LOGIN',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "don\'t have any account",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RegisterPage.id);
                        },
                        child: const Text(
                          "  Register",
                          style:
                              TextStyle(fontSize: 15, color: Color(0xffC7EDE6)),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 75,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginuser() async {
    // ignore: unused_local_variable
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
    // print(user.user!.displayName);
  }
}
