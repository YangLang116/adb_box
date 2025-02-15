import 'package:adb_box/core/constant/color_constant.dart';
import 'package:adb_box/core/widget/window_buttons_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';

class WindowBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBtn;
  final bool showBack;
  final Widget? lead;
  final Widget? action;

  WindowBar({
    super.key,
    this.showBtn = true,
    this.showBack = false,
    this.lead,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorConstant.primary,
      child: Container(
        alignment: Alignment.centerLeft,
        child: DragToMoveArea(
          child: Row(
            children: [
              if (showBack) buildBackBtn(),
              if (lead != null) lead!,
              Spacer(),
              if (action != null) action!,
              if (showBtn) WindowButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBackBtn() {
    return GestureDetector(
      onTap: Get.back,
      child: Icon(
        Icons.arrow_back_rounded,
        size: 25,
        color: Colors.white,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50);
}
