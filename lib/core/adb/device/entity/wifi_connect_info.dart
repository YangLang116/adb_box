class WifiConnectInfo {
  final String ip;
  final int host;

  WifiConnectInfo(this.ip, this.host);

  static WifiConnectInfo? create(String info) {
    if (info.isEmpty) return null;
    final link = info.trim().split(':');
    if (link.length != 2) return null;
    String ip = link[0];
    int? host = int.tryParse(link[1]);
    if (host == null) return null;
    return WifiConnectInfo(ip, host);
  }
}
