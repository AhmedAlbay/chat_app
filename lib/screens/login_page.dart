import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/screens/chat_page.dart';
import 'package:scholar_chat/screens/register_page.dart';
import 'package:scholar_chat/widgets/custom_button.dart';
import 'package:scholar_chat/widgets/custom_textfield.dart';

import '../helper/Show_Snak_Bar.dart';
import '../widgets/const.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key});
  static String id = "Login";
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isloading = false;
  String? email;
  String? password;
  GlobalKey<FormState> formkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Scaffold(
        backgroundColor: KPrimlycolor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formkey,
            child: ListView(
              children: [
                SizedBox(
                  height: 75,
                ),
                Image.asset(
                  klog,
                  height: 100,
                ),
                Row(
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
                SizedBox(
                  height: 75,
                ),
                Row(
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
                SizedBox(
                  height: 20,
                ),
                textformfield(
                  onchanged: (data) {
                    email = data;
                  },
                  hinttext: 'Email',
                ),
                SizedBox(
                  height: 10,
                ),
                textformfield(
                  onchanged: (data) {
                    password = data;
                  },
                  hinttext: 'Password',
                ),
                SizedBox(
                  height: 20,
                ),
                button(
                  onTap: () async {
                    if (formkey.currentState!.validate()) {
                      isloading = true;
                      setState(() {});
                      try {
                        await loginuser();
                        Navigator.pushNamed(context, chatpage.id);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'wrong-password') {
                          ShowSnakBar(
                              context, "The Paswword Provided is Wrong");
                        } else if (e.code == "user-not-found") {
                          ShowSnakBar(context, 'User-Not-Found');
                        }
                      } catch (e) {
                        ShowSnakBar(context, 'Error Occured');
                      }
                      isloading = false;
                      setState(() {});
                    }
                  },
                  tittle: 'LOGIN',
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "don\'t have any account",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Registerpage.id);
                      },
                      child: Text(
                        "  Register",
                        style:
                            TextStyle(fontSize: 15, color: Color(0xffC7EDE6)),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 75,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginuser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
    // print(user.user!.displayName);
  }
}
