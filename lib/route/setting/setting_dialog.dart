import 'package:adb_box/core/adb/adb.dart';
import 'package:adb_box/core/constant/color_constant.dart';
import 'package:adb_box/core/constant/font_constant.dart';
import 'package:adb_box/core/widget/comm_area_widget.dart';
import 'package:adb_box/core/widget/comm_button.dart';
import 'package:adb_box/core/widget/comm_dialog.dart';
import 'package:adb_box/core/widget/comm_path_select_widget.dart';
import 'package:adb_box/res/assets_res.dart';
import 'package:adb_box/route/setting/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

void showSettingDialog() {
  showDialog(
    context: Get.context!,
    builder: (ctx) => CommonDialog(
      width: 720,
      height: 480,
      icon: AssetsRes.ICON_SETTING,
      name: 'Settings',
      child: _SettingWidget(),
    ),
  );
}

class _SettingWidget extends StatelessWidget {
  const _SettingWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSDKPath(),
        SizedBox(height: 24),
        _buildServerBtn(),
        SizedBox(height: 24),
        _buildBootBtn(),
      ],
    );
  }

  Widget _buildSDKPath() {
    return Row(
      children: [
        Container(
          height: 32,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: ColorConstant.primary,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            'ADB Path',
            style: TextStyle(
              fontSize: FontConstant.H3,
              height: 1,
              fontWeight: FontWeight.bold,
              color: ColorConstant.foreground,
            ),
          ),
        ),
        SizedBox(width: 5),
        Expanded(
          child: PathSelectWidget(
            path: SettingController.share.adbPath,
            onSubmit: SettingController.share.setAdbPath,
          ),
        )
      ],
    );
  }

  Widget _buildServerBtn() {
    return AreaWidget(
      title: 'ADB服务控制',
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Link(
              text: '关闭',
              onTap: () async {
                final isSuccess = await adb.killServer();
                showToast(isSuccess ? '操作成功' : '操作失败');
              },
            ),
            SizedBox(width: 16),
            Link(
              text: '开启',
              onTap: () async {
                final isSuccess = await adb.startServer();
                showToast(isSuccess ? '操作成功' : '操作失败');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBootBtn() {
    return AreaWidget(
      title: '设备控制',
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Link(text: '关机', onTap: adb.shutdown),
            SizedBox(width: 16),
            Link(text: '重启', onTap: adb.reboot),
          ],
        ),
      ),
    );
  }
}
