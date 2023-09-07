import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:social_app/models/posts_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/screens/chats_screen.dart';
import 'package:social_app/screens/feeds_screen.dart';
import 'package:social_app/screens/new_posts_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../constant.dart';
import '../screens/settings_screen.dart';
import '../screens/users_screen.dart';

part 'social_state.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());
  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel? usermodel;
  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      usermodel = UserModel.fromJson(value.data());

      emit(SocialGetUserSuccessState());
    }).catchError((onError) {
      emit(SocialGetUserErrorState(onError.toString()));
      print(onError.toString());
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostsScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];
  List<String> titles = [
    'Home',
    'Chats',
    'Posts',
    'Users',
    'Settings',
  ];
  void changeBottomNav(int index) {
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;

      emit(SocialChangeBottomNavState());
    }
  }

  File? profileImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? CoverImage;
  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      CoverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      emit(SocialCoverImageErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);

        // emit(SocialUploadProfileImageSuccessState());
        UpdateUser(image: value, name: name, phone: phone, bio: bio);
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  //make the updateuser function

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(CoverImage!.path).pathSegments.last}')
        .putFile(CoverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        UpdateUser(name: name, phone: phone, bio: bio, cover: value);
        print(value);

        //  emit(SocialUploadCoverImageSuccessState());
        //updateUser(image: value);
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

  // void updateUserImages({
  //   required String name,
  //   required String phone,
  //   required String bio,
  // }) {
  //   emit(SocialUserUpdateLoadingState());
  //   if (CoverImage != null) {
  //     uploadCoverImage();
  //   } else if (profileImage != null) {
  //     uploadProfileImage();
  //   } else if (CoverImage != null && profileImage != null){
  //
  //
  //   }else {
  //     UpdateUser(
  //       name: name,
  //       phone: phone,
  //       bio: bio,
  //     );
  //   }
  // }

  void UpdateUser({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }) {
    UserModel user = UserModel(
      name: name,
      uId: usermodel?.uId,
      phone: phone,
      email: usermodel!.email,
      cover: cover ?? usermodel!.cover,
      image: image ?? usermodel!.image,
      isEmailVerified: false,
      bio: bio,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(usermodel!.uId)
        .update(user.toMap())
        .then((value) {
      getUserData();
    }).catchError((onError) {
      emit(SocialUserUpdateErrorState());
    });
  }

  File? PostImage;
  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      PostImage = File(pickedFile.path);
      emit(SocialPostImageSuccessState());
    } else {
      emit(SocialPostImageErrorState());
    }
  }

  void removePostImage() {
    PostImage == null;
    print(profileImage);
    emit(SocialremoveImagepostSuccessState());
    PostImage = null;
  }

  void UploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(SocialCreatePostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(PostImage!.path).pathSegments.last}')
        .putFile(PostImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        CreatePost(dateTime: dateTime, text: text, postImage: value);
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
      PostImage = null;
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void CreatePost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingState());
    PostModel model = PostModel(
      name: usermodel?.name,
      uId: usermodel?.uId,
      image: usermodel?.image,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
      PostImage = null;
    }).catchError((onError) {
      emit(SocialCreatePostErrorState());
    });
  }

  // File? PostImage;
  // Future<void> getPostImage() async {
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     PostImage = File(pickedFile.path);
  //     emit(SocialPostImageSuccessState());
  //   } else {
  //     emit(SocialPostImageErrorState());
  //   }
  // }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  void getPosts() {
    emit(SocialGetPostsLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        // element.id;
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        }).catchError((onError) {
          emit(SocialGetPostsErrorState(onError.toString()));
        });

      });
      emit(SocialGetPostsSuccessState());
    }).catchError((onError) {
      emit(SocialGetPostsErrorState(onError.toString()));
    });
  }

  // List<PostModel> posts = [];
  // List<String> postsId = [];
  // List<int> likes = [];
  // List<int> comments = [];
  // void likePost(String postId){
  //   FirebaseFirestore.instance.collection('posts').doc(postId).collection('likes').doc(uId).set({
  //     'like':true,
  //   }).then((value) {
  //     emit(SocialLikePostSuccessState());
  //   }).catchError((onError){
  //     emit(SocialLikePostErrorState(onError.toString()));
  //   });
  // }
  // void dislikePost(String postId){
  //   FirebaseFirestore.instance.collection('posts').doc(postId).collection('likes').doc(uId).delete().then((value) {
  //     emit(SocialDislikePostSuccessState());
  //   }).catchError((onError){
  //     emit(SocialDislikePostErrorState(onError.toString()));
  //   });
  // }

  List<int>comments=[];
  void commentPost(String postId,String comment){
    FirebaseFirestore.instance.collection('posts').doc(postId).collection('comments').doc().set({
      'comment':comment,
      'uId':uId,
      'name':usermodel?.name,
      'image':usermodel?.image,
    }).then((value) {
      emit(SocialCommentPostSuccessState());
    }).catchError((onError){
      emit(SocialCommentPostErrorState(onError.toString()));
    });
  }
  void getComments(String postId){
    FirebaseFirestore.instance.collection('posts').doc(postId).collection('comments').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('comments').get().then((value) {
          comments.add(value.docs.length);
        });


        print(element.data());
      });
    });
  }
  // List<UserModel> users = [];
  // void getAllUsers(){
  //   FirebaseFirestore.instance.collection('users').get().then((value) {
  //     value.docs.forEach((element) {
  //       if(element.data()['uId']!=uId){
  //         users.add(UserModel.fromJson(element.data()));
  //       }
  //     });
  //     emit(SocialGetAllUsersSuccessState());
  //   }).catchError((onError){
  //     emit(SocialGetAllUsersErrorState(onError.toString()));
  //   });
  void LikePosts(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(usermodel!.uId)
        .set({
      'likes': true,
    }).then((value) {
      emit(SocialLikepostSuccessState());
    }).catchError((error) {
      emit(SocialLikepostErrorState(error.toString()));
    });
  }
// void dislikePost(String postId){
//   FirebaseFirestore.instance.collection('posts').doc(postId).collection('likes').doc(uId).delete().then((value) {
//     emit(SocialDislikePostSuccessState());
//   }).catchError((onError){
//     emit(SocialDislikePostErrorState(onError.toString()));
//   });
// }

List<UserModel> users = [];
void getAllUsers() {
  FirebaseFirestore.instance.collection('users').get().then((value) {
    value.docs.forEach((element) {
      if (element.data()['uId'] != uId) {
        users.add(UserModel.fromJson(element.data()));
      }
    });
    emit(SocialGetAllUsersSuccessState());
  }).catchError((onError) {
    emit(SocialGetAllUsersErrorState(onError.toString()));
  });
}
}
