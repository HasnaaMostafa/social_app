// import 'dart:isolate';
//
// class Isolates {
//   static void senderIsolate(SendPort sendPort) {
//     // Implement the logic for the sender isolate
//     // ...
//
//     sendPort.send({'message': 'Hello from sender isolate!'});
//   }
//
//   static void receiverIsolate(SendPort sendPort) {
//     // Implement the logic for the receiver isolate
//     // ...
//
//     sendPort.send({'message': 'Hello from receiver isolate!'});
//   }
//
//   void main(List<String> args, SendPort sendPort) {
//     // Determine whether this isolate is for sender or receiver
//     final isolateType = args[0];
//
//     if (isolateType == 'sender') {
//       senderIsolate(sendPort);
//     } else if (isolateType == 'receiver') {
//       receiverIsolate(sendPort);
//     }
//   }
// }
//
// // import 'dart:isolate';
// //
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:sociall_app_2/shared/cubits/socialAppCubit.dart';
// //
// // import '../../models/message_model.dart';
// //
// // class SocialChatIsolate {
// //   final SendPort sendPort;
// //
// //   SocialChatIsolate(this.sendPort);
// //
// //   void sendMessage({
// //     required String receiverId,
// //     required String text,
// //     required String dateTime,
// //     String? image,
// //   }) {
// //     MessageModel model = MessageModel(
// //       text: text,
// //       receiverId: receiverId,
// //       dateTime: dateTime,
// //       senderId: usermodel!.uId,
// //       chatImage: image ?? "",
// //     );
// //
// //     _sendMessageToIsolate({
// //       'receiverId': receiverId,
// //       'model': model.toMap(),
// //     });
// //   }
// //
// //   void getMessages({
// //     required String receiverId,
// //   }) {
// //     _sendMessageToIsolate({
// //       'receiverId': receiverId,
// //       'getMessages': true,
// //     });
// //   }
// //
// //   void _sendMessageToIsolate(Map<String, dynamic> message) {
// //     sendPort.send(message);
// //   }
// // }
// //
// // void socialChatIsolateEntryPoint(SendPort sendPort,BuildContext context) {
// //   final isolate = SocialChatIsolate(sendPort);
// //   final receivePort = ReceivePort();
// //
// //   sendPort.send(receivePort.sendPort);
// //
// //   receivePort.listen((message) {
// //     if (message is Map<String, dynamic>) {
// //       if (message.containsKey('receiverId')) {
// //         final receiverId = message['receiverId'] as String;
// //         final model = MessageModel.fromJson(message['model']);
// //         SocialCubit.get(context).sendMessage(receiverId: receiverId, text: model.text!, dateTime: model.dateTime!);
// //       } else if (message.containsKey('getMessages')) {
// //         final receiverId = message['receiverId'] as String;
// //         SocialCubit.get(context).getMessages(receiverId: receiverId);
// //       }
// //     }
// //   });
// // }
// //
