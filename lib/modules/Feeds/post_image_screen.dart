import 'package:flutter/material.dart';
import 'package:sociall_app_2/models/post_model.dart';

class PostImageScreen extends StatelessWidget {
  const PostImageScreen({super.key, required this.postModel});

  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Image(
        image: NetworkImage("${postModel.postImage}"),
      ),
    ));
  }
}
