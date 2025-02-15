import 'package:adb_box/route/hall/tab/cmd/cmd_tab_controller.dart';
import 'package:adb_box/route/hall/tab/cmd/widget/cmd_tool_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CmdTabWidget extends StatefulWidget {
  const CmdTabWidget({super.key});

  @override
  State<CmdTabWidget> createState() => _CmdTabWidgetState();
}

class _CmdTabWidgetState extends State<CmdTabWidget> {
  late CmdTabController controller;

  @override
  void initState() {
    controller = Get.put(CmdTabController());
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<CmdTabController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CmdToolBar(controller),
        SizedBox(height: 8),
        Expanded(child: controller.console),
      ],
    );
  }
}
