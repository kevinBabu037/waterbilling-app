import 'package:flutter/material.dart';


// ignore: must_be_immutable
class CustomTextFormFeild extends StatelessWidget {
  final TextEditingController? controller;
  final String hintTxt;
  final int maxLines;
  final String? Function(String?)? validator;
  
  const CustomTextFormFeild({
    super.key,
    required this.hintTxt,
    this.controller,
    this.maxLines = 1,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintTxt,
        filled: true,
        border: InputBorder.none,
      ),
      validator: validator,
    );
  }
}
