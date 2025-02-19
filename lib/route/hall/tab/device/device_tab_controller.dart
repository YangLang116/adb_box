import 'package:adb_box/core/adb/adb.dart';
import 'package:adb_box/route/hall/tab/hall_tab_controller.dart';
import 'package:get/get.dart';

class DeviceTabController extends HallTabController {
  final _rxProps = Rx<Map<String, String>>({});
  final _rxDisplay = Rx<Map<String, String>>({});
  final _rxCPU = Rx<Map<String, dynamic>>({});
  final _rxBattery = Rx<Map<String, Map<String, String>>>({});

  Map<String, String> get props => _rxProps.value;

  Map<String, String> get display => _rxDisplay.value;

  Map<String, dynamic> get cpu => _rxCPU.value;

  Map<String, Map<String, String>> get battery => _rxBattery.value;

  @override
  void onDeviceConnected(String serial) async {
    adb.getProps(serial).then((props) {
      _rxProps.value = props;
    });
    adb.getCpuInfo(serial).then((cpu) {
      _rxCPU.value = cpu;
    });
    adb.getBatteryInfo(serial).then((battery) {
      _rxBattery.value = battery;
    });
    adb.getDisplayInfo(serial).then((display) {
      _rxDisplay.value = display;
    });
  }

  @override
  void onDeviceLost() {
    _rxProps.value = {};
    _rxCPU.value = {};
    _rxBattery.value = {};
  }

  @override
  void onClose() {
    super.onClose();
  }
}
