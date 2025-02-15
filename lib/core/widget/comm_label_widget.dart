import 'package:adb_box/core/constant/color_constant.dart';
import 'package:adb_box/core/constant/font_constant.dart';
import 'package:flutter/material.dart';

class LabelWidget extends StatelessWidget {
  final String title;

  const LabelWidget(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: ColorConstant.primary,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(5)),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: FontConstant.H3,
          height: 1,
          fontWeight: FontWeight.bold,
          color: ColorConstant.foreground,
        ),
      ),
    );
  }
}
