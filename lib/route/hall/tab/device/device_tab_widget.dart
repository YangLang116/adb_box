import 'package:adb_box/core/widget/comm_area_widget.dart';
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildDeviceInfoWidget('硬件信息', [
          {'name': '厂商', 'key': 'ro.product.brand'},
          {'name': '型号', 'key': 'ro.product.name'},
          {'name': '设备', 'key': 'ro.product.device'},
          {'name': '语言', 'key': 'ro.product.locale'},
          {'name': '架构', 'key': 'ro.product.cpu.abi'},
          {'name': '序列号', 'key': 'ro.serialno'},
        ]),
        SizedBox(height: 8),
        _buildDeviceInfoWidget('系统信息', [
          {'name': '厂商版本', 'key': 'ro.build.version.oplusrom'},
          {'name': 'Android 版本', 'key': 'ro.build.version.release'},
          {'name': 'SDK 版本', 'key': 'ro.build.version.sdk'},
          {
            'name': 'SDK 最低兼容版本',
            'key': 'ro.build.version.min_supported_target_sdk'
          },
        ]),
        SizedBox(height: 8),
        _buildMoreWidget(),
      ],
    );
  }

  Widget _buildDeviceInfoWidget(String title, List<Map<String, String>> meta) {
    return Obx(() {
      final props = controller.props;
      final metaList = meta.map((data) {
        return DeviceInfo(name: data['name']!, value: props[data['key']!]);
      }).toList();
      return DeviceInfoCardWidget(title, metaList);
    });
  }

  Widget _buildMoreWidget() {
    return Expanded(
      child: AreaWidget(
        title: '更多信息',
        child: Expanded(child: controller.consoleWidget),
      ),
    );
  }
}
