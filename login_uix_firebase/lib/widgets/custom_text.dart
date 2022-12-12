import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final double? size;
  final Color? color;
  final TextAlign? align;
  final FontWeight? weight;

  CustomText(
      {super.key,
      this.color = Colors.black,
      this.size = 16,
      this.text,
      this.weight = FontWeight.normal,
      this.align = TextAlign.start});

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: weight,
      ),
      textAlign: align,
    );
  }
}
