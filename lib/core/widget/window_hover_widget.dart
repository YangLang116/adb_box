import 'package:flutter/material.dart';
import 'package:get/get.dart';

typedef Widget OnHoverBuilder(Widget child, bool hover);

class WindowHoverWidget extends StatelessWidget {
  final Widget child;
  final OnHoverBuilder builder;
  final _rxHover = RxBool(false);

  WindowHoverWidget({required this.builder, required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (e) => _rxHover.value = true,
      onExit: (e) => _rxHover.value = false,
      child: Obx(() {
        return builder.call(child, _rxHover.value);
      }),
    );
  }
}
