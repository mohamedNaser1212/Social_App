import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../states/login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccessState(userCredential.user!.uid));
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'something went wrong';
      if (e.code == 'user-not-found') {
        emit(LoginErrorState(error:'email already in use'));
      } else if (e.code == 'wrong-password') {
        emit(LoginErrorState(error: 'wrong-password'));
      }else if(e.code == 'invalid-email') {
        emit(LoginErrorState(error: 'email is invalid'))  ;
      }else{
        emit(LoginErrorState(error:errorMessage));
      }

      print(e.toString());
    } catch (e) {
      emit(LoginErrorState(error: ' something went wrong',  ));
      print(e.toString());
    }
  }
}