// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sociall_app_2/models/user_model.dart';
// import 'package:sociall_app_2/modules/ChatDetails/chat_group_details.dart';
// import 'package:sociall_app_2/shared/components/components.dart';
// import 'package:sociall_app_2/shared/cubits/socialAppCubit.dart';
// import 'package:sociall_app_2/shared/cubits/socialAppStates.dart';
// import 'package:uuid/uuid.dart';
// import 'create_group_bottom_sheet.dart';
//
// class ChatsGroupScreen extends StatefulWidget {
//   const ChatsGroupScreen({super.key});
//
//   @override
//   State<ChatsGroupScreen> createState() => _ChatsGroupScreenState();
// }
//
// class _ChatsGroupScreenState extends State<ChatsGroupScreen> {
//   List<UserModel> groupChats = [];
//   @override
//   void initState() {
//     _fetchChatGroups();
//     super.initState();
//   }
//
//   Future<void> _fetchChatGroups() async {
//     await SocialCubit.get(context).getChatGroups();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<SocialCubit, SocialStates>(
//       listener: (BuildContext context, Object? state) {
//         if (state is SocialGroupSuccessState) {
//           groupChats = state.groupChats;
//         }
//       },
//       builder: (BuildContext context, Object? state) {
//         return Scaffold(
//           body: ConditionalBuilder(
//             condition: groupChats.isNotEmpty,
//             builder: (BuildContext context) => ListView.separated(
//               physics: const BouncingScrollPhysics(),
//               itemBuilder: (BuildContext context, int index) {
//                 return buildChatGroupItem(groupChats[index], context);
//               },
//               separatorBuilder: (BuildContext context, int index) =>
//                   myDivider(),
//               itemCount: groupChats.length,
//             ),
//             fallback: (BuildContext context) =>
//                 const Center(child: Text("No chats!")),
//           ),
//           floatingActionButton: FloatingActionButton(
//             onPressed: () {
//               showModalBottomSheet(
//                 context: context,
//                 builder: (BuildContext context) => CreateGroupBottomSheet(
//                   users: SocialCubit.get(context).users,
//                   onCreateGroup: (groupName, selectedUsers, image) {
//                     String groupUid = const Uuid().v4();
//                     SocialCubit.get(context).groupUid = groupUid;
//                     SocialCubit.get(context)
//                         .createGroup(groupName, selectedUsers, image);
//                     setState(() {
//                       groupChats.add(UserModel(
//                           uId: groupUid,
//                           name: groupName,
//                           image: image,
//                           receivers:
//                               selectedUsers)); // Add the created group chat to the list
//                     });
//                   },
//                 ),
//               );
//             },
//             child: const Icon(Icons.group_add),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget buildChatGroupItem(UserModel model, context) => InkWell(
//         onTap: () {
//           navigateTo(
//               context,
//               ChatGroupDetailsScreen(
//                 userModel: model,
//                 receivers: model.receivers!,
//                 groupImage: model.image!, // Pass the group image
//                 groupName: model.name!,
//               ));
//         },
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Row(
//             children: [
//               CircleAvatar(
//                 radius: 25,
//                 backgroundImage: NetworkImage("${model.image}"),
//               ),
//               const SizedBox(
//                 width: 15,
//               ),
//               Text(
//                 "${model.name}",
//                 style: const TextStyle(
//                     height: 1.3, fontWeight: FontWeight.bold, fontSize: 17),
//               ),
//             ],
//           ),
//         ),
//       );
// }
