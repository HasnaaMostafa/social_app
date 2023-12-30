import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class appTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final void Function(String?)? onSubmit;
  final void Function(String?)? onChange;
  // final ValueChanged<String>? onSubmit;
  // final ValueChanged<String>? onChanged;
  final String? Function(String?)? validate;
  final String label;
  final String hint;
  final IconData prefix;
  final IconData? suffix;
  final bool? isPassword;
  final VoidCallback? suffixPressed;
  // final Color focusColor;
  final Color borderColor;
  final Color? suffixColor;
  final Color? prefixColor;
  final Color? lColor;
  final Color? hColor;
  final Color? erorrColor;

  const appTextFormField({
    Key? key,
    required this.controller,
    required this.keyboardType,
    required this.label,
    required this.hint,
    required this.prefix,
    required this.validate,
    this.onChange,
    this.onSubmit,
    this.suffix,
    this.isPassword,
    this.suffixPressed,
    required this.borderColor,
    this.suffixColor,
    this.prefixColor,
    this.lColor,
    this.hColor,
    this.erorrColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.grey),
      cursorColor: const Color(0xfff5f5f5),
      // obscureText: isPassword!=null? true:false,
      obscureText: isPassword ?? false,
      validator: validate,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        errorStyle: TextStyle(fontSize: 13, color: erorrColor),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: HexColor("#B7950B")),
        ),
        // enabledBorder:OutlineInputBorder(
        //   borderSide: BorderSide(
        //     color: borderColor,
        //   )
        // ) ,
        prefixIcon: IconButton(
          color: prefixColor,
          icon: Icon(prefix),
          onPressed: () {},
        ),
        labelText: label,
        labelStyle: TextStyle(color: lColor),
        hintText: hint,
        hintStyle: TextStyle(color: hColor),
        suffixIcon: suffix != null
            ? IconButton(
                color: suffixColor,
                icon: Icon(suffix),
                onPressed: suffixPressed,
              )
            : null,
        // border: const OutlineInputBorder(
        // ),,
      ),
    );
  }
}
