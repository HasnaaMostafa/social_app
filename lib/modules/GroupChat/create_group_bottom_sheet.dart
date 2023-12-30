// import 'package:flutter/material.dart';
//
// import '../../models/user_model.dart';
//
// class CreateGroupBottomSheet extends StatefulWidget {
//   final List<UserModel> users;
//   final Function(String groupName, List<UserModel> selectedUsers, String image)
//       onCreateGroup;
//
//   const CreateGroupBottomSheet({
//     super.key,
//     required this.users,
//     required this.onCreateGroup,
//   });
//
//   @override
//   State<CreateGroupBottomSheet> createState() => _CreateGroupBottomSheetState();
// }
//
// class _CreateGroupBottomSheetState extends State<CreateGroupBottomSheet> {
//   List<UserModel> selectedUsers = [];
//   TextEditingController groupNameController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           TextField(
//             controller: groupNameController,
//             decoration: const InputDecoration(
//               labelText: 'Group Name',
//               border: OutlineInputBorder(),
//             ),
//           ),
//           const SizedBox(height: 16),
//           const Text(
//             'Select Users',
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Expanded(
//             child: ListView.builder(
//               itemCount: widget.users.length,
//               itemBuilder: (context, index) {
//                 final user = widget.users[index];
//                 final isSelected = selectedUsers.contains(user);
//
//                 return ListTile(
//                   title: Text(user.name!),
//                   trailing: isSelected
//                       ? const Icon(Icons.check_box)
//                       : const Icon(Icons.check_box_outline_blank),
//                   onTap: () {
//                     setState(() {
//                       if (isSelected) {
//                         selectedUsers.remove(user);
//                       } else {
//                         selectedUsers.add(user);
//                       }
//                     });
//                   },
//                 );
//               },
//             ),
//           ),
//           const SizedBox(height: 16),
//           ElevatedButton(
//             onPressed: () {
//               final groupName = groupNameController.text;
//               const String image =
//                   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjueo9zId0zDvTiyDgJyQ4cCst7KBshTW-dg&usqp=CAU";
//               widget.onCreateGroup(groupName, selectedUsers, image);
//
//               Navigator.pop(context); // Close the bottom sheet
//             },
//             child: const Text('Create Group'),
//           ),
//         ],
//       ),
//     );
//   }
// }
