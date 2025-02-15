import 'package:adb_box/route/hall/tab/logcat/logcat_tab_controller.dart';
import 'package:adb_box/route/hall/tab/logcat/widget/logcat_filter_widget.dart';
import 'package:adb_box/route/hall/tab/logcat/widget/logcat_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogcatTabWidget extends StatefulWidget {
  const LogcatTabWidget({super.key});

  @override
  State<LogcatTabWidget> createState() => _LogcatTabWidgetState();
}

class _LogcatTabWidgetState extends State<LogcatTabWidget> {
  late LogcatTabController controller;

  @override
  void initState() {
    controller = Get.put(LogcatTabController());
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<LogcatTabController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LogcatFilterWidget(controller),
        SizedBox(height: 5),
        Expanded(child: LogcatListWidget(controller)),
      ],
    );
  }
}
