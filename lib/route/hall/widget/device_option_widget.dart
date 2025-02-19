import 'package:adb_box/core/adb/device/entity/device.dart';
import 'package:adb_box/core/constant/color_constant.dart';
import 'package:adb_box/core/constant/font_constant.dart';
import 'package:adb_box/core/widget/window_option_widget.dart';
import 'package:flutter/material.dart';

class DeviceOptionWidget extends WindowOptionWidget<Device> {
  DeviceOptionWidget({
    super.key,
    required super.current,
    required super.dataList,
    required super.covert,
    required super.onSelected,
    super.width = 160,
    required super.hint,
    super.showBorder = false,
  });

  @override
  Widget buildItem(Device item) {
    return Row(
      children: [
        Icon(Icons.phone_android, size: 20, color: ColorConstant.foreground),
        SizedBox(width: 5),
        Expanded(child: _buildDeviceName(item)),
      ],
    );
  }

  Widget _buildDeviceName(Device item) {
    return Text(
      covert.call(item),
      style: TextStyle(
        color: ColorConstant.foreground,
        fontSize: FontConstant.H2,
        height: 1,
      ),
    );
  }
}
