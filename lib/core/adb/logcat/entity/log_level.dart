import 'package:flutter/material.dart';

enum LogLevel {
  Verbose('V', Colors.purple),
  Debug('D', Colors.blue),
  Info('I', Colors.green),
  Warn('W', Colors.yellow),
  Error('E', Colors.red),
  Fatal('F', Colors.pinkAccent),
  Silent('S', Colors.indigo);

  final Color color;
  final String value;

  const LogLevel(this.value, this.color);

  static LogLevel create(String value) {
    return LogLevel.values.firstWhere(
      (level) => level.value == value,
      orElse: () => LogLevel.Verbose,
    );
  }
}
