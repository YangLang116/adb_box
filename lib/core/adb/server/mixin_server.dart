import 'dart:io';

import 'package:adb_box/core/adb/adb.dart';

mixin ServerMixin on AdbExecutor {
  Future<bool> startServer() async {
    ProcessResult? result = await runCmd(['start-server']);
    return result?.exitCode == 0;
  }

  Future<bool> killServer() async {
    ProcessResult? result = await runCmd(['kill-server']);
    return result?.exitCode == 0;
  }

  Future<String?> getVersion() async {
    ProcessResult? result = await runCmd(['version']);
    if (result == null) return null;
    return result.exitCode == 0 ? result.stdout : result.stderr;
  }
}
