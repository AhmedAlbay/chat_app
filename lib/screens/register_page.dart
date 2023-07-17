// ignore_for_file: must_be_immutable, avoid_types_as_parameter_names, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/screens/chat_page.dart';
import 'package:scholar_chat/screens/cubits/cubit_register/register_cubit.dart';
import '../helper/Show_SnakBar.dart';
import '../widgets/const.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';

class RegisterPage extends StatelessWidget {
  String? email;
  static String id = "Register";
  String? password;

  bool isloading = false;

  GlobalKey<FormState> formkey = GlobalKey();

  RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isloading = true;
        } else if (state is RegisterSuccess) {
          Navigator.pushNamed(context, chatpage.id, arguments: email);
          isloading = false;
        } else if (state is RegisterFailure) {
          ShowSnakBar(context, state.errMessage);
          isloading = false;
        }
      },
      builder: (context, State) =>ModalProgressHUD(
        inAsyncCall: isloading,
        child: Scaffold(
          backgroundColor: KPrimlycolor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Form(
              key: formkey,
              child: ListView(
                children: [
                  // ignore: prefer_const_constructors
                  SizedBox(
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
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        "REGISTER",
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
                        BlocProvider.of<RegisterCubit>(context)
                            .registeruser(email: email!, password: password!);
                      } else {}
                    },
                    tittle: 'REGISTER',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "have already account",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "  Login",
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

  Future<void> registeruser() async {
    // ignore: unused_local_variable
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
    // print(user.user!.displayName);
  }
}
