import 'dart:convert';
import 'dart:io';

import 'package:adb_box/core/adb/device/mixin_device.dart';
import 'package:adb_box/core/adb/device/mixin_input.dart';
import 'package:adb_box/core/adb/logcat/mixin_logcat.dart';
import 'package:adb_box/core/adb/server/mixin_server.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

abstract class AdbExecutor {
  late String _executable;

  Future<ProcessResult?> runCmd(List<String> cmdList, [String? serial]) async {
    if (serial != null) cmdList.insertAll(0, ['-s', serial]);
    debugPrint('[cmd] run: ${cmdList}');
    final codec = Utf8Codec();
    return Process.run(
      _executable,
      cmdList,
      stderrEncoding: codec,
      stdoutEncoding: codec,
    );
  }

  Future<Process?> listenCmd({
    String? serial,
    required List<String> cmdList,
    required ValueChanged<String> onReceive,
    required ValueChanged<String> onError,
  }) async {
    if (serial != null) cmdList.insertAll(0, ['-s', serial]);
    debugPrint('[cmd] start: ${cmdList}');
    Process process = await Process.start(_executable, cmdList);
    process.stdout.map(String.fromCharCodes).forEach(onReceive);
    process.stderr.map(String.fromCharCodes).forEach(onError);
    return process;
  }

  bool stopCmd(Process? process) {
    if (process == null) return false;
    debugPrint('[cmd] stop');
    return process.kill();
  }
}

class Adb extends AdbExecutor
    with ServerMixin, DeviceMixin, InputMixin, LogcatMixin {
  Adb._();

  void setPath(String path) {
    _executable = p.join(path, Platform.isWindows ? 'adb.exe' : 'adb');
  }
}

final Adb adb = Adb._();
