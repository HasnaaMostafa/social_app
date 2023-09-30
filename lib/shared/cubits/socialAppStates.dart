abstract class SocialStates{}

class SocialInitialState extends SocialStates{}

class SocialGetUserLoadingState extends SocialStates{}

class SocialGetUserSuccessState extends SocialStates{}

class SocialGetUserErrorState extends SocialStates{
  final String error;
  SocialGetUserErrorState(this.error);
}

class SocialChangeBottomNavState extends SocialStates{}

class SocialNewPostsState extends SocialStates{}

class SocialProfileImagePickedSuccessState extends SocialStates{}

class SocialProfileImagePickedErrorState extends SocialStates{}

class SocialCoverImagePickedSuccessState extends SocialStates{}

class SocialCoverImagePickedErrorState extends SocialStates{}

class SocialProfileImageUploadSuccessState extends SocialStates{}

class SocialProfileImageUploadErrorState extends SocialStates{}

class SocialCoverImageUploadSuccessState extends SocialStates{}

class SocialCoverImageUploadErrorState extends SocialStates{}

class SocialUserUpdateErrorState extends SocialStates{}

class SocialUserUpdateLoadingState extends SocialStates{}



class SocialUploadPostLoadingState extends SocialStates{}

class SocialUploadPostSuccessState extends SocialStates{}

class SocialUploadPostErrorState extends SocialStates{}

class SocialPostImagePickedSuccessState extends SocialStates{}

class SocialPostImagePickedErrorState extends SocialStates{}

class SocialRemovePostImageSuccessState extends SocialStates{}

class SocialGetPostLoadingState extends SocialStates{}

class SocialGetPostSuccessState extends SocialStates{}

class SocialGetPostErrorState extends SocialStates{
  final String error;
  SocialGetPostErrorState(this.error);
}


class SocialLikePostSuccessState extends SocialStates{}

class SocialLikePostErrorState extends SocialStates{
  final String error;
  SocialLikePostErrorState(this.error);
}

class SocialCommentPostLoadingState extends SocialStates{}

class SocialCommentPostSuccessState extends SocialStates{}

class SocialCommentPostErrorState extends SocialStates{
  final String error;
  SocialCommentPostErrorState(this.error);
}


class SocialGetCommentLoadingState extends SocialStates{}

class SocialGetCommentSuccessState extends SocialStates{
  late String PostId;
  SocialGetCommentSuccessState(this.PostId);
}

class SocialGetCommentErrorState extends SocialStates{
  final String error;
  SocialGetCommentErrorState(this.error);
}

class SocialGetChatLoadingState extends SocialStates{}

class SocialGetChatSuccessState extends SocialStates{}

class SocialGetChatErrorState extends SocialStates{
  final String error;
  SocialGetChatErrorState(this.error);
}

class SocialSendMessageSuccessState extends SocialStates{}

class SocialSendMessageErrorState extends SocialStates{}

class SocialGetMessageSuccessState extends SocialStates{}

class SocialChatPickedSuccessState extends SocialStates{}

class SocialChatPickedErrorState extends SocialStates{}

class SocialMessageImageSuccessState extends SocialStates{}

class SocialMessageImageErrorState extends SocialStates{}

class SocialRemoveChatImageSuccessState extends SocialStates{}


















