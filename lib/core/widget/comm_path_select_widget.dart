import 'package:adb_box/core/widget/comm_button.dart';
import 'package:adb_box/core/widget/comm_input_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class PathSelectWidget extends StatefulWidget {
  final String path;
  final String hint;
  final ValueChanged<String> onSubmit;

  const PathSelectWidget({
    this.path = '',
    this.hint = '',
    required this.onSubmit,
    super.key,
  });

  @override
  State<PathSelectWidget> createState() => _PathSelectWidgetState();
}

class _PathSelectWidgetState extends State<PathSelectWidget> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController(text: widget.path);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: buildInputWidget()),
        SizedBox(width: 5),
        buildSelectWidget(),
      ],
    );
  }

  Widget buildInputWidget() {
    return InputWidget(
      hint: widget.hint,
      controller: controller,
      onSubmit: _submitPath,
    );
  }

  Widget buildSelectWidget() {
    return Button(
      width: 32,
      height: 32,
      text: '...',
      onTap: () async {
        String? selectDir = await FilePicker.platform.getDirectoryPath(
          lockParentWindow: true,
        );
        if (selectDir != null) {
          controller.text = selectDir;
          _submitPath(selectDir);
        }
      },
    );
  }

  void _submitPath(String path) {
    widget.onSubmit.call(path.trim());
  }
}
