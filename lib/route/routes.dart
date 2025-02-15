import 'package:adb_box/route/hall/hall_page.dart';
import 'package:flutter/cupertino.dart';

class RouteManager {
  static final String Hall = '/hall';

  RouteManager._();

  Map<String, WidgetBuilder> getRoutes() {
    return {
      Hall: (context) => HallPage(),
    };
  }
}

RouteManager routeManager = RouteManager._();
