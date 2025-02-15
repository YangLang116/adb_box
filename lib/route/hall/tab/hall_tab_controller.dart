import 'package:adb_box/route/hall/hall_controller.dart';
import 'package:adb_box/route/setting/setting_controller.dart';
import 'package:get/get.dart';

class HallTabController extends GetxController {
  String get serial => HallController.share.selectSerial ?? '';

  bool get isConnected => serial.isNotEmpty;

  String get adbPath {
    return SettingController.share.adbPath;
  }

  @override
  void onReady() {
    HallController.share.addDeviceChangedListener(_loadDataIfValid);
    _loadDataIfValid();
    super.onReady();
  }

  @override
  void onClose() {
    HallController.share.removeDeviceChangedListener(_loadDataIfValid);
    super.onClose();
  }

  void _loadDataIfValid() {
    isConnected ? onDeviceConnected(serial) : onDeviceLost();
  }

  void onDeviceConnected(String serial) {}

  void onDeviceLost() {}
}
