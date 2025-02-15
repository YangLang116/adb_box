import 'package:adb_box/core/adb/constant/adb_constant.dart';
import 'package:adb_box/core/adb/logcat/entity/log_level.dart';

final RegExp _reg = RegExp(r'^(.+)([A-Z])/(.+)\((.+)\): (.+)$');

class Log {
  final int pid;
  final String tag;
  final String time;
  final LogLevel level;
  final String content;

  Log({
    this.pid = -1,
    this.tag = '',
    this.time = '',
    required this.level,
    required this.content,
  });

  @override
  String toString() {
    return '${time} ${level.name} ${tag} ${pid} $content';
  }

  static List<Log> parseLogs(String content) {
    final logList = <Log>[];
    final lines = content.split(AdbConstant.separator);
    for (final line in lines) {
      final log = _parseLog(line);
      if (log == null) continue;
      logList.add(log);
    }
    return logList;
  }

  static Log? _parseLog(String line) {
    //<datetime> <priority>/<tag>(<pid>): <message>
    //01-06 09:31:44.836 I/SystemServerTiming( 1600): OnBootPhase_520_com.android.server.incident.IncidentCompanionService
    //01-06 09:31:30.844 I/vold    (  554): Vold 3.0 (the awakening) firing up
    if (line.isEmpty) return null;
    RegExpMatch? match = _reg.firstMatch(line);
    if (match == null || match.groupCount != 5) return null;
    String time = match.group(1)!.trim();
    LogLevel level = LogLevel.create(match.group(2)!.trim());
    String tag = match.group(3)!.trim();
    int pid = int.tryParse(match.group(4)!.trim()) ?? 0;
    String content = match.group(5)!;
    return Log(pid: pid, tag: tag, time: time, level: level, content: content);
  }
}
