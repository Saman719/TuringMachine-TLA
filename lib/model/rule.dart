class Rule {
  String qFrom, qTo;
  String currentSymbol, replaceSymbol;
  bool direction;

  Rule(
      {required this.qFrom,
      required this.qTo,
      required this.currentSymbol,
      required this.replaceSymbol,
      required this.direction});
}
