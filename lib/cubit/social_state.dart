part of 'social_cubit.dart';

@immutable
abstract class SocialStates {}

class SocialInitialState extends SocialStates {}
class SocialGetUserSuccessState extends SocialStates {}
class SocialGetUserLoadingState extends SocialStates {}
class SocialGetUserErrorState extends SocialStates {
  final String error;
  SocialGetUserErrorState(this.error);
}
class SocialChangeBottomNavState extends SocialStates {}
class SocialNewPostState extends SocialStates {}

class SocialProfileImagePickedSuccessState extends SocialStates {}
class SocialProfileImagePickedErrorState extends SocialStates {}
class SocialCoverImagePickedSuccessState extends SocialStates {}
class SocialCoverImageErrorState extends SocialStates {}

class SocialUploadProfileImageSuccessState extends SocialStates {}
class SocialUploadProfileImageLoadingState extends SocialStates {}
class SocialUploadProfileImageErrorState extends SocialStates {}

class SocialUploadCoverImageSuccessState extends SocialStates {}
class SocialUploadCoverImageErrorState extends SocialStates {}


class SocialUserUpdateErrorState extends SocialStates {}
class SocialUserUpdateLoadingState extends SocialStates {}



//create posts

class SocialCreatePostLoadingState extends SocialStates {}
class SocialCreatePostSuccessState extends SocialStates {}
class SocialCreatePostErrorState extends SocialStates {}

class SocialPostImageSuccessState extends SocialStates {}
class SocialPostImageErrorState extends SocialStates {}

class SocialremoveImagepostSuccessState extends SocialStates {}
class SocialremoveImagepostErrorState extends SocialStates {}
class SocialLikepostSuccessState extends SocialStates {}
class SocialLikepostErrorState extends SocialStates {
  final String errMessage;
  SocialLikepostErrorState(this.errMessage);

}

class SocialGetPostsSuccessState extends SocialStates {}
class SocialGetPostsLoadingState extends SocialStates {}
class SocialGetPostsErrorState extends SocialStates {
  final String error;
  SocialGetPostsErrorState(this.error);
}



class SocialCommentPostSuccessState extends SocialStates {}
class SocialCommentPostLoadingState extends SocialStates {}
class SocialCommentPostErrorState extends SocialStates {
  final String error;
  SocialCommentPostErrorState(this.error);
}



class SocialGetAllUsersSuccessState extends SocialStates {}
class SocialGetAllUsersLoadingState extends SocialStates {}
class SocialGetAllUsersErrorState extends SocialStates {
  final String error;
  SocialGetAllUsersErrorState(this.error);
}