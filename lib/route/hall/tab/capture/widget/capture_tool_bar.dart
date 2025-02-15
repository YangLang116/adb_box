import 'package:adb_box/core/constant/color_constant.dart';
import 'package:adb_box/core/constant/font_constant.dart';
import 'package:adb_box/res/assets_res.dart';
import 'package:adb_box/route/hall/tab/capture/capture_tab_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CaptureToolBar extends StatelessWidget {
  final CaptureTabController controller;

  const CaptureToolBar(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(color: ColorConstant.primary),
      child: buildActions(),
    );
  }

  Widget buildActions() {
    return Row(
      children: [
        _IconButton(
          icon: AssetsRes.ICON_SCREENSHOT,
          onTap: controller.screenShot,
        ),
        SizedBox(width: 8),
        //开启鼠标位置捕获
        Obx(() {
          final enable = controller.enableMouseTrack;
          return _IconButton(
            status: enable,
            icon: AssetsRes.ICON_CURSOR,
            onTap: () => controller.updateMouseTrack(!enable),
          );
        }),
        Spacer(),
        buildCaptureInfo(),
      ],
    );
  }

  Widget buildCaptureInfo() {
    return Obx(() {
      final info = controller.captureInfo;
      if (info == null) return SizedBox();
      return Text(
        '[${info.width}, ${info.height}]',
        style: TextStyle(
          color: ColorConstant.hint,
          fontSize: FontConstant.hint,
        ),
      );
    });
  }
}

class _IconButton extends StatelessWidget {
  final bool status;
  final String icon;
  final GestureTapCallback onTap;

  const _IconButton({
    this.status = true,
    required this.icon,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Opacity(
        opacity: status ? 1 : 0.3,
        child: Container(
          width: 32,
          height: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: ColorConstant.background,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Image.asset(
            icon,
            width: 20,
            height: 20,
            color: ColorConstant.foreground,
          ),
        ),
      ),
    );
  }
}
