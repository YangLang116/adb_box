import 'dart:async';
import 'dart:ui';

import 'package:adb_box/core/adb/adb.dart';
import 'package:adb_box/core/adb/device/entity/device.dart';
import 'package:adb_box/res/assets_res.dart';
import 'package:adb_box/route/hall/tab/capture/capture_tab_widget.dart';
import 'package:adb_box/route/hall/tab/cmd/cmd_tab_widget.dart';
import 'package:adb_box/route/hall/tab/device/device_tab_widget.dart';
import 'package:adb_box/route/hall/tab/logcat/logcat_tab_widget.dart';
import 'package:adb_box/route/hall/tab/script/script_tab_widget.dart';
import 'package:adb_box/route/hall/widget/docker/docker_option_widget.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

final _dockerOptions = [
  DockerOption(
    name: 'Device',
    icon: AssetsRes.ICON_DEVICE,
    content: DeviceTabWidget(),
  ),
  DockerOption(
    name: 'Cmd',
    icon: AssetsRes.ICON_CMD,
    content: CmdTabWidget(),
  ),
  DockerOption(
    name: 'Logcat',
    icon: AssetsRes.ICON_LOGCAT,
    content: LogcatTabWidget(),
  ),
  DockerOption(
    name: 'Capture',
    icon: AssetsRes.ICON_CAPTURE,
    content: CaptureTabWidget(),
  ),
  DockerOption(
    name: 'Script',
    icon: AssetsRes.ICON_SCRIPT,
    content: ScriptTabWidget(),
  ),
];

class HallController extends GetxController {
  final _rxSelectDevice = Rx<Device?>(null);

  Device? get selectDevice => _rxSelectDevice.value;

  String? get selectSerial => selectDevice?.serial;

  final _rxDeviceList = Rx<List<Device>>([]);

  List<Device> get deviceList => _rxDeviceList.value;

  final _rxShowDocker = Rx<bool>(false);

  bool get showDocker => _rxShowDocker.value;

  final _rxSelectOption = Rx<DockerOption>(_dockerOptions[0]);

  DockerOption get selectOption => _rxSelectOption.value;

  List<DockerOption> get options => _dockerOptions;

  final List<VoidCallback> _deviceChangedListeners = [];

  void addDeviceChangedListener(VoidCallback listener) {
    _deviceChangedListeners.add(listener);
  }

  void removeDeviceChangedListener(VoidCallback listener) {
    _deviceChangedListeners.remove(listener);
  }

  void _notifyDeviceChanged() {
    _deviceChangedListeners.forEach((action) => action.call());
  }

  static HallController get share => Get.find<HallController>();

  @override
  void onReady() {
    refreshDeviceList();
    super.onReady();
  }

  Future<void> refreshDeviceList() async {
    final scanResult = await adb.refreshDeviceList();
    if (scanResult == null || !scanResult.isSuccess) {
      _rxDeviceList.value = [];
      _rxSelectDevice.value = null;
      showToast(scanResult?.error ?? '获取设备列表失败');
      return;
    }
    final deviceList = scanResult.deviceList;
    _rxDeviceList.value = deviceList;
    Device? newSelectDevice = deviceList.isEmpty ? null : deviceList.first;
    String? newSerial = newSelectDevice?.serial;
    bool deviceChanged = newSerial != selectSerial;
    _rxSelectDevice.value = newSelectDevice;
    if (deviceChanged) _notifyDeviceChanged();
  }

  void onDeviceSelected(Device device) {
    _rxSelectDevice.value = device;
    _notifyDeviceChanged();
  }

  void onSelectOption(DockerOption option) {
    _rxSelectOption.value = option;
  }

  Timer? _showDockerTimer;
  Timer? _hideDockerTimer;

  void onFocusChanged(bool isFocus) {
    if (isFocus) {
      if (showDocker) {
        _hideDockerTimer?.cancel();
      } else {
        _showDockerTimer = Timer(Duration(milliseconds: 500), () {
          _rxShowDocker.value = true;
        });
      }
    } else {
      if (showDocker) {
        _hideDockerTimer = Timer(Duration(milliseconds: 500), () {
          _rxShowDocker.value = false;
        });
      } else {
        _showDockerTimer?.cancel();
      }
    }
  }
}
