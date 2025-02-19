import 'dart:io';

import 'package:adb_box/core/adb/adb.dart';

mixin InputMixin on AdbExecutor {
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
