import 'package:adb_box/core/constant/color_constant.dart';
import 'package:adb_box/core/constant/font_constant.dart';
import 'package:animations/animations.dart';
import 'package:contextmenu/contextmenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Option {
  final String name;
  final GestureTapCallback onTap;

  Option({required this.name, required this.onTap});
}

void showContextMenu(Offset offset, List<Option> options) {
  showModal(
    context: Get.context!,
    configuration: FadeScaleTransitionConfiguration(
      barrierColor: Colors.transparent,
    ),
    builder: (context) => _ContextMenu(
      position: offset,
      builder: (context) {
        return options.map((op) => _OptionWidget(op)).toList();
      },
    ),
  );
}

const double _kWidth = 160;
const double _kOptHeight = 36;
const double _kBorderWidth = 1;

class _OptionWidget extends StatelessWidget {
  final Option opt;

  _OptionWidget(this.opt);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: ColorConstant.background,
        hoverColor: ColorConstant.primary,
        onTap: () {
          Get.back();
          opt.onTap.call();
        },
        child: Container(
          height: _kOptHeight,
          alignment: Alignment.center,
          child: Text(
            opt.name,
            style: TextStyle(
              color: ColorConstant.foreground,
              fontSize: FontConstant.H3,
            ),
          ),
        ),
      ),
    );
  }
}

class _ContextMenu extends StatefulWidget {
  final Offset position;

  final ContextMenuBuilder builder;

  const _ContextMenu({
    Key? key,
    required this.position,
    required this.builder,
  }) : super(key: key);

  @override
  _ContextMenuState createState() => _ContextMenuState();
}

class _ContextMenuState extends State<_ContextMenu> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final children = widget.builder(context);
    final height =
        children.length * _kOptHeight + _kBorderWidth * (children.length + 1);

    double paddingLeft = widget.position.dx;
    double paddingTop = widget.position.dy;
    double paddingRight = size.width - widget.position.dx - _kWidth;
    if (paddingRight < 0) {
      paddingLeft += paddingRight;
      paddingRight = 0;
    }
    double paddingBottom = size.height - widget.position.dy - height;
    if (paddingBottom < 0) {
      paddingTop += paddingBottom;
      paddingBottom = 0;
    }
    return AnimatedPadding(
      padding: EdgeInsets.fromLTRB(
        paddingLeft,
        paddingTop,
        paddingRight,
        paddingBottom,
      ),
      duration: Duration(milliseconds: 75),
      child: Material(
        elevation: 10,
        shadowColor: ColorConstant.primary,
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: ColorConstant.background,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: ColorConstant.border,
              width: _kBorderWidth,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: children.length,
              itemBuilder: (context, index) => children[index],
              separatorBuilder: (context, index) {
                return Divider(
                  color: ColorConstant.primary,
                  thickness: _kBorderWidth,
                  height: _kBorderWidth,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
