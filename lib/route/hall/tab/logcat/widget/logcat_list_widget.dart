import 'package:adb_box/core/ext/pointer_event_ext.dart';
import 'package:adb_box/route/hall/tab/logcat/logcat_tab_controller.dart';
import 'package:adb_box/route/hall/tab/logcat/widget/log_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogcatListWidget extends StatelessWidget {
  final LogcatTabController controller;

  const LogcatListWidget(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (e) {
        if (e.isMouseRightBtnClick) controller.showMenu(context, e);
      },
      child: Obx(() {
        final logs = controller.logs;
        final isRevert = controller.isRevertList;
        return ListView.separated(
          controller: controller.scrollC,
          padding: EdgeInsets.all(10),
          reverse: isRevert,
          itemCount: logs.length,
          separatorBuilder: (context, index) => SizedBox(height: 5),
          itemBuilder: (context, index) {
            final realIndex = isRevert ? logs.length - 1 - index : index;
            return LogWidget(logs[realIndex]);
          },
        );
      }),
    );
  }
}
