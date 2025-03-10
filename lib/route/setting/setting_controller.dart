import 'dart:io';

import 'package:adb_box/core/adb/adb.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;
import 'package:shared_preferences/shared_preferences.dart';

const String _KEY_PATH = 'adb.path';

class SettingController extends GetxController {
  SettingController._();

  late SharedPreferencesWithCache _store;

  String get adbPath {
    final cachePath = _store.getString(_KEY_PATH);
    if (cachePath != null) return cachePath;
    if (Platform.isMacOS) {
      String rootPath = p.dirname(p.dirname(Platform.resolvedExecutable));
      return p.join(rootPath, 'Resources', 'platform_tools');
    } else {
      String rootPath = p.dirname(Platform.resolvedExecutable);
      return p.join(rootPath, 'platform_tools');
    }
  }

  static SettingController get share => Get.find<SettingController>();

  static Future<void> prepare() async {
    final controller = Get.put(SettingController._());
    await controller._loadPreferences();
  }

  Future<void> _loadPreferences() async {
    _store = await SharedPreferencesWithCache.create(
      cacheOptions: SharedPreferencesWithCacheOptions(),
    );
  }

  Future<void> updatePath(String path) async {
    if (path.isEmpty) return;
    _store.setString(_KEY_PATH, path);
    adb.setPath(path);
  }
}
