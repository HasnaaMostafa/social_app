// import 'package:bloc/bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
//
// import '../network/local/cache_helper.dart';
// import 'AppStates.dart';
//
// class AppCubit extends Cubit<AppStates>{
//
//   AppCubit() : super(AppInitialStates());
//
//   static AppCubit get(context)=>BlocProvider.of(context);
//
//   bool isnotDark=false;
//
//   void changeAppMode({bool?fromShared}){
//     if(fromShared != null){
//       isnotDark=fromShared;
//       emit(AppChangeModeState());
//     }
//     else {
//       isnotDark = !isnotDark;
//       CacheHelper.putBoolData(key: "isDark", value: isnotDark).
//       then((value) {
//         emit(AppChangeModeState());
//       });
//     }
//   }}

// void sendGroupMessage({
//     required List<String> receiverIds,
//     required String text,
//     required String dateTime,
//     String? image,
//   }) {
//     MessageModel model = MessageModel(
//       text: text,
//       dateTime: dateTime,
//       senderId: usermodel!.uId,
//       chatImage: image ?? "",
//     );
//
//     // Send message to each receiver
//     receiverIds.forEach((receiverId) {
//       // Update sender's chats
//       FirebaseFirestore.instance
//           .collection("users")
//           .doc(usermodel!.uId)
//           .collection("chats")
//           .doc(receiverId)
//           .collection("messages")
//           .add(model.toMap())
//           .then((value) {
//         emit(SocialSendMessageGroupSuccessState());
//       }).catchError((error) {
//         emit(SocialSendMessageGroupErrorState());
//         print(error.toString());
//       });
//
//       // Update receiver's chats
//       FirebaseFirestore.instance
//           .collection("users")
//           .doc(receiverId)
//           .collection("chats")
//           .doc(usermodel!.uId)
//           .collection("messages")
//           .add(model.toMap())
//           .then((value) {
//         emit(SocialSendMessageGroupSuccessState());
//       }).catchError((error) {
//         emit(SocialSendMessageGroupErrorState());
//         print(error.toString());
//       });
//     });
//   }
//
//   void getGroupMessages({
//     required List<String> receiverIds,
//   }) {
//     FirebaseFirestore.instance
//         .collection("groupChats")
//         .doc(generateGroupChatId(receiverIds))
//         .collection("messages")
//         .orderBy("dateTime")
//         .snapshots()
//         .listen((event) {
//       message = [];
//       for (var element in event.docs) {
//         message.add(MessageModel.fromJson(element.data()));
//       }
//       emit(SocialGetMessageGroupSuccessState());
//     });
//   }
//
//   String generateGroupChatId(List<String> receiverIds) {
//     // Sort receiver IDs to generate a consistent group chat ID
//     receiverIds.sort();
//     return receiverIds.join("_");
//   }
//
//   void createChatGroup(String groupName, List<UserModel> selectedUsers) {
//     FirebaseFirestore.instance.collection('chats').add({
//       'groupName': groupName,
//       'users': selectedUsers.map((user) => user.uId).toList(),
//     }).then((chatDoc) {
//       String chatId = chatDoc.id;
//       for (var user in selectedUsers) {
//         FirebaseFirestore.instance
//             .collection('users')
//             .doc(user.uId)
//             .collection('chats')
//             .doc(chatId)
//             .set({
//               'groupName': groupName,
//             })
//             .then((_) {})
//             .catchError((error) {
//               print('Error adding chat to user: $error');
//             });
//       }
//     }).catchError((error) {
//       print('Error creating chat: $error');
//     });
//   }
//
//   void setGroupModel(UserModel model) {
//     groupModels?.addAll([model]);
//     emit(SocialGroupModelSetState());
//   }
