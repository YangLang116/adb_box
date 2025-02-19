import 'dart:math';

import 'package:adb_box/route/hall/tab/script/core/script.dart';

class ScriptSwitchScreen extends Script {
  @override
  String get name => '定时切屏';

  @override
  String get description => '每间隔15-20s向上滑动屏幕';

  @override
  void execute() async {
    int count = 0;
    int startY = 1200;
    int endY = 600;
    Random random = Random();
    while (true) {
      show('开始第 ${count += 1} 次切屏');
      int offset = 200 + random.nextInt(100);
      show('当前切屏偏移量：$offset');
      await swipe(offset, startY - offset, offset, endY - offset);
      int waitTime = 15 + random.nextInt(5);
      show('等待 ${waitTime} 秒');
      await sleep(waitTime * 1000);
    }
  }
}
