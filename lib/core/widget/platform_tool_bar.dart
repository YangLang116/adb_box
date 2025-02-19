import 'package:adb_box/core/constant/color_constant.dart';
import 'package:adb_box/core/widget/window_buttons_widget.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

abstract class _PlatformToolBar extends StatelessWidget
    implements PreferredSizeWidget {
  _PlatformToolBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorConstant.primary,
      child: Container(
        alignment: Alignment.centerLeft,
        child: DragToMoveArea(child: buildContent(context)),
      ),
    );
  }

  Widget buildContent(BuildContext context);

  @override
  Size get preferredSize => Size.fromHeight(50);
}

class WindowsToolBar extends _PlatformToolBar {
  final Widget? lead;
  final Widget? action;

  WindowsToolBar({super.key, this.lead, this.action});

  @override
  Widget buildContent(BuildContext context) {
    return Row(
      children: [
        if (lead != null) lead!,
        Spacer(),
        if (action != null) action!,
        WindowButtons(),
      ],
    );
  }
}

class MacosToolBar extends _PlatformToolBar {
  final Widget child;

  MacosToolBar({super.key, required this.child});

  @override
  Widget buildContent(BuildContext context) => child;
}
