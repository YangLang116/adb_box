import 'dart:io';

import 'package:adb_box/core/adb/adb.dart';
import 'package:adb_box/core/adb/constant/adb_constant.dart';
import 'package:adb_box/core/adb/device/entity/scan_result.dart';

mixin DeviceMixin on AdbExecutor {
  Future<bool> shutdown() async {
    ProcessResult? result = await runCmd(['shutdown']);
    return result != null;
  }

  Future<bool> reboot() async {
    ProcessResult? result = await runCmd(['reboot']);
    return result != null;
  }

  Future<Map<String, String>?> getProps(String serial) async {
    ProcessResult? result = await runCmd(
      ['shell', 'getprop'],
      serial,
    );
    if (result == null) return null;
    final props = <String, String>{};
    if (result.exitCode == 0) {
      final RegExp reg = RegExp(r'^\[(.+)\].+\[(.+)\]$');
      List<String> lines = result.stdout.split(AdbConstant.separator);
      for (String line in lines) {
        RegExpMatch? match = reg.firstMatch(line);
        if (match == null || match.groupCount != 2) continue;
        props[match.group(1)!] = match.group(2)!;
      }
    }
    return props;
  }

  Future<DeviceScanResult?> refreshDeviceList() async {
    ProcessResult? result = await runCmd(['devices', '-l']);
    if (result == null) return null;
    return DeviceScanResult.create(result);
  }

  Future<bool> pull(String serial, String remotePath, String localPath) async {
    ProcessResult? result = await runCmd(
      ['pull', remotePath, localPath],
      serial,
    );
    return result?.exitCode == 0;
  }

  Future<bool> push(String serial, String localPath, String remotePath) async {
    ProcessResult? result = await runCmd(
      ['push', localPath, remotePath],
      serial,
    );
    return result?.exitCode == 0;
  }

  Future<bool> screenshot(String serial, String savePath) async {
    ProcessResult? result = await runCmd(
      ['shell', 'screencap', savePath],
      serial,
    );
    return result?.exitCode == 0;
  }

  Future<bool> installApk(String serial, String apkPath) async {
    ProcessResult? result = await runCmd(
      ['install', apkPath],
      serial,
    );
    return result?.exitCode == 0;
  }

  Future<bool> inputText(String serial, String text) async {
    ProcessResult? result = await runCmd(
      ['shell', 'input', 'text', text],
      serial,
    );
    return result?.exitCode == 0;
  }

  Future<bool> inputTap(String serial, int x, int y) async {
    ProcessResult? result = await runCmd(
      ['shell', 'input', 'tap', x.toString(), y.toString()],
      serial,
    );
    return result?.exitCode == 0;
  }

  Future<bool> inputSwipe(String serial, int x1, int y1, int x2, int y2) async {
    ProcessResult? result = await runCmd([
      'shell',
      'input',
      'swipe',
      x1.toString(),
      y1.toString(),
      x2.toString(),
      y2.toString()
    ], serial);
    return result?.exitCode == 0;
  }

  Future<bool> inputRoll(String serial, int deltaX, int deltaY) async {
    ProcessResult? result = await runCmd(
      ['shell', 'input', 'roll', deltaX.toString(), deltaY.toString()],
      serial,
    );
    return result?.exitCode == 0;
  }

  Future<bool> inputKeyCode(String serial, int keyCode) async {
    ProcessResult? result = await runCmd(
      ['shell', 'input', 'keyevent', keyCode.toString()],
      serial,
    );
    return result?.exitCode == 0;
  }
}
