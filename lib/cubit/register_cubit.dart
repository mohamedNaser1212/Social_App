import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../states/register_states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool obsecurePassword = true;

  void changePasswordVisibility() {
    obsecurePassword = !obsecurePassword;
    emit(RegisterChangePasswordVisibilityState());
  }

  UserModel user = UserModel();

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      emit(RegisterSuccessState(value.user!.uid));
      print(value.user!.email);
      print(value.user!.uid);
      userCreate(
        name: name,
        email: email,
        password: password,
        phone: phone,
        uId: value.user!.uid,
      );
    }).catchError((error) {
      if (error is FirebaseAuthException) {
        if (error.code == 'weak-password') {
          emit(RegisterErrorState(error: 'كلمه السر ضعيفه',));
        } else if (error.code == 'email-already-in-use') {
          emit(RegisterErrorState(error: 'هذا البريد الالكتروني مسجل بالفعل'));
        } else {
          emit(RegisterErrorState(error: 'حدث خطأ ما,حاول مره اخري'));
        }
      } else {
        emit(RegisterErrorState(error: 'An error occurred: $error'));
      }
      print(error.toString());
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String uId,
    required String phone,
    required String password,
  }) {
    emit(CreateUserLoadingState());
    user = UserModel(
      name: name,
      uId: uId,
      password: password,
      email: email,
      phone: phone,
      image:'https://img.freepik.com/free-'
          'photo/waist-up-portrait-handsome-se'
          'rious-unshaven-male-keeps-hands-together'
          '-dressed-dark-blue-shirt-has-talk-with-in'
          'terlocutor-stands-against-white-wall-self-con'
          'fident-man-freelancer_273609-16320.jpg?size=626&ext'
          '=jpg&ga=GA1.2.301778392.1693810324&semt=sph&client=explore&cb=fp',
      isEmailVerified: false,
     // image: uploadedProfileImageLink,
      cover: 'https://img.freepik.com/free-'
          'photo/waist-up-portrait-handsome-se'
          'rious-unshaven-male-keeps-hands-together'
          '-dressed-dark-blue-shirt-has-talk-with-in'
          'terlocutor-stands-against-white-wall-self-con'
          'fident-man-freelancer_273609-16320.jpg?size=626&ext'
          '=jpg&ga=GA1.2.301778392.1693810324&semt=sph&client=explore&cb=fp',
      bio: 'write your bio ...',
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(user.toMap())
        .then((value) {
      emit(CreateUserSuccessState());
    }).catchError((onError) {
      emit(CreateUserErrorState());
      print(onError.toString());
    });
  }

  int selectedRadioValue = 1;

  void changeRadioValue(int value) {
    selectedRadioValue = value;
    emit(RegisterChangeRadioValueState());
  }

  bool showEmailField = true;

  void changeEmailFieldState(bool value) {
    showEmailField = value;
    emit(RegisterChangeRadioValueState());
  }
}
  // File? profileImage;
  // final picker = ImagePicker();
  //
  // Future getProfileImage() async {
  //   var pickedImage = await picker.pickImage(
  //     source: ImageSource.gallery,
  //   );
  //   if(pickedImage !=null){
  //     profileImage=File(pickedImage.path);
  //     emit(RegisterChangeImageProfileSuccessState());
  //   }else{
  //     emit(RegisterChangeImageProfileErrorState());
  //     print('error');
  //   }
  // }

//   String uploadedProfileImageLink='';
//
//   Future uploadProfileImage() async {
//     emit(RegisterUploadImageProfileLoadingState());
//     firebase_storage.FirebaseStorage storage =
//         firebase_storage.FirebaseStorage.instance;
//     firebase_storage.Reference ref = storage.ref().child('users/${Uri.file(profileImage!.path).pathSegments.last}');
//     firebase_storage.UploadTask uploadTask = ref.putFile(profileImage!);
//     await uploadTask.whenComplete(() async {
//       uploadedProfileImageLink = await ref.getDownloadURL();
//       emit(RegisterUploadImageProfileSuccessState());
//     });
//   }
//
//
//   bool showImagePicker=false;
//
//   void changeShowImagePicker(){
//     showImagePicker=!showImagePicker;
//     emit(RegisterShowImagePickerChangedState());
//   }
// }
