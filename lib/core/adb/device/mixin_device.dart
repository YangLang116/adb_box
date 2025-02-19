import 'dart:io';

import 'package:adb_box/core/adb/adb.dart';
import 'package:adb_box/core/adb/constant/adb_constant.dart';
import 'package:adb_box/core/adb/device/entity/scan_result.dart';

mixin DeviceMixin on AdbExecutor {
  Future<bool> connect(String ip, int host) async {
    ProcessResult? result = await runCmd(['connect', '${ip}:${host}']);
    return result?.exitCode == 0;
  }

  Future<bool> disconnect(String ip, int host) async {
    ProcessResult? result = await runCmd(['disconnect', '${ip}:${host}']);
    return result?.exitCode == 0;
  }

  Future<bool> shutdown() async {
    ProcessResult? result = await runCmd(['shutdown']);
    return result != null;
  }

  Future<bool> reboot() async {
    ProcessResult? result = await runCmd(['reboot']);
    return result != null;
  }

  Future<DeviceScanResult?> refreshDeviceList() async {
    ProcessResult? result = await runCmd(['devices', '-l']);
    if (result == null) return null;
    return DeviceScanResult.create(result);
  }

  Future<Map<String, String>> getProps(String serial) async {
    ProcessResult? result = await runCmd(
      ['shell', 'getprop'],
      serial,
    );
    if (result == null || result.exitCode != 0) return {};
    final props = <String, String>{};
    final RegExp reg = RegExp(r'^\[(.+)\].+\[(.+)\]$');
    List<String> lines = result.stdout.split(AdbConstant.separator);
    for (String line in lines) {
      if (line.isEmpty) continue;
      RegExpMatch? match = reg.firstMatch(line);
      if (match == null || match.groupCount != 2) continue;
      props[match.group(1)!] = match.group(2)!;
    }
    return props;
  }

  Future<Map<String, dynamic>> getCpuInfo(String serial) async {
    ProcessResult? result = await runCmd(
      ['shell', 'cat', '/proc/cpuinfo'],
      serial,
    );
    if (result == null || result.exitCode != 0) return {};
    final props = <String, dynamic>{};
    List<String> lines = result.stdout.split(AdbConstant.separator);
    for (final line in lines) {
      if (line.isEmpty) continue;
      List<String> pair = line.split(':');
      String key = pair[0].trim();
      String value = pair[1].trim();
      final oldValue = props[key];
      if (oldValue == null) {
        props[key] = value;
      } else if (oldValue is List) {
        oldValue.add(value);
      } else {
        props[key] = [oldValue, value];
      }
    }
    return props;
  }

  Future<Map<String, Map<String, String>>> getBatteryInfo(String serial) async {
    ProcessResult? result = await runCmd(
      ['shell', 'dumpsys', 'battery'],
      serial,
    );
    if (result == null || result.exitCode != 0) return {};
    String currentKey = '';
    final props = <String, Map<String, String>>{};
    List<String> lines = result.stdout.split(AdbConstant.separator);
    for (final line in lines) {
      if (line.isEmpty) continue;
      List<String> pair = line.split(':');
      String key = pair[0].trim();
      String value = pair[1].trim();
      if (value.isEmpty) {
        currentKey = key;
      } else {
        props[currentKey] ??= {};
        props[currentKey]![key] = value;
      }
    }
    return props;
  }

  Future<Map<String, String>> getDisplayInfo(String serial) async {
    ProcessResult? result = await runCmd(
      ['shell', 'dumpsys', 'window', 'displays'],
      serial,
    );
    if (result == null || result.exitCode != 0) return {};
    final props = <String, String>{};
    final RegExp reg = RegExp(r'init=(.+) (\d+)dpi cur=(.+) app=(.+) rng=');
    RegExpMatch? match = reg.firstMatch(result.stdout);
    if (match != null && match.groupCount == 4) {
      props['init'] = match.group(1)!;
      props['dpi'] = match.group(2)!;
      props['cur'] = match.group(3)!;
      props['app'] = match.group(4)!;
    }
    return props;
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
}
