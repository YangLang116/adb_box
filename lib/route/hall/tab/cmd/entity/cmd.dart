enum CmdArgType {
  file,
  directory,
  text,
  none,
}

class Cmd {
  final String name;
  final String value;
  final String hint;
  final CmdArgType argType;

  Cmd({
    required this.name,
    required this.value,
    required this.hint,
    required this.argType,
  });

  bool get needArg => argType != CmdArgType.none;
}
