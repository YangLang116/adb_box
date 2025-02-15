import 'package:adb_box/core/constant/color_constant.dart';
import 'package:adb_box/route/hall/widget/docker/docker_option_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

double _OptionWidth = 70;
double _OptionHeight = 100;
double _BottomGap = 10;

class DockerWidget extends StatefulWidget {
  final bool visibility;
  final DockerOption selectOption;
  final List<DockerOption> options;
  final ValueChanged<DockerOption> onSelected;
  final ValueChanged<bool> onFocusChanged;

  DockerWidget({
    required this.visibility,
    required this.selectOption,
    required this.options,
    required this.onSelected,
    required this.onFocusChanged,
    super.key,
  });

  @override
  State<DockerWidget> createState() => _DockerWidgetState();
}

class _DockerWidgetState extends State<DockerWidget> {
  List<DockerOption> get options => widget.options;

  int get optionCount => options.length;

  final _rxFocusOption = Rx<DockerOption?>(null);

  void _switchOption(Offset position) {
    if (widget.visibility) {
      int index = position.dx ~/ _OptionWidth;
      _rxFocusOption.value = options[index];
    }
  }

  void _tapOption(Offset position) {
    int index = position.dx ~/ _OptionWidth;
    final option = options[index];
    widget.onSelected.call(option);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (e) {
        widget.onFocusChanged.call(true);
        _switchOption(e.localPosition);
      },
      onExit: (e) {
        _rxFocusOption.value = null;
        widget.onFocusChanged.call(false);
      },
      onHover: (e) => _switchOption(e.localPosition),
      child: Listener(
        onPointerUp: (e) => _tapOption(e.localPosition),
        child: Container(
          width: _OptionWidth * optionCount,
          height: _OptionHeight + _BottomGap,
          padding: EdgeInsets.only(bottom: _BottomGap),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [_buildDockerBg(), _buildOptionList()],
          ),
        ),
      ),
    );
  }

  Widget _buildDockerBg() {
    return Container(
      width: _OptionWidth * optionCount,
      height: _OptionHeight / 2,
      decoration: BoxDecoration(
        color: ColorConstant.primary,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: ColorConstant.border,
          width: 1,
        ),
      ),
    );
  }

  Widget _buildOptionList() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: widget.options.map(_buildOption).toList(),
    );
  }

  Widget _buildOption(DockerOption op) {
    return Obx(() {
      return DockerOptionWidget(
        width: _OptionWidth,
        height: _OptionHeight,
        option: op,
        isFocus: _rxFocusOption.value == op,
        isSelect: widget.selectOption == op,
      );
    });
  }
}
