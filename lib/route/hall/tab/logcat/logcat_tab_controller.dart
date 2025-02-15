import 'dart:io';

import 'package:adb_box/core/adb/adb.dart';
import 'package:adb_box/core/adb/logcat/entity/log.dart';
import 'package:adb_box/core/adb/logcat/entity/log_level.dart';
import 'package:adb_box/core/mixin/mixin_list_scroll.dart';
import 'package:adb_box/core/queue/msg_queue.dart';
import 'package:adb_box/core/widget/window_menu_dialog.dart';
import 'package:adb_box/route/hall/tab/hall_tab_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogcatTabController extends HallTabController with ListScrollMixin {
  Process? _process;

  final tagC = TextEditingController();
  final regexC = TextEditingController();
  final rxSearchLevel = Rx<LogLevel>(LogLevel.Verbose);

  final _logQueue = MsgQueue<Log>(3000);

  List<Log> get logs => _logQueue.msgList;

  @override
  bool get isRevertList => logs.length > 50;

  @override
  void onReady() {
    scrollC.addListener(() => _logQueue.freezeUI(scrollC.offset > 30));
    super.onReady();
  }

  @override
  void onClose() {
    scrollC.dispose();
    tagC.dispose();
    regexC.dispose();
    _shutdown();
    super.onClose();
  }

  @override
  void onDeviceConnected(String serial) => _execLogcat(serial);

  @override
  void onDeviceLost() => _clearLog();

  void logcat() async {
    if (isConnected) _execLogcat(serial);
  }

  void _execLogcat(String serial) async {
    _clearLog();
    _process = await adb.logcat(
      serial: serial,
      tag: tagC.text,
      regex: regexC.text,
      level: rxSearchLevel.value,
      onError: (err) {
        final log = Log(level: LogLevel.Error, content: err);
        _appendLogs([log]);
      },
      onReceive: (line) {
        final logs = Log.parseLogs(line);
        _appendLogs(logs);
      },
    );
  }

  void _appendLogs(List<Log> logs) {
    bool needToBottom = _logQueue.addLogs(logs);
    if (needToBottom) moveToBottom();
  }

  void _clearLog() {
    _shutdown();
    _logQueue.clear();
  }

  void _shutdown() => adb.stopCmd(_process);

  void showMenu(BuildContext context, PointerDownEvent e) {
    showContextMenu(e.position, [
      Option(name: 'Clear', onTap: _logQueue.clear),
      Option(name: 'Copy', onTap: _logQueue.copy),
      Option(name: 'Scroll To Start', onTap: moveToStart),
      Option(name: 'Scroll To End', onTap: moveToBottom),
    ]);
  }
}
