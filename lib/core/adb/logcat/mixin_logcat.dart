import 'dart:io';

import 'package:adb_box/core/adb/adb.dart';
import 'package:adb_box/core/adb/logcat/entity/log_level.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';

mixin LogcatMixin on AdbExecutor {
  Future<Process?> logcat({
    required String serial,
    String? tag,
    String? regex,
    LogLevel level = LogLevel.Verbose,
    required ValueChanged<String> onReceive,
    required ValueChanged<String> onError,
  }) async {
    final cmdList = ['logcat', '-v', 'time'];
    //设置正则过滤
    if (StringUtils.isNotNullOrEmpty(regex)) {
      cmdList.addAll(['-e', regex!]);
    }
    //设置过滤Tag和级别
    String tagValue = StringUtils.isNullOrEmpty(tag) ? '*' : tag!;
    cmdList.add("${tagValue}:${level.value}");
    return listenCmd(
      serial: serial,
      cmdList: cmdList,
      onError: onError,
      onReceive: onReceive,
    );
  }
}
