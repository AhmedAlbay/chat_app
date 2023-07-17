import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LoginLoading());
        // ignore: unused_local_variable

        try {
          // ignore: unused_local_variable
          UserCredential user = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: event.email, password: event.password);
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
    });
  }
}
