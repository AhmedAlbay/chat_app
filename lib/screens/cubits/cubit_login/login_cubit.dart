import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
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
