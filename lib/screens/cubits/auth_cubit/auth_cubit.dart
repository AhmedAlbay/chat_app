// ignore_for_file: unused_local_variable, duplicate_ignore

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  Future<void> registeruser(
      {required String email, required String password}) async {
    emit(RegisterLoading());

    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailure(errMessage: 'Weak Password'));
      } else if (e.code == "email-already-in-use") {
        emit(RegisterFailure(errMessage: 'email-already-in-use'));
      }
    } catch (e) {
      emit(RegisterFailure(errMessage: "Something Went Wrong"));
    }
  }
   Future<void> loginuser(
      {required String email, required String password}) async {
    emit(LoginLoading());
    // ignore: unused_local_variable

    try {
      // ignore: unused_local_variable
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess());
      // print(user.user!.displayName);
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'user-not-found') {
        emit(LoginFailure(errMessage: 'User Not Found'));
      } else if (ex.code == 'wrong-password') {
        emit(LoginFailure(errMessage: 'Wrong Password'));
      }
    } catch (e) {
      emit(LoginFailure(errMessage: 'There Was An Error'));
    }
  }
}
