import 'package:adb_box/core/adb/constant/adb_constant.dart';
import 'package:adb_box/core/mixin/mixin_list_scroll.dart';
import 'package:adb_box/core/queue/msg_queue.dart';
import 'package:adb_box/core/widget/console/entity/console_log.dart';
import 'package:adb_box/core/widget/window_menu_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

abstract class Console {
  void appendInfos(String info);

  void appendErrors(String error);
}

class ConsoleController extends GetxController
    with ListScrollMixin
    implements Console {
  //是否能清除
  final bool canClear;

  final consoleNode = FocusNode();

  final searchBarNode = FocusNode();

  final textC = TextEditingController();

  final _rxShowSearchBar = Rx<bool>(false);

  bool get showSearchBar => _rxShowSearchBar.value;

  final _rxSearchWord = Rx<String?>(null);

  String? get searchWord => _rxSearchWord.value;

  final _logQueue = MsgQueue<ConsoleLog>(3000);

  List<ConsoleLog> get logs {
    if (searchWord?.isNotEmpty != true) {
      return _logQueue.msgList;
    }
    return _logQueue.msgList.where((log) => log.contains(searchWord!)).toList();
  }

  @override
  bool get isRevertList => logs.length > 50;

  ConsoleController({this.canClear = true}) {
    textC.addListener(() => _updateSearchWord(textC.text.trim()));
  }

  @override
  void appendInfos(String infos) {
    final infoList = infos.split(AdbConstant.separator).map((text) {
      return ConsoleLog.info(text);
    }).toList();
    appendLogs(infoList);
  }

  @override
  void appendErrors(String errors) {
    final errList = errors.split(AdbConstant.separator).map((text) {
      return ConsoleLog.err(text);
    }).toList();
    appendLogs(errList);
  }

  void appendLogs(List<ConsoleLog> logs) {
    bool needToBottom = _logQueue.addLogs(logs);
    if (needToBottom) moveToBottom();
  }

  void showMenu(BuildContext context, PointerDownEvent e) {
    showContextMenu(e.position, [
      if (canClear) Option(name: 'Clear', onTap: clear),
      Option(name: 'Copy', onTap: _logQueue.copy),
      Option(name: 'Search', onTap: () => updateSearchBar(true)),
      Option(name: 'Scroll To Start', onTap: moveToStart),
      Option(name: 'Scroll To End', onTap: moveToBottom),
    ]);
  }

  void updateSearchBar(bool visibility) {
    _rxShowSearchBar.value = visibility;
    final focusNode = visibility ? searchBarNode : consoleNode;
    SchedulerBinding.instance.addPostFrameCallback(
      (t) => focusNode.requestFocus(),
    );
    if (!visibility) _updateSearchWord(null);
  }

  void _updateSearchWord(String? searchWord) {
    _rxSearchWord.value = searchWord;
  }

  void clear() => _logQueue.clear();

  @override
  void dispose() {
    scrollC.dispose();
    textC.dispose();
    consoleNode.dispose();
    searchBarNode.dispose();
    super.dispose();
  }
}
