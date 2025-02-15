import 'package:flutter/gestures.dart';

extension PointerEventExt on PointerEvent {
  bool get isMouseRightBtnClick =>
      kind == PointerDeviceKind.mouse && buttons == kSecondaryButton;

  bool get isMouseLeftBtnClick =>
      kind == PointerDeviceKind.mouse && buttons == kPrimaryMouseButton;
}
