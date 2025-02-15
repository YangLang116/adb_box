import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MsgQueue<T> {
  final int maxCount;
  final _rxMsgList = Rx<List<T>>([]);

  bool _freeze = false;

  List<T> get msgList => _rxMsgList.value;

  MsgQueue(this.maxCount);

  bool addLogs(List<T> logs) {
    final list = _rxMsgList.value;
    list.addAll(logs);
    if (_freeze) return false;
    if (list.length > maxCount) {
      list.removeRange(0, list.length - maxCount);
    }
    _rxMsgList.refresh();
    return true;
  }

  void freezeUI(bool freeze) {
    _freeze = freeze;
  }

  void copy() {
    String content = msgList.map((e) => e.toString()).join('\n');
    ClipboardData data = ClipboardData(text: content);
    Clipboard.setData(data);
  }

  void clear() {
    _rxMsgList.value = [];
  }
}
