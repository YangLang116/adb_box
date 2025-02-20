import 'dart:io';

class AdbConstant {
  AdbConstant._();

  static String separator = Platform.isMacOS ? '\n' : '\r\n';
}
