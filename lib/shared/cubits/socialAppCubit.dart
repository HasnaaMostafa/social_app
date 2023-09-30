import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sociall_app_2/models/comment_model.dart';
import 'package:sociall_app_2/models/message_model.dart';
import 'package:sociall_app_2/models/user_model.dart';
import 'package:sociall_app_2/modules/Chats/chats_screen.dart';
import 'package:sociall_app_2/modules/Feeds/feeds_screen.dart';
import 'package:sociall_app_2/modules/Settings/settings_screen.dart';
import 'package:sociall_app_2/modules/Users/users_screen.dart';
import 'package:sociall_app_2/modules/new_posts/new_post_screen.dart';
import 'package:sociall_app_2/shared/components/constatnts.dart';
import 'package:sociall_app_2/shared/cubits/socialAppStates.dart';

import '../../models/post_model.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel? usermodel;

  void getUserData() {
    emit(SocialGetUserLoadingState());

    FirebaseFirestore.instance.collection("users").doc(uId).get().then((value) {
      usermodel = UserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      emit(SocialGetUserErrorState(error.toString()));
      print(error.toString());
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    FeedsScreen(),
    const ChatsScreen(),
    NewPostsScreen(),
    const UsersScreen(),
    const SettingsScreen(),
  ];

  List<String> titles = ["Home", "Chats", "Add post", "Users", "Settings"];

  void changeBottomNav(int index) {
    if (index == 1) {
      getUsers();
    }
    if (index == 2) {
      emit(SocialNewPostsState());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  File? profileImage;
  var Picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await Picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print("No image selected");
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? coverImage;
  Future<void> getCoverImage() async {
    final pickedFile = await Picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print("No image selected");
      emit(SocialCoverImagePickedErrorState());
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
        .child("users/${Uri.file(profileImage!.path).pathSegments.last}")
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialProfileImageUploadSuccessState());
        print(value);
        updateUser(name: name, phone: phone, bio: bio, image: value);
      }).catchError((error) {
        emit(SocialProfileImagePickedErrorState());
      });
    }).catchError((error) {
      emit(SocialProfileImagePickedErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("users/${Uri.file(coverImage!.path).pathSegments.last}")
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(SocialCoverImageUploadSuccessState());
        print(value);
        updateUser(name: name, phone: phone, bio: bio, cover: value);
      }).catchError((error) {
        emit(SocialCoverImagePickedErrorState());
      });
    }).catchError((error) {
      emit(SocialCoverImagePickedErrorState());
    });
  }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }) {
    emit(SocialUserUpdateLoadingState());
    UserModel model = UserModel(
      name: name,
      phone: phone,
      bio: bio,
      email: usermodel!.email,
      cover: cover ?? usermodel!.cover,
      image: image ?? usermodel!.image,
      uId: usermodel!.uId,
    );

    FirebaseFirestore.instance
        .collection("users")
        .doc(usermodel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUserUpdateErrorState());
    });
  }

  File? postImage;

  Future<void> getPostImage() async {
    final pickedFile = await Picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print("No image selected");
      emit(SocialPostImagePickedErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageSuccessState());
  }

  void uploadPostImage({
    required String text,
    required String dateTime,
  }) {
    emit(SocialUploadPostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("posts/${Uri.file(postImage!.path).pathSegments.last}")
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPost(text: text, dateTime: dateTime, postImage: value);
        // emit(SocialUploadPostSuccessState());
      }).catchError((error) {
        emit(SocialUploadPostErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadPostErrorState());
    });
  }

  void createPost({
    required String text,
    required String dateTime,
    String? postImage,
  }) {
    emit(SocialUploadPostLoadingState());
    PostModel model = PostModel(
      name: usermodel!.name,
      image: usermodel!.image,
      uId: usermodel!.uId,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? "",
    );

    FirebaseFirestore.instance
        .collection("posts")
        .
        // doc("1").
        // set(model.toMap())
        add(model.toMap())
        .then((value) {
      emit(SocialUploadPostSuccessState());
    }).catchError((error) {
      emit(SocialUploadPostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  List<int> comments = [];
  // List<int> comments=[];

  void getPosts() {
    emit(SocialGetPostLoadingState());
    FirebaseFirestore.instance.collection("posts").get().then((value) {
      value.docs.forEach((element) {
        element.reference
            .collection("comments")
            .doc(uId)
            .collection("user comment")
            .orderBy("dateTime")
            .get()
            .then((v) {
          element.reference.collection("likes").get().then((value) {
            likes.add(value.docs.length);
            comments.add(v.docs.length);
            postsId.add(element.id);
            posts.add(PostModel.fromJson(element.data()));
          });

          emit(SocialGetPostSuccessState());
        }).catchError((error) {
          emit(SocialGetPostErrorState(error.toString()));
          print(error.toString());
        });

        emit(SocialGetPostSuccessState());
      });
    }).catchError((error) {
      emit(SocialGetPostErrorState(error.toString()));
      print(error.toString());
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection("posts")
        .doc(postId)
        .collection("likes")
        .doc(usermodel!.uId)
        .set({"like": true}).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState(error.toString()));
    });
  }

  void commentPost({
    required String postId,
    required String comment,
    required String dateTime,
  }) {
    emit(SocialCommentPostLoadingState());

    CommentModel model = CommentModel(
      text: comment,
      name: usermodel!.name,
      userId: usermodel!.uId,
      userImage: usermodel!.image,
      dateTime: dateTime,
    );

    FirebaseFirestore.instance
        .collection("posts")
        .doc(postId)
        .collection("comments")
        .doc(usermodel!.uId)
        .collection("user comment")
        .add(model.toMap())
        .then((value) {
      emit(SocialCommentPostSuccessState());
      getComments(postId);
    }).catchError((error) {
      emit(SocialCommentPostErrorState(error.toString()));
    });
  }

  List<String> commentList = [];
  List<CommentModel> commentModelList = [];
  String? newPostId;
  void getComments(String postId) {
    emit(SocialGetCommentLoadingState());

    FirebaseFirestore.instance
        .collection("posts")
        .doc(postId)
        .collection("comments")
        .doc(usermodel!.uId)
        .collection("user comment")
        .orderBy("dateTime")
        .get()
        .then((value) {
      commentModelList.clear();
      commentList.clear();
      value.docs.forEach((element) {
        commentModelList.add(CommentModel.fromJson(element.data()));
        commentList.add(element.id);

        emit(SocialGetCommentSuccessState(postId));
      });
      newPostId = postId;
      emit(SocialGetCommentSuccessState(postId));
    }).catchError((error) {
      emit(SocialGetCommentErrorState(error.toString()));
    });
  }

  List<UserModel> users = [];

  void getUsers() {
    if (users.isEmpty) {
      FirebaseFirestore.instance.collection("users").get().then((value) {
        value.docs.forEach((element) {
          if (element.data()["uId"] != usermodel!.uId) {
            users.add(UserModel.fromJson(element.data()));
          }
        });
        emit(SocialGetUserSuccessState());
      }).catchError((error) {
        emit(SocialGetUserErrorState(error.toString()));
      });
    }
  }

  void sendMessage({
    required String receiverId,
    required String text,
    required String dateTime,
    String? image,
  }) {
    MessageModel model = MessageModel(
      text: text,
      receiverId: receiverId,
      dateTime: dateTime,
      senderId: usermodel!.uId,
      chatImage: image ?? "",
    );

    // set my chats

    FirebaseFirestore.instance
        .collection("users")
        .doc(usermodel!.uId)
        .collection("chats")
        .doc(receiverId)
        .collection("messages")
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
      print(error.toString());
    });

    // set receiver chat
    FirebaseFirestore.instance
        .collection("users")
        .doc(receiverId)
        .collection("chats")
        .doc(usermodel!.uId)
        .collection("messages")
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
      print(error.toString());
    });
  }

  List<MessageModel> message = [];

  void getMessages({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(usermodel!.uId)
        .collection("chats")
        .doc(receiverId)
        .collection("messages")
        .orderBy("dateTime")
        .snapshots()
        .listen((event) {
      message = [];
      event.docs.forEach((element) {
        message.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialGetMessageSuccessState());
    });
  }

  File? chatImage;
  Future<void> getMessageImage() async {
    final pickedFile = await Picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      chatImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialChatPickedSuccessState());
    } else {
      print("No image selected");
      emit(SocialChatPickedErrorState());
    }
  }

  void uploadMessageImage({
    required String text,
    required String dateTime,
    required String receiverId,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("users/${Uri.file(chatImage!.path).pathSegments.last}")
        .putFile(chatImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        sendMessage(
          receiverId: receiverId,
          text: text,
          dateTime: dateTime,
          image: value,
        );
        emit(SocialMessageImageSuccessState());
      }).catchError((error) {
        emit(SocialMessageImageErrorState());
      });
    }).catchError((error) {
      emit(SocialMessageImageErrorState());
    });
  }

  void removeMessageImage() {
    chatImage = null;
    emit(SocialRemoveChatImageSuccessState());
  }
}
