import 'package:adb_box/core/constant/color_constant.dart';
import 'package:flutter/material.dart';

class DockerOption {
  final String name;
  final String icon;
  final Widget content;

  DockerOption({
    required this.name,
    required this.icon,
    required this.content,
  });
}

class DockerOptionWidget extends StatelessWidget {
  final double width;
  final double height;
  final bool isFocus;
  final bool isSelect;
  final DockerOption option;

  DockerOptionWidget({
    required this.width,
    required this.height,
    required this.isFocus,
    required this.isSelect,
    required this.option,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isFocus ? 1 : 0.8,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.only(bottom: 8),
        child: Transform.translate(
          offset: Offset(0, isFocus ? -25 : 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildItem$Icon(),
              if (isFocus) _buildIcon$Label(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem$Icon() {
    Widget result = Image.asset(
      option.icon,
      width: 34,
      height: 34,
      fit: BoxFit.fill,
      color: isSelect ? ColorConstant.selected : null,
    );
    if (isFocus) {
      result = Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: ColorConstant.primary,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: ColorConstant.border, width: 1),
        ),
        alignment: Alignment.center,
        child: result,
      );
    }
    return result;
  }

  Widget _buildIcon$Label() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Text(
        option.name,
        softWrap: true,
        style: TextStyle(
          color: isSelect ? ColorConstant.selected : Colors.white,
          fontSize: 13,
          height: 1.2,
        ),
      ),
    );
  }
}
