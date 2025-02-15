import 'package:adb_box/core/constant/color_constant.dart';
import 'package:adb_box/core/widget/comm_label_widget.dart';
import 'package:flutter/material.dart';

class AreaWidget extends StatelessWidget {
  final String title;
  final Widget child;

  const AreaWidget({
    required this.title,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: ColorConstant.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [LabelWidget(title), child],
      ),
    );
  }
}
