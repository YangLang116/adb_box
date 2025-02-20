import 'dart:convert';
import 'dart:io';

import 'package:adb_box/core/adb/device/mixin_device.dart';
import 'package:adb_box/core/adb/device/mixin_input.dart';
import 'package:adb_box/core/adb/logcat/mixin_logcat.dart';
import 'package:adb_box/core/adb/server/mixin_server.dart';
import 'package:flutter/material.dart';

abstract class AdbExecutor {
  String? get adbPath;

  final String executable = 'adb.exe';

  Future<ProcessResult?> runCmd(List<String> cmdList, [String? serial]) async {
    if (adbPath == null) return null;
    if (serial != null) {
      cmdList.insertAll(0, ['-s', serial]);
    }
    debugPrint('[cmd] run: ${cmdList}');
    return Process.run(
      executable,
      cmdList,
      runInShell: false,
      workingDirectory: adbPath,
      stderrEncoding: Utf8Codec(),
      stdoutEncoding: Utf8Codec(),
    );
  }

  Future<Process?> listenCmd({
    required String serial,
    required List<String> cmdList,
    required ValueChanged<String> onReceive,
    required ValueChanged<String> onError,
  }) async {
    if (adbPath == null) return null;
    debugPrint('[cmd] start: ${cmdList}');
    Process process = await Process.start(
      executable,
      ['-s', serial, ...cmdList],
      runInShell: false,
      workingDirectory: adbPath,
    );
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

  String? _adbPath;

  @override
  String? get adbPath => _adbPath;

  void setAdbPath(String path) {
    _adbPath = path;
  }
}

final Adb adb = Adb._();
