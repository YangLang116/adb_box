import 'package:adb_box/core/adb/adb.dart';
import 'package:adb_box/route/setting/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class AppManager {
  AppManager._();

  Future<void> _ensureWindowReady() async {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = WindowOptions(
      size: Size(1280, 720),
      minimumSize: Size(1280, 720),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  Future<void> _ensureAdbReady() async {
    await SettingController.prepare();
    adb.setPath(SettingController.share.adbPath);
  }

  Future<void> ensureInitialized() async {
    await _ensureWindowReady();
    await _ensureAdbReady();
  }
}

final AppManager appManager = AppManager._();
