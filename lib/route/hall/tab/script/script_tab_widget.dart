import 'package:adb_box/route/hall/tab/script/script_tab_controller.dart';
import 'package:adb_box/route/hall/tab/script/widget/script_tool_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScriptTabWidget extends StatefulWidget {
  const ScriptTabWidget({super.key});

  @override
  State<ScriptTabWidget> createState() => _ScriptTabWidgetState();
}

class _ScriptTabWidgetState extends State<ScriptTabWidget> {
  late ScriptTabController controller;

  @override
  void initState() {
    controller = Get.put(ScriptTabController());
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<ScriptTabController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ScriptToolBar(controller),
        SizedBox(height: 8),
        Expanded(child: controller.consoleWidget),
      ],
    );
  }
}
