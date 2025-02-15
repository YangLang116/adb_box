import 'package:adb_box/core/constant/color_constant.dart';
import 'package:adb_box/core/constant/font_constant.dart';
import 'package:adb_box/route/hall/tab/capture/entity/capture_entity.dart';
import 'package:adb_box/route/hall/tab/capture/widget/preview/capture_preview_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

class MousePointLayer extends StatelessWidget {
  final double width;
  final double height;
  final CaptureEntity capture;
  final CapturePreviewController controller;

  const MousePointLayer({
    required this.width,
    required this.height,
    required this.capture,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Widget line = DecoratedBox(
      decoration: BoxDecoration(
        color: ColorConstant.selected,
      ),
    );
    return Listener(
      onPointerDown: (e) {
        final localP = e.localPosition;
        double realX = capture.width / width * localP.dx;
        double realY = capture.height / height * localP.dy;
        final clipData = ClipboardData(
          text: '(${realX.toStringAsFixed(2)}, ${realY.toStringAsFixed(2)})',
        );
        Clipboard.setData(clipData);
        showToast('已复制指针位置');
      },
      child: MouseRegion(
          onEnter: (e) => controller.updateMousePoint(e.localPosition),
          onHover: (e) => controller.updateMousePoint(e.localPosition),
          onExit: (e) => controller.updateMousePoint(Offset.zero),
          child: Obx(() {
            final offset = controller.mousePoint;
            if (offset == Offset.zero) return SizedBox.expand();
            double left = offset.dx;
            double top = offset.dy;
            double labelX = left > width / 2 ? left - 60 : left + 10;
            double labelY = top > height / 2 ? top - 20 : top + 5;
            return Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  top: top,
                  height: 0.5,
                  child: line,
                ),
                Positioned(
                  left: left,
                  width: 0.5,
                  top: 0,
                  bottom: 0,
                  child: line,
                ),
                Positioned(
                  left: labelX,
                  top: labelY,
                  child: Text(
                    '(${left.toInt()}, ${top.toInt()})',
                    style: TextStyle(
                      color: ColorConstant.selected,
                      fontSize: FontConstant.H5,
                    ),
                  ),
                )
              ],
            );
          })),
    );
  }
}
