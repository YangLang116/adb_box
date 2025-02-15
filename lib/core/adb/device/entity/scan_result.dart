import 'dart:io';

import 'package:adb_box/core/adb/constant/adb_constant.dart';
import 'package:adb_box/core/adb/device/entity/device.dart';

class DeviceScanResult {
  final bool isSuccess;
  final String? error;
  final List<Device> deviceList;

  DeviceScanResult.fail(this.error)
      : isSuccess = false,
        deviceList = [];

  DeviceScanResult.success(this.deviceList)
      : isSuccess = true,
        error = null;

  static DeviceScanResult create(ProcessResult result) {
    if (result.exitCode == 0) {
      List<Device> list = (result.stdout as String)
          .split(AdbConstant.separator)
          .map((line) => line.trim())
          .where((line) => line.isNotEmpty)
          .where((line) => !line.contains('List of devices'))
          .map((line) => Device.create(line))
          .toList(growable: false);
      return DeviceScanResult.success(list);
    } else {
      return DeviceScanResult.fail(result.stderr);
    }
  }
}
