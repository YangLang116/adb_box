import 'package:adb_box/core/constant/color_constant.dart';
import 'package:adb_box/core/widget/window_buttons_widget.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class WindowsToolBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? lead;
  final Widget? action;

  WindowsToolBar({super.key, this.lead, this.action});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorConstant.primary,
      child: Container(
        alignment: Alignment.centerLeft,
        child: DragToMoveArea(
          child: Row(
            children: [
              if (lead != null) lead!,
              Spacer(),
              if (action != null) action!,
              WindowButtons(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50);
}
