import '../../models/user_model.dart';

abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class SocialGetUserLoadingState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates {
  final String error;
  SocialGetUserErrorState(this.error);
}

class SocialGetUserDataSuccessState extends SocialStates {}

class SocialGetUserDataErrorState extends SocialStates {
  final String error;
  SocialGetUserDataErrorState(this.error);
}

class SocialChangeBottomNavState extends SocialStates {}

class SocialNewPostsState extends SocialStates {}

class SocialProfileImagePickedSuccessState extends SocialStates {}

class SocialProfileImagePickedErrorState extends SocialStates {}

class SocialCoverImagePickedSuccessState extends SocialStates {}

class SocialCoverImagePickedErrorState extends SocialStates {}

class SocialProfileImageUploadSuccessState extends SocialStates {}

class SocialProfileImageUploadErrorState extends SocialStates {}

class SocialCoverImageUploadSuccessState extends SocialStates {}

class SocialCoverImageUploadErrorState extends SocialStates {}

class SocialUserUpdateErrorState extends SocialStates {}

class SocialUserUpdateLoadingState extends SocialStates {}

class SocialUploadPostLoadingState extends SocialStates {}

class SocialUploadPostSuccessState extends SocialStates {}

class SocialUploadPostErrorState extends SocialStates {}

class SocialPostImagePickedSuccessState extends SocialStates {}

class SocialPostImagePickedErrorState extends SocialStates {}

class SocialRemovePostImageSuccessState extends SocialStates {}

class SocialGetPostLoadingState extends SocialStates {}

class SocialGetPostSuccessState extends SocialStates {}

class SocialGetPostErrorState extends SocialStates {
  final String error;
  SocialGetPostErrorState(this.error);
}

class SocialLikePostSuccessState extends SocialStates {}

class SocialLikePostErrorState extends SocialStates {
  final String error;
  SocialLikePostErrorState(this.error);
}

class SocialCommentPostLoadingState extends SocialStates {}

class SocialCommentPostSuccessState extends SocialStates {}

class SocialCommentPostErrorState extends SocialStates {
  final String error;
  SocialCommentPostErrorState(this.error);
}

class SocialGetCommentLoadingState extends SocialStates {}

class SocialGetCommentSuccessState extends SocialStates {
  late String PostId;
  SocialGetCommentSuccessState(this.PostId);
}

class SocialGetCommentErrorState extends SocialStates {
  final String error;
  SocialGetCommentErrorState(this.error);
}

class SocialGetChatLoadingState extends SocialStates {}

class SocialGetChatSuccessState extends SocialStates {}

class SocialGetChatErrorState extends SocialStates {
  final String error;
  SocialGetChatErrorState(this.error);
}

class SocialSendMessageSuccessState extends SocialStates {}

class SocialSendMessageErrorState extends SocialStates {}

class SocialGetMessageSuccessState extends SocialStates {}

class SocialChatPickedSuccessState extends SocialStates {}

class SocialChatPickedErrorState extends SocialStates {}

class SocialMessageImageSuccessState extends SocialStates {}

class SocialMessageImageErrorState extends SocialStates {}

class SocialRemoveChatImageSuccessState extends SocialStates {}

class SocialLogOutSuccessState extends SocialStates {}

class SocialLogOutErrorState extends SocialStates {
  final String error;
  SocialLogOutErrorState(this.error);
}

class SocialGetMessageGroupSuccessState extends SocialStates {}

class SocialGetMessageGroupErrorState extends SocialStates {}

class SocialSendMessageGroupSuccessState extends SocialStates {}

class SocialSendMessageGroupErrorState extends SocialStates {}

class SocialGroupModelSetState extends SocialStates {}

class SocialGroupLoadingState extends SocialStates {}

class SocialGroupSuccessState extends SocialStates {
  final List<UserModel> groupChats;
  SocialGroupSuccessState(this.groupChats);
}

class SocialUpdatePostImageSuccessState extends SocialStates {}

class SocialGroupErrorState extends SocialStates {
  final String error;
  SocialGroupErrorState(this.error);
}

class SocialLikesCountSuccessState extends SocialStates {
  final int likesCount;
  SocialLikesCountSuccessState(this.likesCount);
}

class SocialLikesCountErrorState extends SocialStates {
  final String error;
  SocialLikesCountErrorState(this.error);
}

class SocialGetCommentCountSuccessState extends SocialStates {
  final int commentCount;
  SocialGetCommentCountSuccessState(this.commentCount);
}

class SocialGetCommentCountErrorState extends SocialStates {
  final String error;
  SocialGetCommentCountErrorState(this.error);
}

class SocialDeletePostLoadingState extends SocialStates {}

class SocialDeletePostSuccessState extends SocialStates {}

class SocialDeletePostErrorState extends SocialStates {
  final String error;
  SocialDeletePostErrorState(this.error);
}

class SocialGetLikesSuccessState extends SocialStates {}

class SocialGetLikesErrorState extends SocialStates {
  final String error;
  SocialGetLikesErrorState(this.error);
}
