class Device {
  final String serial;
  final Map<String, String> meta;

  String get deviceName {
    final productKey = meta.keys.firstWhere(
      (key) => key.contains('product'),
      orElse: () => '',
    );
    return productKey.isEmpty ? 'UnKnown' : meta[productKey]!;
  }

  String get transportId => meta['transport_id'] ?? '0';

  bool get isWifiConnect => serial.contains(':');

  Device(this.serial, this.meta);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Device &&
          runtimeType == other.runtimeType &&
          serial == other.serial;

  @override
  int get hashCode => serial.hashCode;

  static Device create(String info) {
    int firstBlankIndex = info.trim().indexOf(' ');
    String serial = info.substring(0, firstBlankIndex);
    String deviceInfo = info.substring(firstBlankIndex).trim();
    Map<String, String> meta = {};
    while (true) {
      int splitIndex = deviceInfo.indexOf(':');
      if (splitIndex < 0) break;
      String name = deviceInfo.substring(0, splitIndex);
      int nextIndex = deviceInfo.indexOf(' ', splitIndex);
      if (nextIndex < 0) {
        meta[name] = deviceInfo.substring(splitIndex + 1);
        break;
      } else {
        meta[name] = deviceInfo.substring(splitIndex + 1, nextIndex);
        deviceInfo = deviceInfo.substring(nextIndex).trim();
      }
    }
    return Device(serial, Map.unmodifiable(meta));
  }
}
