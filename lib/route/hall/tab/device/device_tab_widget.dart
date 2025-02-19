import 'package:adb_box/route/hall/tab/device/device_tab_controller.dart';
import 'package:adb_box/route/hall/tab/device/widget/device_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeviceTabWidget extends StatefulWidget {
  const DeviceTabWidget({super.key});

  @override
  State<DeviceTabWidget> createState() => _DeviceTabWidgetState();
}

class _DeviceTabWidgetState extends State<DeviceTabWidget> {
  late DeviceTabController controller;

  @override
  void initState() {
    controller = Get.put(DeviceTabController());
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<DeviceTabController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSystemProps('基本信息', [
              {'name': '厂商', 'key': 'ro.product.brand'},
              {'name': '型号', 'key': 'ro.product.name'},
              {'name': '设备', 'key': 'ro.product.device'},
              {'name': '语言', 'key': 'ro.product.locale'},
              {'name': '架构', 'key': 'ro.product.cpu.abi'},
              {'name': '序列号', 'key': 'ro.serialno'},
            ]),
            _buildSystemProps('版本信息', [
              {'name': '厂商版本', 'key': 'ro.build.version.oplusrom'},
              {'name': 'Android 版本', 'key': 'ro.build.version.release'},
              {'name': 'SDK 版本', 'key': 'ro.build.version.sdk'},
              {
                'name': 'SDK 最低兼容版本',
                'key': 'ro.build.version.min_supported_target_sdk'
              },
            ]),
            _buildDisplayInfo(),
            _buildCPUInfo(),
            _buildBatteryInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildSystemProps(String title, List<Map<String, String>> meta) {
    return Obx(() {
      final props = controller.props;
      final metaList = meta.map((data) {
        return DeviceInfo(name: data['name']!, value: props[data['key']!]);
      }).toList();
      return DeviceInfoCardWidget(title, metaList);
    });
  }

  Widget _buildCPUInfo() {
    return Obx(() {
      final cpu = controller.cpu;
      if (cpu.isEmpty) return SizedBox();
      final metaList = <DeviceInfo>[
        DeviceInfo(name: '架构', value: cpu['Hardware'] ?? 'UnKnown'),
      ];
      String cpuCoreNum = 'UnKnown';
      final processor = cpu['processor'];
      if (processor is List) {
        int num = processor.length;
        cpuCoreNum = num == 1 ? '单核' : '${num}核';
      }
      metaList.add(DeviceInfo(name: '核数', value: cpuCoreNum));
      return DeviceInfoCardWidget('CPU信息', metaList);
    });
  }

  Widget _buildBatteryInfo() {
    return Obx(() {
      final battery = controller.battery['Current Battery Service state'];
      if (battery == null || battery.isEmpty) return SizedBox();
      final metaList = <DeviceInfo>[];
      final isCharge = battery['status'] == '2';
      metaList.add(DeviceInfo(
        name: '状态',
        value: isCharge ? '充电中' : '未充电',
      ));
      if (isCharge) {
        String chargeWay = 'UnKnown';
        if (battery['AC powered'] == 'true') {
          chargeWay = '交流供电';
        } else if (battery['USB powered'] == 'true') {
          chargeWay = 'USB供电';
        } else if (battery['Wireless powered'] == 'true') {
          chargeWay = '无线供电';
        }
        metaList.add(DeviceInfo(name: '充电方式', value: chargeWay));
      }

      metaList.add(DeviceInfo(
        name: '当前电量',
        value: '${battery['level']}%',
      ));
      double temperature = int.parse(battery['temperature'] ?? '0') * 0.1;
      metaList.add(DeviceInfo(
        name: '温度',
        value: '${temperature.toStringAsFixed(1)}℃',
      ));
      metaList.add(DeviceInfo(
        name: '循环次数',
        value: battery['Charge counter'] ?? 'UnKnown',
      ));
      metaList.add(DeviceInfo(
        name: '健康度',
        value: battery['health'] == '2' ? '正常' : '异常',
      ));
      metaList.add(DeviceInfo(
        name: '类型',
        value: battery['technology'],
      ));
      return DeviceInfoCardWidget('电池信息', metaList);
    });
  }

  Widget _buildDisplayInfo() {
    return Obx(() {
      final display = controller.display;
      if (display.isEmpty) return SizedBox();
      final metaList = [
        DeviceInfo(name: '系统分辨率', value: display['init'] ?? 'UnKnown'),
        DeviceInfo(name: '用户分辨率', value: display['cur'] ?? 'UnKnown'),
        DeviceInfo(name: '应用分辨率', value: display['app'] ?? 'UnKnown'),
        DeviceInfo(name: '密度', value: display['dpi'] ?? 'UnKnown'),
      ];
      return DeviceInfoCardWidget('显示器信息', metaList);
    });
  }
}
