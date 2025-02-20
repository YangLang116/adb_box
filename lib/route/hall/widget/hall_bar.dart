import 'dart:io';

import 'package:adb_box/core/constant/color_constant.dart';
import 'package:adb_box/core/constant/font_constant.dart';
import 'package:adb_box/core/widget/platform_tool_bar.dart';
import 'package:adb_box/core/widget/window_buttons_widget.dart';
import 'package:adb_box/res/assets_res.dart';
import 'package:adb_box/route/hall/hall_controller.dart';
import 'package:adb_box/route/hall/widget/device_option_widget.dart';
import 'package:adb_box/route/setting/setting_dialog.dart';
import 'package:adb_box/route/wifi/wifi_connect_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HallBar extends StatelessWidget implements PreferredSizeWidget {
  final HallController controller;

  HallBar(this.controller);

  @override
  Widget build(BuildContext context) {
    if (Platform.isMacOS) {
      return MacosToolBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _buildActions(),
            _buildSlogan(margin: EdgeInsets.only(right: 16)),
          ],
        ),
      );
    } else {
      return WindowsToolBar(
        lead: _buildSlogan(margin: EdgeInsets.only(left: 16)),
        action: _buildActions(),
      );
    }
  }

  Widget _buildSlogan({required EdgeInsets margin}) {
    return Container(
      margin: margin,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.adb,
            color: ColorConstant.foreground,
            size: 25,
          ),
          SizedBox(width: 10),
          Text(
            'adb box',
            style: TextStyle(
              color: ColorConstant.foreground,
              fontSize: FontConstant.H2,
              fontWeight: FontWeight.bold,
              height: 0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildDeviceList(),
        SizedBox(width: 5),
        _buildDeviceAction(
          icon: Icons.refresh,
          onTap: controller.refreshDeviceList,
        ),
        SizedBox(width: 5),
        _buildDeviceAction(
          icon: Icons.wifi,
          onTap: () => showWifiConnectDialog(controller),
        ),
        _buildDivider(),
        WindowButton(icon: AssetsRes.ICON_SETTING, onTap: showSettingDialog),
      ],
    );
  }

  Widget _buildDeviceList() {
    return Obx(() {
      final selectDevice = controller.selectDevice;
      final deviceList = controller.deviceList;
      return DeviceOptionWidget(
        current: selectDevice,
        dataList: deviceList,
        hint: 'Select Device',
        covert: (device) => device.deviceName,
        onSelected: controller.onDeviceSelected,
      );
    });
  }

  Widget _buildDeviceAction({
    required IconData icon,
    required GestureTapCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: ColorConstant.background,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 20, color: ColorConstant.foreground),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 0.5,
      height: 20,
      margin: EdgeInsets.only(left: 20, right: 10),
      color: ColorConstant.foreground.withOpacity(0.3),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50);
}
