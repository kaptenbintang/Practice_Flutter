import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfileTextInput extends StatefulWidget {
  final TextEditingController textEditingController;
  final String hintTextString;
  final int maxLength;
  final String labelText;
  // final TextInputType inputType;
  // final Widget prefixIcon;
  // final Widget suffixIcon;

  const ProfileTextInput({
    super.key,
    required this.textEditingController,
    required this.hintTextString,
    required this.maxLength,
    required this.labelText,
    // required this.inputType,
    // required this.prefixIcon,
    // required this.suffixIcon,
  });

  @override
  State<ProfileTextInput> createState() => _ProfileTextInputState();
}

class _ProfileTextInputState extends State<ProfileTextInput> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
      child: TextField(
        controller: widget.textEditingController,
        decoration: InputDecoration(
          hintText: widget.hintTextString,
          focusedBorder: const OutlineInputBorder(),
          border: const OutlineInputBorder(),
          labelText: widget.labelText,
          isDense: true,
        ),
        maxLength: widget.maxLength,
      ),
    );
  }
}
