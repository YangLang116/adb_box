import 'package:adb_box/core/constant/color_constant.dart';
import 'package:adb_box/core/widget/comm_input_widget.dart';
import 'package:adb_box/core/widget/comm_path_select_widget.dart';
import 'package:adb_box/core/widget/window_option_widget.dart';
import 'package:adb_box/route/hall/tab/cmd/cmd_tab_controller.dart';
import 'package:adb_box/route/hall/tab/cmd/entity/cmd.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class CmdToolBar extends StatelessWidget {
  final CmdTabController controller;

  const CmdToolBar(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(color: ColorConstant.primary),
      child: Obx(() => buildCmd(controller.selectCmd)),
    );
  }

  Widget buildCmd(Cmd? selectCmd) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        WindowOptionWidget(
          hint: 'Select Cmd',
          current: selectCmd,
          dataList: controller.supportOptions,
          covert: (cmd) => cmd.name,
          onSelected: controller.onSelectCmd,
        ),
        SizedBox(width: 8),
        SizedBox(width: 480, child: buildCmd$Arg(selectCmd)),
      ],
    );
  }

  Widget? buildCmd$Arg(Cmd? selectCmd) {
    if (selectCmd == null || !selectCmd.needArg) return null;
    switch (selectCmd.argType) {
      case CmdArgType.text:
        return buildTextArg(selectCmd);
      case CmdArgType.file:
      case CmdArgType.directory:
        return buildPathArg(selectCmd);
      default:
        return SizedBox();
    }
  }

  Widget buildTextArg(Cmd selectCmd) {
    return InputWidget(
      hint: selectCmd.hint,
      onSubmit: (arg) => controller.executeCmd(selectCmd, arg),
    );
  }

  Widget buildPathArg(Cmd selectCmd) {
    return PathSelectWidget(
      hint: selectCmd.hint,
      onSubmit: (arg) => controller.executeCmd(selectCmd, arg),
    );
  }
}
