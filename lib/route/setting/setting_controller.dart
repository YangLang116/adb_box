import 'dart:io';

import 'package:basic_utils/basic_utils.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _KEY_PATH = 'adb.path';

class SettingController extends GetxController {
  SettingController._();

  late SharedPreferencesWithCache _store;

  String get adbPath {
    return _store.getString(_KEY_PATH) ?? Directory.current.path;
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

  bool ensureAdbExist() {
    if (StringUtils.isNullOrEmpty(adbPath)) {
      showToast('请配置ADB路径');
      return false;
    } else {
      return true;
    }
  }

  Future<void> setAdbPath(String path) async {
    if (path.isEmpty) return;
    await _store.setString(_KEY_PATH, path);
  }
}
