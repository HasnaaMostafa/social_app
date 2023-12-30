import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sociall_app_2/models/comment_model.dart';
import 'package:sociall_app_2/models/message_model.dart';
import 'package:sociall_app_2/models/user_model.dart';
import 'package:sociall_app_2/modules/Chats/chats_screen.dart';
import 'package:sociall_app_2/modules/Feeds/feeds_screen.dart';
import 'package:sociall_app_2/modules/new_posts/new_post_screen.dart';
import 'package:sociall_app_2/shared/components/constatnts.dart';
import 'package:sociall_app_2/shared/cubits/socialAppStates.dart';
import 'package:sociall_app_2/shared/network/local/cache_helper.dart';

import '../../models/post_model.dart';
import '../../modules/Game/game_screen.dart';
import '../../modules/Profile/profile_screen.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel? usermodel;

  void getUserData() {
    uId = CacheHelper.getData(key: "uId");
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection("users").doc(uId).get().then((value) {
      usermodel = UserModel.fromJson(value.data()!);
      getUsers();
      emit(SocialGetUserDataSuccessState());
    }).catchError((error) {
      emit(SocialGetUserDataErrorState(error.toString()));
      print(error.toString());
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    const FeedsScreen(),
    const ChatsScreen(),
    // ChatsGroupScreen(),
    NewPostsScreen(),
    const TicTacToeGame(),
    const ProfileScreen(),
  ];

  List<String> titles = [
    "Home",
    "Chats",
    // "Groups",
    "Add post",
    "Games",
    "Profile"
  ];

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

  void updatePostImage(File newImage) {
    postImage = newImage;
    emit(SocialUpdatePostImageSuccessState());
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

    FirebaseFirestore.instance.collection("posts").
        // doc("1").
        // set(model.toMap())
        add({...model.toMap(), 'dateTime': dateTime}).then((value) {
      getPosts();
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

  void getPosts() async {
    posts = [];
    likes = [];
    comments = [];
    postsId = [];

    emit(SocialGetPostLoadingState());

    try {
      final postsSnapshot = await FirebaseFirestore.instance
          .collection("posts")
          .orderBy("dateTime", descending: true)
          .get();

      await Future.wait(postsSnapshot.docs.map((element) async {
        final commentsSnapshot =
            await element.reference.collection("comments").get();

        final likesSnapshot = await element.reference.collection("likes").get();

        likes.add(likesSnapshot.docs.length);
        comments.add(commentsSnapshot.docs.length);
        postsId.add(element.id);
        posts.add(PostModel.fromJson(element.data()));
      }));

      emit(SocialGetPostSuccessState());
    } catch (error) {
      emit(SocialGetPostErrorState(error.toString()));
      print(error.toString());
    }
  }

  void deletePost(String postId) async {
    emit(SocialDeletePostLoadingState());

    try {
      final postReference =
          FirebaseFirestore.instance.collection("posts").doc(postId);

      // Delete comments associated with the post
      final commentsSnapshot = await postReference.collection("comments").get();
      await Future.wait(commentsSnapshot.docs.map((comment) async {
        await comment.reference.delete();
      }));

      final likesSnapshot = await postReference.collection("likes").get();
      await Future.wait(likesSnapshot.docs.map((like) async {
        await like.reference.delete();
      }));

      await postReference.delete();

      emit(SocialDeletePostSuccessState());
    } catch (error) {
      emit(SocialDeletePostErrorState(error.toString()));
      print(error.toString());
    }
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(usermodel!.uId)
        .get()
        .then((value) {
      if (value.exists) {
        // Already liked, so unlike the post
        FirebaseFirestore.instance
            .collection('posts')
            .doc(postId)
            .collection('likes')
            .doc(usermodel!.uId)
            .delete()
            .then((_) {
          // Update the likes list locally
          int postIndex = postsId.indexOf(postId);
          if (postIndex != -1 && likes.length > postIndex) {
            likes[postIndex] = likes[postIndex] - 1;
            emit(SocialLikePostSuccessState());
          }
        }).catchError((error) {
          emit(SocialLikePostErrorState(error.toString()));
        });
      } else {
        // Not liked, so like the post
        FirebaseFirestore.instance
            .collection('posts')
            .doc(postId)
            .collection('likes')
            .doc(usermodel!.uId)
            .set({'like': true}).then((_) {
          // Update the likes list locally
          int postIndex = postsId.indexOf(postId);
          if (postIndex != -1 && likes.length > postIndex) {
            likes[postIndex] = likes[postIndex] + 1;
            emit(SocialLikePostSuccessState());
          }
        }).catchError((error) {
          emit(SocialLikePostErrorState(error.toString()));
        });
      }
    }).catchError((error) {
      emit(SocialLikePostErrorState(error.toString()));
    });
  }

  // void getLikesCount(String postId) {
  //   FirebaseFirestore.instance
  //       .collection("posts")
  //       .doc(postId)
  //       .collection("likes")
  //       .get()
  //       .then((querySnapshot) {
  //     int likesCount = querySnapshot.size;
  //     emit(SocialLikesCountSuccessState(likesCount));
  //   }).catchError((error) {
  //     emit(SocialLikesCountErrorState(error.toString()));
  //   });
  // }
  // void getCommentsCount(String postId) {
  //   FirebaseFirestore.instance
  //       .collection("posts")
  //       .doc(postId)
  //       .collection("comments")
  //       .get()
  //       .then((querySnapshot) {
  //     int commentsCount = querySnapshot.size;
  //     emit(SocialGetCommentCountSuccessState(commentsCount));
  //   }).catchError((error) {
  //     emit(SocialGetCommentCountErrorState(error.toString()));
  //   });
  // }

  List<String> commentList = [];
  List<CommentModel> commentModelList = [];
  String? newPostId;

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
        .add(model.toMap())
        .then((value) {
      emit(SocialCommentPostSuccessState());
      getComments(postId);
    }).catchError((error) {
      emit(SocialCommentPostErrorState(error.toString()));
    });
  }

  void getComments(String postId) {
    emit(SocialGetCommentLoadingState());

    FirebaseFirestore.instance
        .collection("posts")
        .doc(postId)
        .collection("comments")
        .orderBy("dateTime")
        .get()
        .then((value) {
      commentModelList.clear();
      commentList.clear();
      for (var element in value.docs) {
        commentModelList.add(CommentModel.fromJson(element.data()));
        commentList.add(element.id);
        // getCommentsCount(postId);
        emit(SocialGetCommentSuccessState(postId));
      }
      newPostId = postId;
      emit(SocialGetCommentSuccessState(postId));
    }).catchError((error) {
      emit(SocialGetCommentErrorState(error.toString()));
    });
  }

  List<UserModel> users = [];

  void getUsers() {
    users = [];
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

    // set my chats(sender)
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
      for (var element in event.docs) {
        message.add(MessageModel.fromJson(element.data()));
      }
      emit(SocialGetMessageSuccessState());
    });
  }

  void sendGroupMessage({
    required List<UserModel> receivers,
    required String text,
    required String dateTime,
    String? image,
  }) {
    // Create a MessageModel for the message
    MessageModel model = MessageModel(
      text: text,
      dateTime: dateTime,
      senderId: usermodel!.uId,
      chatImage: image ?? "",
    );

    // Set the message for each receiver in the group
    receivers.forEach((receiver) async {
      // Set the message for the sender
      await FirebaseFirestore.instance
          .collection("users")
          .doc(usermodel!.uId)
          .collection("chats")
          .doc(receiver.uId)
          .collection("messages")
          .add(model.toMap())
          .then((value) {
        emit(SocialSendMessageSuccessState());
      }).catchError((error) {
        emit(SocialSendMessageErrorState());
        print(error.toString());
      });

      // Set the message for the receiver
      await FirebaseFirestore.instance
          .collection("users")
          .doc(receiver.uId)
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
    });
  }

  List<MessageModel> messageGroup = [];
  void getGroupMessages({
    required List<UserModel> receivers,
  }) {
    // Retrieve messages for each receiver in the group
    for (var receiver in receivers) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(usermodel!.uId)
          .collection("chats")
          .doc(receiver.uId)
          .collection("messages")
          .orderBy("dateTime")
          .snapshots()
          .listen((event) {
        messageGroup = [];
        event.docs.forEach((element) {
          messageGroup.add(MessageModel.fromJson(element.data()));
        });
        emit(SocialGetMessageSuccessState());
      });
    }
  }

  List<Map<String, dynamic>> chatGroups = []; // Store the list of chat groups

  // Method to get the chat groups from Firestore
  List<UserModel> groupChats = [];

  List<UserModel> SelectedUsers = [];
  String? groupUid;

  void createGroup(
      String groupName, List<UserModel> selectedUsers, String image) async {
    emit(SocialGroupLoadingState());

    List<String> memberIds = selectedUsers.map((user) => user.uId!).toList();
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;

    List<Map<String, dynamic>> selectedUsersMapList =
        selectedUsers.map((user) => user.toMap()).toList();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList("groupUid", memberIds);

    FirebaseFirestore.instance.collection('groups').add({
      "uId": groupUid,
      'groupName': groupName,
      'members': memberIds,
      'createdBy': currentUserId,
      'createdAt': Timestamp.now(),
      'image': image,
      'selectedUsers': selectedUsersMapList,
    }).then((value) {
      // Retrieve the created group from Firestore and assign the receivers
      value.get().then((docSnapshot) {
        Map<String, dynamic> groupData = docSnapshot.data()!;
        UserModel groupChat = UserModel(
          uId: groupData["groupUid"],
          name: groupData['groupName'],
          image: groupData['image'],
        );
        List<Map<String, dynamic>> selectedUsersMapList =
            groupData['selectedUsers'];
        List<UserModel> receivers = selectedUsersMapList
            .map((userMap) => UserModel.fromJson(userMap))
            .toList();
        groupChat.receivers = receivers;
        groupChats.add(groupChat);
        SelectedUsers.addAll([groupChat]);
        emit(SocialGroupSuccessState(groupChats));
      }).catchError((error) {
        emit(SocialGroupErrorState(error.toString()));
      });
    }).catchError((error) {
      emit(SocialGroupErrorState(error.toString()));
    });
  }

  Future<void> getChatGroups() async {
    emit(SocialGroupLoadingState());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? memberIds = prefs.getStringList("groupUid");

    if (memberIds != null) {
      FirebaseFirestore.instance
          .collection('groups')
          .where('members', arrayContainsAny: memberIds)
          .get()
          .then((snapshot) {
        chatGroups = [];
        groupChats = [];
        for (var doc in snapshot.docs) {
          Map<String, dynamic> group = doc.data();
          chatGroups.add(group);
          groupChats.add(UserModel(
            name: group['groupName'],
            image: group['image'],
          ));
        }
        emit(SocialGroupSuccessState(groupChats));

        // Retrieve the receivers (selected users) for each group
        for (int i = 0; i < groupChats.length; i++) {
          List<Map<String, dynamic>> selectedUsersMapList =
              chatGroups[i]['selectedUsers'];
          List<UserModel> selectedUsers = selectedUsersMapList
              .map((userMap) => UserModel.fromJson(userMap))
              .toList();
          groupChats[i].receivers = selectedUsers;
        }
      }).catchError((error) {
        emit(SocialGroupErrorState(error.toString()));
      });
    } else {
      emit(SocialGroupErrorState("No memberIds found in SharedPreferences"));
    }
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

  void listenAuth() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  Future<void> handleRefresh() {
    final Completer<void> completer = Completer<void>();
    Timer(const Duration(seconds: 1), () {
      completer.complete();
    });
    return completer.future.then<void>((_) {
      getPosts();
      emit(SocialGetPostSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }
}
