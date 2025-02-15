import 'dart:io';

import 'package:adb_box/core/adb/adb.dart';
import 'package:adb_box/route/hall/tab/capture/entity/capture_entity.dart';
import 'package:adb_box/route/hall/tab/hall_tab_controller.dart';
import 'package:get/get.dart';
import 'package:image_size_getter/file_input.dart';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:oktoast/oktoast.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class CaptureTabController extends HallTabController {
  final _rxCaptureInfo = Rx<CaptureEntity?>(null);

  CaptureEntity? get captureInfo => _rxCaptureInfo.value;

  final _rxEnableMouseTrack = RxBool(true);

  bool get enableMouseTrack => _rxEnableMouseTrack.value;

  void screenShot() {
    if (isConnected) _execScreenShot(serial);
  }

  @override
  void onDeviceConnected(String serial) => _execScreenShot(serial);

  @override
  void onDeviceLost() => _clearScreenShot();

  void _execScreenShot(String serial) async {
    final rootDir = await getApplicationCacheDirectory();
    final saveDir = Directory(p.join(rootDir.path, 'screenshot'));
    if (saveDir.existsSync()) saveDir.deleteSync(recursive: true);
    saveDir.createSync(recursive: true);
    String shotPath = '/sdcard/screenshot.png';
    if (!(await adb.screenshot(serial, shotPath))) {
      showToast('截取屏幕失败!');
      return;
    }
    int time = DateTime.now().millisecondsSinceEpoch;
    final saveFile = File(p.join(saveDir.path, 'screenshot_${time}.png'));
    if (!(await adb.pull(serial, shotPath, saveFile.path))) {
      showToast('获取截屏失败!');
      return;
    }
    SizeResult imageSize = ImageSizeGetter.getSizeResult(FileInput(saveFile));
    _rxCaptureInfo.value = CaptureEntity(
      width: imageSize.size.width,
      height: imageSize.size.height,
      path: saveFile.path,
    );
  }

  void _clearScreenShot() {
    _rxCaptureInfo.value = null;
  }

  void updateMouseTrack(bool enable) {
    _rxEnableMouseTrack.value = enable;
  }
}
