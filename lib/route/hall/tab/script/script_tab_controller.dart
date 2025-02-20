import 'package:adb_box/core/widget/console/console_controller.dart';
import 'package:adb_box/core/widget/console/widget/console_widget.dart';
import 'package:adb_box/route/hall/tab/hall_tab_controller.dart';
import 'package:adb_box/route/hall/tab/script/core/script.dart';
import 'package:adb_box/route/hall/tab/script/script/script_switch_screen.dart';
import 'package:adb_box/route/setting/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

final _supportScripts = <Script>[
  ScriptSwitchScreen(),
];

class ScriptTabController extends HallTabController {
  final _consoleC = ConsoleController();

  Widget get consoleWidget => ConsoleWidget(_consoleC);

  List<Script> get supportScripts => _supportScripts;

  final _rxSelectScript = Rx<Script?>(null);

  Script? get selectScript => _rxSelectScript.value;

  void onSelectScript(Script script) {
    if (!isConnected) {
      showToast('请选择设备');
      return;
    }
    selectScript?.stop();
    _consoleC.clear();
    _rxSelectScript.value = script;
    script.start(SettingController.share.adbPath, serial, _consoleC);
  }

  @override
  void onClose() {
    selectScript?.stop();
    _consoleC.dispose();
    super.onClose();
  }
}
