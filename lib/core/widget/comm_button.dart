import 'package:adb_box/core/constant/color_constant.dart';
import 'package:adb_box/core/constant/font_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Button extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final GestureTapCallback onTap;

  const Button({
    required this.width,
    required this.height,
    required this.text,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      hoverColor: ColorConstant.primary,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: ColorConstant.border, width: 1),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: FontConstant.H2,
            color: ColorConstant.foreground,
            height: 1,
          ),
        ),
      ),
    );
  }
}

class Link extends StatefulWidget {
  final String text;

  final GestureTapCallback onTap;

  const Link({
    required this.text,
    required this.onTap,
    super.key,
  });

  @override
  State<Link> createState() => _LinkState();
}

class _LinkState extends State<Link> {
  final _rxHover = RxBool(false);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (e) => _rxHover.value = true,
        onExit: (e) => _rxHover.value = false,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [_buildDot(), _buildLinkText()],
        ),
      ),
    );
  }

  Widget _buildDot() {
    return Obx(() {
      bool isHover = _rxHover.value;
      return Container(
        width: 3,
        height: 3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: isHover ? ColorConstant.selected : ColorConstant.foreground,
        ),
      );
    });
  }

  Widget _buildLinkText() {
    final text = widget.text;
    return Container(
      width: FontConstant.H2 * text.length * 1.8,
      height: FontConstant.H2,
      alignment: Alignment.center,
      child: Obx(() {
        bool isHover = _rxHover.value;
        return Text(
          isHover ? '[${text}]' : widget.text,
          style: TextStyle(
            height: 1,
            fontSize: FontConstant.H2,
            decorationColor: ColorConstant.selected,
            decorationStyle: TextDecorationStyle.solid,
            fontWeight: isHover ? FontWeight.bold : null,
            decoration: isHover ? TextDecoration.underline : null,
            color: isHover ? ColorConstant.selected : ColorConstant.foreground,
          ),
        );
      }),
    );
  }
}
