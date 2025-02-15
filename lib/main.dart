import 'dart:io';

import 'package:adb_box/app_manager.dart';
import 'package:adb_box/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lifecycle/lifecycle.dart';
import 'package:oktoast/oktoast.dart';
import 'package:window_manager/window_manager.dart';

import 'core/constant/color_constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await appManager.ensureInitialized();
  runApp(const AdbApp());
}

class AdbApp extends StatelessWidget {
  const AdbApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Adb Tools',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: ColorConstant.background,
        fontFamily: Platform.isWindows ? "微软雅黑" : null,
      ),
      initialRoute: RouteManager.Hall,
      routes: routeManager.getRoutes(),
      builder: (context, child) {
        return OKToast(
          child: DragToResizeArea(
            enableResizeEdges: [...ResizeEdge.values]
              ..remove(ResizeEdge.bottom),
            child: child!,
          ),
        );
      },
      navigatorObservers: [defaultLifecycleObserver],
    );
  }
}
