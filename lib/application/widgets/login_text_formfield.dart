import 'package:flutter/material.dart';
import 'package:super_admin_app/application/utils/colors.dart';

// ignore: must_be_immutable
class BuildTextFormField extends StatefulWidget {
  BuildTextFormField({
    super.key,
    required this.hintTxt,
    this.prfixIcon,
    this.controller,
    this.validator,
    this.obscureTxt = false,
  });

  final String hintTxt;
  IconData? prfixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  bool obscureTxt;

  @override
  BuildTextFormFieldState createState() => BuildTextFormFieldState();
}

class BuildTextFormFieldState extends State<BuildTextFormField> {
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureTxt;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscureText,
      controller: widget.controller,
      validator: widget.validator,
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        prefixIcon: Icon(widget.prfixIcon, color: kClrBlue), 
        hintText: widget.hintTxt,
        suffixIcon: widget.obscureTxt
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: kClrBlue,
                ),
                onPressed: _togglePasswordVisibility,
              )
            : null,
      ),
    );
  }
}
