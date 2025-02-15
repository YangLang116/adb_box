import 'package:adb_box/core/widget/window_hover_widget.dart';
import 'package:adb_box/res/assets_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';

class WindowButtons extends StatefulWidget {
  const WindowButtons({super.key});

  @override
  State<WindowButtons> createState() => _WindowButtonsState();
}

class _WindowButtonsState extends State<WindowButtons> with WindowListener {
  final Rx<bool> isMaxingRx = Rx<bool>(false);

  @override
  void initState() {
    windowManager.addListener(this);
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  void onWindowMaximize() {
    this.isMaxingRx.value = true;
  }

  @override
  void onWindowUnmaximize() {
    this.isMaxingRx.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildHideIcon(),
        buildMinAndMaxIcon(),
        buildCloseIcon(),
      ],
    );
  }

  Widget buildHideIcon() {
    return WindowButton(
        icon: AssetsRes.ICON_WINDOW_HIDE,
        onTap: () async {
          bool isMinimized = await windowManager.isMinimized();
          if (isMinimized) {
            windowManager.restore();
          } else {
            windowManager.minimize();
          }
        });
  }

  Widget buildMinAndMaxIcon() {
    return Obx(() {
      bool isMaxing = isMaxingRx.value;
      return WindowButton(
        icon: isMaxing ? AssetsRes.ICON_WINDOW_MIN : AssetsRes.ICON_WINDOW_MAX,
        onTap: () async {
          if (isMaxing) {
            windowManager.unmaximize();
          } else {
            windowManager.maximize();
          }
        },
      );
    });
  }

  Widget buildCloseIcon() {
    return WindowButton(
      icon: AssetsRes.ICON_WINDOW_CLOSE,
      bgHoverColor: Color(0xffC42B1C),
      onTap: () => windowManager.close(),
    );
  }
}

class WindowButton extends StatelessWidget {
  final String icon;
  final Color bgHoverColor;
  final GestureTapCallback onTap;

  WindowButton({
    required this.icon,
    required this.onTap,
    this.bgHoverColor = const Color(0xFF3A3A3C),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: WindowHoverWidget(
        builder: (child, hover) {
          return Container(
            width: 50,
            height: 50,
            alignment: Alignment.center,
            color: hover ? bgHoverColor : Colors.transparent,
            child: child,
          );
        },
        child: Image.asset(
          icon,
          width: 25,
          height: 25,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
