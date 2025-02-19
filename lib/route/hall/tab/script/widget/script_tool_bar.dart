import 'package:adb_box/core/constant/color_constant.dart';
import 'package:adb_box/core/constant/font_constant.dart';
import 'package:adb_box/core/widget/window_option_widget.dart';
import 'package:adb_box/route/hall/tab/script/core/script.dart';
import 'package:adb_box/route/hall/tab/script/script_tab_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScriptToolBar extends StatelessWidget {
  final ScriptTabController controller;

  const ScriptToolBar(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(color: ColorConstant.primary),
      child: Obx(() => buildCmd(controller.selectScript)),
    );
  }

  Widget buildCmd(Script? selectScript) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        WindowOptionWidget(
          hint: 'Select Script',
          current: selectScript,
          dataList: controller.supportScripts,
          covert: (script) => script.name,
          onSelected: controller.onSelectScript,
        ),
        SizedBox(width: 5),
        _buildDescription(selectScript),
      ],
    );
  }

  Widget _buildDescription(Script? selectScript) {
    return Text(
      selectScript?.description ?? '',
      style: TextStyle(
        color: ColorConstant.hint,
        fontSize: FontConstant.hint,
        height: 1,
      ),
    );
  }
}
