import 'dart:math';

import 'package:adb_box/core/adb/adb.dart';
import 'package:adb_box/route/hall/tab/script/script/script.dart';

///拼多多自动滑屏，赚金币
class ScriptSwitchScreen extends Script {
  @override
  String get name => '看视频刷金币';

  @override
  void run(String serial, Printer print) async {
    int count = 0;
    int startY = 1200;
    int endY = 600;
    Random random = Random();
    while (true) {
      print('开始第 ${count += 1} 次切屏');

      int offset = 200 + random.nextInt(100);
      print('当前切屏偏移量：$offset');
      adb.inputSwipe(serial, offset, startY - offset, offset, endY - offset);

      int waitTime = 15 + random.nextInt(10);
      print('等待 ${waitTime} 秒');
      await Future.delayed(Duration(seconds: waitTime));
    }
  }
}
