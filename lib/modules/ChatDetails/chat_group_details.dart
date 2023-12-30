// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../models/message_model.dart';
// import '../../models/user_model.dart';
// import '../../shared/components/constatnts.dart';
// import '../../shared/cubits/socialAppCubit.dart';
// import '../../shared/cubits/socialAppStates.dart';
//
// class ChatGroupDetailsScreen extends StatefulWidget {
//   const ChatGroupDetailsScreen({
//     super.key,
//     required this.userModel,
//     required this.receivers,
//     required this.groupImage,
//     required this.groupName,
//   });
//
//   final UserModel? userModel;
//   final List<UserModel> receivers;
//   final String groupImage; // Group image
//   final String groupName;
//
//   @override
//   State<ChatGroupDetailsScreen> createState() => _ChatDetailsScreenState();
// }
//
// class _ChatDetailsScreenState extends State<ChatGroupDetailsScreen> {
//   var messageController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Builder(builder: (context) {
//       SocialCubit.get(context).getGroupMessages(receivers: widget.receivers);
//
//       return BlocConsumer<SocialCubit, SocialStates>(
//         listener: (context, state) {},
//         builder: (context, state) {
//           return Scaffold(
//             appBar: AppBar(
//               titleSpacing: 0,
//               title: Row(
//                 children: [
//                   CircleAvatar(
//                     radius: 20,
//                     backgroundImage: NetworkImage(widget.groupImage),
//                   ),
//                   const SizedBox(
//                     width: 15,
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(widget.groupName),
//                       Text(
//                         "Receivers: ${widget.receivers.map((user) => user.name).join(', ')}",
//                         style: const TextStyle(fontSize: 12),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             body: Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 children: [
//                   Expanded(
//                     child: SingleChildScrollView(
//                       reverse: true,
//                       child: ListView.separated(
//                         shrinkWrap: true,
//                         physics: const BouncingScrollPhysics(),
//                         itemBuilder: (BuildContext context, int index) {
//                           var message = SocialCubit.get(context).message[index];
//                           if (widget.userModel!.uId == message.receiverId) {
//                             return buildReceiverMessage(message);
//                           } else if (widget.userModel!.uId ==
//                               message.senderId) {
//                             return buildSendMessage(message);
//                           }
//                           return const SizedBox.shrink();
//                         },
//                         separatorBuilder: (BuildContext context, int index) =>
//                             const SizedBox(
//                           height: 15,
//                         ),
//                         itemCount: SocialCubit.get(context).message.length,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 7,
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey, width: 1),
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     clipBehavior: Clip.antiAliasWithSaveLayer,
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 15),
//                             child: TextFormField(
//                               controller: messageController,
//                               onFieldSubmitted: (value) {
//                                 SocialCubit.get(context).sendGroupMessage(
//                                   receivers: widget.receivers,
//                                   text: messageController.text,
//                                   dateTime: DateTime.now().toString(),
//                                 );
//                                 FocusScope.of(context).unfocus();
//                                 messageController.clear();
//                               },
//                               decoration: InputDecoration(
//                                 hintText: "Type your message here...",
//                                 border: InputBorder.none,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Container(
//                           height: 50,
//                           color: defaultColor,
//                           child: MaterialButton(
//                             minWidth: 1,
//                             onPressed: () {
//                               SocialCubit.get(context).sendGroupMessage(
//                                 receivers: widget.receivers,
//                                 text: messageController.text,
//                                 dateTime: DateTime.now().toString(),
//                               );
//                               FocusScope.of(context).unfocus();
//                               messageController.clear();
//                             },
//                             child: const Icon(
//                               Icons.send,
//                               size: 16,
//                               color: Colors.white,
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       );
//     });
//   }
//
//   Widget buildReceiverMessage(MessageModel model) {
//     return Align(
//       alignment: AlignmentDirectional.centerStart,
//       child: Column(
//         children: [
//           if (model.text!.isNotEmpty)
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.grey[600],
//                 borderRadius: const BorderRadiusDirectional.only(
//                   bottomEnd: Radius.circular(10),
//                   topEnd: Radius.circular(10),
//                   topStart: Radius.circular(10),
//                 ),
//               ),
//               padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//               child: Text(
//                 model.text!,
//                 style: const TextStyle(fontSize: 17, color: Colors.white),
//               ),
//             ),
//           if (model.chatImage!.isNotEmpty)
//             Container(
//               height: 200,
//               width: 200,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 image: DecorationImage(
//                   image: NetworkImage(model.chatImage!),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   Widget buildSendMessage(MessageModel model) {
//     return Align(
//       alignment: AlignmentDirectional.centerEnd,
//       child: Column(
//         children: [
//           if (model.text!.isNotEmpty)
//             Container(
//               decoration: BoxDecoration(
//                 color: defaultColor2.withOpacity(0.5),
//                 borderRadius: const BorderRadiusDirectional.only(
//                   bottomStart: Radius.circular(10),
//                   topEnd: Radius.circular(10),
//                   topStart: Radius.circular(10),
//                 ),
//               ),
//               padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//               child: Text(
//                 model.text!,
//                 style: const TextStyle(fontSize: 17),
//               ),
//             ),
//           if (model.chatImage!.isNotEmpty)
//             Container(
//               height: 200,
//               width: 200,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 image: DecorationImage(
//                   image: NetworkImage(model.chatImage!),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
