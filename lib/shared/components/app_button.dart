import 'package:flutter/material.dart';

class appButton extends StatelessWidget {
  final String text;
  final Color? background;
  final Color? textColor;
  final VoidCallback? function;
  double? size;

  appButton({
    Key? key,
    required this.text,
    this.background,
    this.size,
    this.textColor,
    this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: size,
      decoration: BoxDecoration(
          color: background, borderRadius: BorderRadius.circular(10.0)),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}

// Container(
// height: 40,
// width: double.infinity,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(5),
// color: HexColor("#B7950B"),
// ),
// child: TextButton(
// onPressed: (){},
// child: const Text(
// "EDIT PROFILE",
// style: TextStyle(
// color: Colors.white
// ),
// )),
// )
