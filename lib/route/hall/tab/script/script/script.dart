import 'dart:isolate';

import 'package:adb_box/core/adb/adb.dart';
import 'package:adb_box/core/widget/console/console_controller.dart';

const SCHEME_TYPE = '_type';
const SCHEME_DATA = '_data';
const TYPE_RECALL = '_recall';
const TYPE_MSG = '_msg';
const TYPE_EXIT = '_exit';

typedef Printer = void Function(String msg);

abstract class Script {
  String get name;

  SendPort? _innerSender;

  void start(String adbPath, String serial, Console console) async {
    ReceivePort mainReceive = ReceivePort();
    mainReceive.listen((data) {
      String type = data[SCHEME_TYPE];
      switch (type) {
        case TYPE_RECALL:
          _innerSender = data[SCHEME_DATA];
          break;
        case TYPE_MSG:
          String msg = data[SCHEME_DATA];
          console.appendInfos(msg);
          break;
      }
    });
    await Isolate.spawn(_startScript, [adbPath, mainReceive.sendPort, serial]);
  }

  void _startScript(List args) {
    adb.setAdbPath(args[0]);
    SendPort mainSender = args[1];
    ReceivePort innerReceive = ReceivePort();
    innerReceive.listen((data) {
      if (data[SCHEME_TYPE] == TYPE_EXIT) Isolate.exit();
    });
    mainSender.send({
      SCHEME_TYPE: TYPE_RECALL,
      SCHEME_DATA: innerReceive.sendPort,
    });
    run(args[2], (msg) {
      mainSender.send({SCHEME_TYPE: TYPE_MSG, SCHEME_DATA: msg});
    });
  }

  void run(String serial, Printer sender);

  void stop() {
    _innerSender?.send({SCHEME_TYPE: TYPE_EXIT});
  }
}
