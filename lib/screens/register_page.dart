import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/screens/chat_page.dart';
import '../helper/Show_Snak_Bar.dart';
import '../widgets/const.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';

class Registerpage extends StatefulWidget {
  Registerpage({Key? key}) : super(key: key);
  static String id = "Register";

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  String? email;

  String? password;

  bool isloading = false;

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
                      "REGISTER",
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
                        await registeruser();
                        Navigator.pushNamed(context, chatpage.id);
                        //ShowSnakBar(context, 'The Register is Success ');
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          ShowSnakBar(
                              context, "the Paswword Provided is Too Weak");
                        } else if (e.code == "email-already-in-use") {
                          ShowSnakBar(
                              context, 'the Account Already Exists For users');
                        }
                      } catch (e) {
                        ShowSnakBar(context, 'Error Occured');
                      }
                      isloading = false;
                      setState(() {});
                    }
                  },
                  tittle: 'REGISTER',
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
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
                      child: Text(
                        "  Login",
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

  Future<void> registeruser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
    // print(user.user!.displayName);
  }
}
