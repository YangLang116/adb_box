import 'package:flutter/cupertino.dart';

mixin ListScrollMixin {
  ScrollController scrollC = ScrollController();

  bool get isRevertList => false;

  void moveToStart() async {
    _moveToPosition((position) {
      return isRevertList ? position.maxScrollExtent : 0;
    });
  }

  void moveToBottom() async {
    _moveToPosition((position) {
      return isRevertList ? 0 : position.maxScrollExtent;
    });
  }

  void _moveToPosition(double getOffset(ScrollPosition position)) async {
    Future.delayed(Duration(milliseconds: 200), () {
      if (scrollC.positions.isEmpty) return;
      final position = scrollC.position;
      position.animateTo(
        getOffset(position),
        duration: Duration(milliseconds: 200),
        curve: Curves.linear,
      );
    });
  }
}
