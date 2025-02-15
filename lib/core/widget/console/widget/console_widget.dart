import 'package:adb_box/core/ext/pointer_event_ext.dart';
import 'package:adb_box/core/widget/comm_input_widget.dart';
import 'package:adb_box/core/widget/console/console_controller.dart';
import 'package:adb_box/core/widget/console/widget/console_log_widget.dart';
import 'package:adb_box/res/assets_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ConsoleWidget extends StatelessWidget {
  final ConsoleController controller;

  const ConsoleWidget(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (e) {
        if (e.isMouseRightBtnClick) controller.showMenu(context, e);
      },
      child: Stack(
        children: [
          _buildListWidget(context),
          _buildSearchBar(),
        ],
      ),
    );
  }

  Widget _buildListWidget(BuildContext context) {
    final focusNode = controller.consoleNode;
    return GestureDetector(
      onTap: () => focusNode.requestFocus(),
      child: CallbackShortcuts(
        bindings: <ShortcutActivator, VoidCallback>{
          const SingleActivator(LogicalKeyboardKey.keyF, control: true): () {
            controller.updateSearchBar(true);
          },
        },
        child: Focus(
          focusNode: focusNode,
          child: Obx(() {
            final logs = controller.logs;
            final isRevert = controller.isRevertList;
            return Padding(
              padding: EdgeInsets.all(10),
              child: ListView.separated(
                reverse: isRevert,
                itemCount: logs.length,
                controller: controller.scrollC,
                separatorBuilder: (context, index) => SizedBox(height: 5),
                itemBuilder: (context, index) {
                  final realIndex = isRevert ? logs.length - 1 - index : index;
                  return ConsoleLogWidget(logs[realIndex]);
                },
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Obx(() {
      if (!controller.showSearchBar) return SizedBox();
      return Positioned(
        width: 240,
        right: 5,
        bottom: 5,
        child: CallbackShortcuts(
          bindings: <ShortcutActivator, VoidCallback>{
            const SingleActivator(LogicalKeyboardKey.escape): () {
              controller.updateSearchBar(false);
            },
          },
          child: InputWidget(
            controller: controller.textC,
            prefixIcon: AssetsRes.ICON_SEARCH,
            focusNode: controller.searchBarNode,
          ),
        ),
      );
    });
  }
}
