import 'package:turing_machine/model/rule.dart';

class TuringMachineManager {
  List<Rule> rules;
  String w;
  int head = 0;
  String startState;
  late String currentState;
  List<String> finalStates;
  late List<String> tape = [];

  TuringMachineManager(
      {required this.rules,
      required this.w,
      required this.startState,
      required this.finalStates}) {
    w = w.trim(); // if any white space is in string for any reason
    currentState = startState;
    w.runes.forEach((element) {
      tape.add(String.fromCharCode(element));
    });
  }

  void start() {
    while (true) {
      for (var rule in rules) {
        if (currentState == rule.qFrom && tape[head] == rule.currentSymbol) {
          currentState = rule.qTo;
          rule.direction == true ? head++ : head--;
        }
      }
    }
  }
}
