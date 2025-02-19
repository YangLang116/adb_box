import 'package:adb_box/core/adb/adb.dart';
import 'package:adb_box/core/adb/device/entity/device.dart';
import 'package:adb_box/core/adb/device/entity/wifi_connect_info.dart';
import 'package:adb_box/route/hall/hall_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:oktoast/oktoast.dart';

class WifiConnectController {
  final HallController hallController;
  final textC = TextEditingController();

  WifiConnectController(this.hallController);

  List<Device> get wifiDeviceList {
    return hallController.deviceList.where((device) {
      return device.isWifiConnect;
    }).toList();
  }

  void addDevice(String info) async {
    WifiConnectInfo? connectInfo = WifiConnectInfo.create(info);
    if (connectInfo == null) {
      showToast('连接格式错误');
      return;
    }
    bool isSuccess = await adb.connect(connectInfo.ip, connectInfo.host);
    if (isSuccess) {
      textC.clear();
      showToast('连接成功');
      _refreshDevice();
    } else {
      showToast('连接失败');
    }
  }

  void removeDevice(Device device) async {
    WifiConnectInfo? connectInfo = WifiConnectInfo.create(device.serial);
    if (connectInfo == null) return;
    bool isSuccess = await adb.disconnect(connectInfo.ip, connectInfo.host);
    if (isSuccess) {
      showToast('断开连接成功');
      _refreshDevice();
    } else {
      showToast('断开连接失败');
    }
  }

  void _refreshDevice() {
    hallController.refreshDeviceList();
  }

  void dispose() {
    textC.dispose();
  }
}
