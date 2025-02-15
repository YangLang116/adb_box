import 'package:adb_box/core/adb/adb.dart';
import 'package:adb_box/core/widget/console/console_controller.dart';
import 'package:adb_box/core/widget/console/entity/console_log.dart';
import 'package:adb_box/core/widget/console/widget/console_widget.dart';
import 'package:adb_box/route/hall/tab/hall_tab_controller.dart';
import 'package:get/get.dart';

class DeviceTabController extends HallTabController {
  final _rxProps = Rx<Map<String, String>>({});

  Map<String, String> get props => _rxProps.value;

  final _consoleC = ConsoleController(canClear: false);

  ConsoleWidget get consoleWidget => ConsoleWidget(_consoleC);

  @override
  void onDeviceConnected(String serial) async {
    final props = await adb.getProps(serial);
    if (props == null) return;
    _rxProps.value = props;
    final logs = props.entries.map((entry) {
      return ConsoleLog.info('${entry.key}:${entry.value}');
    }).toList();
    _consoleC.clear();
    _consoleC.appendLogs(logs);
  }

  @override
  void onDeviceLost() {
    _rxProps.value = {};
    _consoleC.clear();
  }

  @override
  void onClose() {
    _consoleC.dispose();
    super.onClose();
  }
}
