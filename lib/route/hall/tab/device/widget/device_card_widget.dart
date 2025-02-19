import 'package:adb_box/core/constant/color_constant.dart';
import 'package:adb_box/core/constant/font_constant.dart';
import 'package:adb_box/core/widget/comm_area_widget.dart';
import 'package:flutter/material.dart';

class DeviceInfo {
  String name;
  String? value;

  DeviceInfo({required this.name, required this.value});
}

class DeviceInfoCardWidget extends StatelessWidget {
  final String title;
  final List<DeviceInfo> infoList;

  const DeviceInfoCardWidget(this.title, this.infoList, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: AreaWidget(title: title, child: _buildItems()),
    );
  }

  Widget _buildItems() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisExtent: 30,
        ),
        itemCount: infoList.length,
        itemBuilder: (context, index) {
          final meta = infoList[index];
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${meta.name}:',
                style: TextStyle(
                  fontSize: FontConstant.H3,
                  height: 1.6,
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.foreground,
                ),
              ),
              SizedBox(width: 5),
              Text(
                meta.value ?? 'UnKnown',
                style: TextStyle(
                  fontSize: FontConstant.H4,
                  height: 1.6,
                  color: ColorConstant.foreground,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
