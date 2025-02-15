import 'package:adb_box/core/adb/logcat/entity/log_level.dart';
import 'package:adb_box/core/constant/color_constant.dart';
import 'package:adb_box/core/constant/font_constant.dart';
import 'package:adb_box/core/widget/comm_input_widget.dart';
import 'package:adb_box/core/widget/window_option_widget.dart';
import 'package:adb_box/route/hall/tab/logcat/logcat_tab_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogcatFilterWidget extends StatelessWidget {
  final LogcatTabController controller;

  const LogcatFilterWidget(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: ColorConstant.primary,
      ),
      child: buildContent(),
    );
  }

  Widget buildContent() {
    return Row(
      children: [
        Expanded(flex: 3, child: buildInput('Regex: ', controller.regexC)),
        SizedBox(width: 30),
        Expanded(flex: 2, child: buildInput('Tag: ', controller.tagC)),
        SizedBox(width: 10),
        buildLevel(),
      ],
    );
  }

  Widget buildInput(String label, TextEditingController c) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: FontConstant.label,
            color: ColorConstant.label,
          ),
        ),
        SizedBox(width: 5),
        Expanded(
          child: InputWidget(
            controller: c,
            hint: 'input filter',
            onSubmit: (t) => controller.logcat(),
          ),
        ),
      ],
    );
  }

  Widget buildLevel() {
    return Obx(() {
      final rxLevel = controller.rxSearchLevel;
      return WindowOptionWidget<LogLevel>(
        selectItem: rxLevel.value,
        dataList: LogLevel.values,
        hint: 'Select Level',
        width: 120,
        covert: (level) => level.name,
        onSelected: (level) {
          rxLevel.value = level;
          controller.logcat();
        },
      );
    });
  }
}
