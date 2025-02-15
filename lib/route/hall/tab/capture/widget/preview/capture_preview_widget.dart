import 'dart:io';

import 'package:adb_box/route/hall/tab/capture/capture_tab_controller.dart';
import 'package:adb_box/route/hall/tab/capture/entity/capture_entity.dart';
import 'package:adb_box/route/hall/tab/capture/widget/preview/capture_preview_controller.dart';
import 'package:adb_box/route/hall/tab/capture/widget/preview/layer/mouse_point_layer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CapturePreviewWidget extends StatefulWidget {
  final CaptureTabController captureController;

  const CapturePreviewWidget(this.captureController, {super.key});

  @override
  State<CapturePreviewWidget> createState() => _CapturePreviewWidgetState();
}

class _CapturePreviewWidgetState extends State<CapturePreviewWidget> {
  final controller = CapturePreviewController();

  CaptureEntity get capture => widget.captureController.captureInfo!;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraint) {
      double width = constraint.maxWidth;
      double height = constraint.maxHeight;
      return Stack(
        children: [
          Image.file(File(capture.path), width: width, height: height),
          buildMousePointLayer(width, height),
        ],
      );
    });
  }

  Widget buildMousePointLayer(double width, double height) {
    return Obx(() {
      final enable = widget.captureController.enableMouseTrack;
      if (!enable) return SizedBox();
      return Positioned.fill(
        child: MousePointLayer(
          width: width,
          height: height,
          capture: capture,
          controller: controller,
        ),
      );
    });
  }
}
