import 'package:adb_box/core/adb/device/entity/device.dart';
import 'package:adb_box/core/constant/color_constant.dart';
import 'package:adb_box/core/constant/font_constant.dart';
import 'package:adb_box/core/widget/window_bar.dart';
import 'package:adb_box/core/widget/window_buttons_widget.dart';
import 'package:adb_box/core/widget/window_option_widget.dart';
import 'package:adb_box/res/assets_res.dart';
import 'package:adb_box/route/hall/hall_controller.dart';
import 'package:adb_box/route/setting/setting_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HallBar extends StatelessWidget implements PreferredSizeWidget {
  final HallController controller;

  HallBar(this.controller);

  @override
  Widget build(BuildContext context) {
    return WindowBar(
      lead: buildLead(),
      action: buildAction(),
    );
  }

  Widget buildLead() {
    return Container(
      margin: EdgeInsets.only(left: 16),
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
            'ADB Tools',
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

  Widget buildAction() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [buildDeviceList(), buildDivider(), buildSetting()],
    );
  }

  Widget buildDeviceList() {
    return Obx(() {
      final selectDevice = controller.selectDevice;
      final deviceList = controller.deviceList;
      return WindowOptionWidget<Device>(
        selectItem: selectDevice,
        dataList: deviceList,
        hint: 'Select Device',
        showBorder: false,
        covert: (device) => device.deviceName,
        onSelected: controller.onDeviceSelected,
      );
    });
  }

  Widget buildDivider() {
    return Container(
      width: 0.5,
      height: 20,
      margin: EdgeInsets.only(left: 20, right: 10),
      color: ColorConstant.foreground.withOpacity(0.3),
    );
  }

  Widget buildSetting() {
    return WindowButton(icon: AssetsRes.ICON_SETTING, onTap: showSettingDialog);
  }

  @override
  Size get preferredSize => Size.fromHeight(50);
}
