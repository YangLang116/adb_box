import 'package:adb_box/route/hall/tab/capture/capture_tab_controller.dart';
import 'package:adb_box/route/hall/tab/capture/entity/capture_entity.dart';
import 'package:adb_box/route/hall/tab/capture/widget/capture_tool_bar.dart';
import 'package:adb_box/route/hall/tab/capture/widget/preview/capture_preview_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CaptureTabWidget extends StatefulWidget {
  const CaptureTabWidget({super.key});

  @override
  State<CaptureTabWidget> createState() => _CaptureTabWidgetState();
}

class _CaptureTabWidgetState extends State<CaptureTabWidget> {
  late CaptureTabController controller;

  @override
  void initState() {
    controller = Get.put(CaptureTabController());
    controller.screenShot();
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<CaptureTabController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CaptureToolBar(controller),
        Expanded(child: Obx(() => buildContent(controller.captureInfo)))
      ],
    );
  }

  Widget buildContent(CaptureEntity? capture) {
    if (capture == null) return SizedBox();
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 10, bottom: 60),
      child: AspectRatio(
        key: ValueKey(capture),
        aspectRatio: capture.width / capture.height,
        child: CapturePreviewWidget(controller),
      ),
    );
  }
}
