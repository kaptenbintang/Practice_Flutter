import 'package:flutter/material.dart';

class ProfileTextInput extends StatefulWidget {
  final TextEditingController textEditingController;
  final String hintTextString;
  final int maxLength;
  final String labelText;
  final bool obscure;
  void Function()? fungsitap;
  final bool readonly;
  // final TextInputType inputType;
  // final Widget prefixIcon;
  // final Widget suffixIcon;

  ProfileTextInput(
      {super.key,
      required this.textEditingController,
      required this.hintTextString,
      required this.maxLength,
      required this.labelText,
      required this.obscure,
      this.fungsitap,
      required this.readonly
      // required this.inputType,
      // required this.prefixIcon,
      // required this.suffixIcon,
      });

  @override
  State<ProfileTextInput> createState() => _ProfileTextInputState();
}

class _ProfileTextInputState extends State<ProfileTextInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextFormField(
        obscureText: widget.obscure,
        controller: widget.textEditingController,
        decoration: InputDecoration(
          hintText: widget.hintTextString,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blue),
              borderRadius: BorderRadius.circular(12)),
          fillColor: Colors.grey[200],
          filled: true,
          labelText: widget.labelText,
          isDense: true,
        ),
        readOnly: widget.readonly,
        onTap: widget.fungsitap,
        // maxLength: widget.maxLength,
      ),
    );
  }
}
