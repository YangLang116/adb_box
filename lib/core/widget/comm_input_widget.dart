import 'package:adb_box/core/constant/color_constant.dart';
import 'package:adb_box/core/constant/font_constant.dart';
import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final String hint;
  final String? prefixIcon;
  final Widget? prefixWidget;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final ValueChanged<String>? onSubmit;

  const InputWidget({
    this.controller,
    this.prefixIcon,
    this.prefixWidget,
    this.hint = '',
    this.focusNode,
    this.onSubmit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: ColorConstant.background,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: ColorConstant.border, width: 1),
      ),
      child: Row(
        children: [
          prefixWidget ?? _buildPrefixIcon(),
          Expanded(child: _buildInput()),
        ],
      ),
    );
  }

  Widget _buildPrefixIcon() {
    if (prefixIcon == null) return SizedBox();
    return Container(
      margin: EdgeInsets.only(left: 5),
      child: Image.asset(
        prefixIcon!,
        width: 24,
        height: 24,
        color: ColorConstant.hint,
      ),
    );
  }

  Widget _buildInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: TextField(
        controller: controller,
        cursorColor: ColorConstant.cursor,
        cursorHeight: 18,
        focusNode: focusNode,
        style: TextStyle(
          fontSize: FontConstant.H2,
          color: ColorConstant.foreground,
        ),
        decoration: InputDecoration(
          isCollapsed: true,
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(
            color: ColorConstant.hint,
            fontSize: FontConstant.hint,
          ),
        ),
        onSubmitted: onSubmit,
      ),
    );
  }
}
