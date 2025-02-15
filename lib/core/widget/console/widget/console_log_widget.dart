import 'package:adb_box/core/constant/color_constant.dart';
import 'package:adb_box/core/constant/font_constant.dart';
import 'package:adb_box/core/widget/console/entity/console_log.dart';
import 'package:flutter/material.dart';

class ConsoleLogWidget extends StatelessWidget {
  final ConsoleLog log;

  const ConsoleLogWidget(this.log);

  @override
  Widget build(BuildContext context) {
    return Text(
      log.text,
      style: TextStyle(
        fontSize: FontConstant.H3,
        height: 1.6,
        fontWeight: FontWeight.bold,
        color: log.isError ? Colors.red : ColorConstant.foreground,
      ),
    );
  }
}
