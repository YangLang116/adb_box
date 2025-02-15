import 'dart:ui';

import 'package:get/get.dart';

class CapturePreviewController {
  final _rxMousePoint = Rx<Offset>(Offset.zero);

  Offset get mousePoint => _rxMousePoint.value;

  void updateMousePoint(Offset offset) {
    _rxMousePoint.value = offset;
  }
}
