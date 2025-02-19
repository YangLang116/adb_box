import 'package:adb_box/core/adb/device/entity/device.dart';
import 'package:adb_box/core/constant/color_constant.dart';
import 'package:adb_box/core/constant/font_constant.dart';
import 'package:adb_box/core/widget/comm_dialog.dart';
import 'package:adb_box/core/widget/comm_input_widget.dart';
import 'package:adb_box/route/hall/hall_controller.dart';
import 'package:adb_box/route/wifi/wifi_connect_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

Future<void> showWifiConnectDialog(HallController hallController) {
  return showDialog(
    context: Get.context!,
    builder: (ctx) => CommonDialog(
      width: 720,
      height: 480,
      icon: Icons.wifi,
      name: 'Wifi Devices',
      child: _Dialog(hallController),
    ),
  );
}

class _Dialog extends StatefulWidget {
  final HallController hallController;

  const _Dialog(this.hallController);

  @override
  State<_Dialog> createState() => _DialogState();
}

class _DialogState extends State<_Dialog> {
  late WifiConnectController controller;

  @override
  void initState() {
    controller = WifiConnectController(widget.hallController);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildAddDevice(),
        _buildDivider(),
        Expanded(child: _buildDeviceList()),
      ],
    );
  }

  Widget _buildAddDevice() {
    return Row(
      children: [
        Text(
          'Remote Device',
          style: TextStyle(
            color: ColorConstant.hint,
            fontSize: FontConstant.hint,
            height: 1,
          ),
        ),
        SizedBox(width: 5),
        Expanded(
          child: InputWidget(
            controller: controller.textC,
            hint: 'enter the device IP and host',
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9|.|:]'))
            ],
            onSubmit: controller.addDevice,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Divider(height: 1, thickness: 1, color: ColorConstant.border),
    );
  }

  Widget _buildDeviceList() {
    return Obx(() {
      final deviceList = controller.wifiDeviceList;
      return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: deviceList.length,
        itemBuilder: (context, index) {
          final device = deviceList[index];
          return _DeviceConnectWidget(
            device: device,
            onDisconnect: controller.removeDevice,
          );
        },
      );
    });
  }
}

class _DeviceConnectWidget extends StatelessWidget {
  final Device device;
  final ValueChanged<Device> onDisconnect;

  _DeviceConnectWidget({
    required this.device,
    required this.onDisconnect,
  }) : super(key: ValueKey(device.serial));

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: ColorConstant.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          _buildIcon(),
          SizedBox(width: 5),
          Expanded(child: _buildLabel()),
          _buildDisConnect(),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    return Icon(
      Icons.phone_android,
      size: 24,
      color: ColorConstant.foreground,
    );
  }

  Widget _buildLabel() {
    return Text(
      device.serial,
      style: TextStyle(
        color: ColorConstant.foreground,
        fontSize: FontConstant.H2,
        height: 1,
      ),
    );
  }

  Widget _buildDisConnect() {
    return GestureDetector(
      onTap: () => onDisconnect(device),
      child: Icon(
        Icons.link_off,
        size: 25,
        color: ColorConstant.selected,
      ),
    );
  }
}
