import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:login_uix_firebase/helper/dimensions.dart';
import 'package:login_uix_firebase/helper/responsive.dart';

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
    double _width = MediaQuery.of(context).size.width;
    return Text(
      text!,
      style: TextStyle(
        fontSize: ResponsiveWidget.isLargeScreen(context)
            ? _width / (1920 / size!)
            : Dimensions.font16,
        color: color,
        fontWeight: weight,
      ),
      textAlign: align,
    );
  }
}
