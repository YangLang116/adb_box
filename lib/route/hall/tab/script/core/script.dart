import 'package:adb_box/core/adb/adb.dart';
import 'package:adb_box/route/hall/tab/script/core/script_core.dart';

abstract class Script extends ScriptCore {
  String get name;

  String get description;

  late String _serial;
  late Printer _printer;

  @override
  void run(String serial, Printer printer) {
    this._serial = serial;
    this._printer = printer;
    execute();
  }

  void execute();

  void show(String msg) {
    _printer.call(msg);
  }

  Future<void> text(String text) async {
    await adb.inputText(_serial, text);
  }

  Future<void> tap(int x, int y) async {
    await adb.inputTap(_serial, x, y);
  }

  Future<void> swipe(int x1, int y1, int x2, int y2) async {
    await adb.inputSwipe(_serial, x1, y1, x2, y2);
  }

  Future<void> roll(int deltaX, int deltaY) async {
    await adb.inputRoll(_serial, deltaX, deltaY);
  }

  Future<void> key(int keyCode) async {
    await adb.inputKeyCode(_serial, keyCode);
  }

  Future<void> sleep(int milliseconds) async {
    await Future.delayed(Duration(milliseconds: milliseconds));
  }
}
