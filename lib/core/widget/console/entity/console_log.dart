class ConsoleLog {
  final bool isError;
  final String text;

  ConsoleLog.err(this.text) : isError = true;

  ConsoleLog.info(this.text) : isError = false;

  @override
  String toString() {
    return '[${isError ? 'Error' : 'Info'}]\n$text';
  }

  bool contains(String keyword) {
    return text.toLowerCase().contains(keyword.toLowerCase());
  }
}
