import 'package:adb_box/route/hall/hall_controller.dart';
import 'package:adb_box/route/hall/widget/docker/docker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widget/hall_bar.dart';

class HallPage extends StatefulWidget {
  const HallPage({super.key});

  @override
  State<HallPage> createState() => _HallPageState();
}

class _HallPageState extends State<HallPage> {
  late HallController controller;

  @override
  void initState() {
    controller = Get.put(HallController());
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<HallController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HallBar(controller),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [buildTab(), buildDocker()],
      ),
    );
  }

  Widget buildTab() {
    return Positioned.fill(
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Obx(() {
          final selectOption = controller.selectOption;
          return selectOption.content;
        }),
      ),
    );
  }

  Widget buildDocker() {
    return Obx(() {
      final showDocker = controller.showDocker;
      return AnimatedPositioned(
        duration: Duration(milliseconds: 300),
        bottom: showDocker ? 0 : -50,
        child: Opacity(
          opacity: showDocker ? 1 : 0.3,
          child: DockerWidget(
            visibility: showDocker,
            selectOption: controller.selectOption,
            options: controller.options,
            onSelected: controller.onSelectOption,
            onFocusChanged: controller.onFocusChanged,
          ),
        ),
      );
    });
  }
}
