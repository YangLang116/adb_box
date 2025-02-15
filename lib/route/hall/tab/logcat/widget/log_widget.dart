import 'package:adb_box/core/adb/logcat/entity/log.dart';
import 'package:adb_box/core/constant/color_constant.dart';
import 'package:adb_box/core/constant/font_constant.dart';
import 'package:flutter/material.dart';

class LogWidget extends StatelessWidget {
  final Log log;
  final TextStyle textStyle;

  LogWidget(this.log, {super.key})
      : textStyle = TextStyle(
          fontSize: FontConstant.H3,
          height: 1.6,
          fontWeight: FontWeight.bold,
        );

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          if (log.time.isNotEmpty) _buildTime(log.time),
          if (log.pid > 0) _buildPid(log.pid),
          _buildLevel(),
          if (log.tag.isNotEmpty) _buildTag(log.tag),
          _buildContent(),
        ],
      ),
      style: textStyle.copyWith(color: ColorConstant.foreground),
    );
  }

  TextSpan _buildTime(String time) {
    return TextSpan(
      text: time,
      style: textStyle.copyWith(
        decoration: TextDecoration.underline,
        decorationColor: log.level.color,
        decorationStyle: TextDecorationStyle.solid,
      ),
    );
  }

  InlineSpan _buildPid(int pid) {
    return WidgetSpan(
      child: Container(
        width: 60,
        alignment: Alignment.center,
        child: Text(
          pid.toString(),
          style: textStyle.copyWith(
            height: 0,
            color: ColorConstant.foreground,
          ),
        ),
      ),
    );
  }

  InlineSpan _buildLevel() {
    return WidgetSpan(
      child: Container(
        width: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: log.level.color,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          log.level.value,
          style: textStyle.copyWith(
            height: 1.2,
            color: ColorConstant.foreground,
          ),
        ),
      ),
    );
  }

  InlineSpan _buildTag(String tag) {
    return TextSpan(
      text: ' $tag',
      style: textStyle.copyWith(color: log.level.color),
    );
  }

  TextSpan _buildContent() {
    return TextSpan(text: ' ${log.content}');
  }
}
