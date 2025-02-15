import 'dart:io';

import 'package:adb_box/core/adb/adb.dart';
import 'package:adb_box/core/widget/console/console_controller.dart';
import 'package:adb_box/core/widget/console/widget/console_widget.dart';
import 'package:adb_box/route/hall/tab/cmd/entity/cmd.dart';
import 'package:adb_box/route/hall/tab/hall_tab_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final _supportOptions = [
  Cmd(
    name: 'Version',
    value: 'version',
    hint: 'get adb version',
    argType: CmdArgType.none,
  ),
  Cmd(
    name: 'Install APK',
    value: 'install',
    hint: 'apk path',
    argType: CmdArgType.file,
  ),
  Cmd(
    name: 'Custom Cmd',
    value: '',
    hint: 'adb cmd',
    argType: CmdArgType.text,
  ),
];

class CmdTabController extends HallTabController {
  Process? _process;

  List<Cmd> get supportOptions => _supportOptions;

  final _consoleC = ConsoleController();

  final _rxSelectCmd = Rx<Cmd?>(null);

  Cmd? get selectCmd => _rxSelectCmd.value;

  Widget get console => ConsoleWidget(_consoleC);

  void onSelectCmd(Cmd cmd) {
    _shutdown();
    _consoleC.clear();
    _rxSelectCmd.value = cmd;
    if (!cmd.needArg) executeCmd(cmd);
  }

  void executeCmd(Cmd selectCmd, [String? arg]) async {
    if (!isConnected) return;
    final cmdList = <String>[
      if (selectCmd.value.isNotEmpty) selectCmd.value,
      if (arg?.trim().isNotEmpty == true) arg!,
    ];
    _process = await adb.listenCmd(
      serial: serial,
      cmdList: cmdList,
      onReceive: _consoleC.appendInfos,
      onError: _consoleC.appendErrors,
    );
  }

  @override
  void onClose() {
    _shutdown();
    _consoleC.dispose();
    super.onClose();
  }

  void _shutdown() {
    adb.stopCmd(_process);
  }
}
