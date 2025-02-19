import 'package:adb_box/core/constant/color_constant.dart';
import 'package:adb_box/core/constant/font_constant.dart';
import 'package:flutter/material.dart';

class CommonDialog extends StatelessWidget {
  final double width;
  final double height;
  final IconData icon;
  final String name;
  final Widget child;

  const CommonDialog({
    required this.width,
    required this.height,
    required this.icon,
    required this.name,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Material(
        elevation: 10,
        color: Colors.transparent,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: ColorConstant.background,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: ColorConstant.hint, width: 1),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Scaffold(
              appBar: _Bar(icon: icon, name: name),
              body: Padding(padding: EdgeInsets.all(16), child: child),
            ),
          ),
        ),
      ),
    );
  }
}

class _Bar extends StatelessWidget implements PreferredSizeWidget {
  final IconData icon;
  final String name;

  _Bar({required this.icon, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstant.primary,
      padding: EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [buildIcon(), SizedBox(width: 5), buildName()],
      ),
    );
  }

  Widget buildIcon() {
    return Icon(icon, size: 22, color: ColorConstant.foreground);
  }

  Widget buildName() {
    return Text(
      name,
      style: TextStyle(
        fontSize: FontConstant.H4,
        fontWeight: FontWeight.bold,
        color: ColorConstant.foreground,
        height: 1,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(40);
}
