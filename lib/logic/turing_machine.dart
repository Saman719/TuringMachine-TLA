import 'package:turing_machine/model/rule.dart';

class TuringMachineManager {
  List<Rule> rules;
  String w;
  int head = 0;
  String startState;
  late String currentState;
  String finalState;
  late List<String> tape = [];
  bool accept = false;

  TuringMachineManager(
      {required this.rules,
      required this.w,
      required this.startState,
      required this.finalState}) {
    w = w.trim(); // if any white space is in string for any reason
    currentState = startState;
    w.runes.forEach((element) {
      tape.add(String.fromCharCode(element));
    });
    tape.add("BLANK");
    tape.add("BLANK");
  }

  bool start() {
    while (true) {
      var rejected = true;
      for (var rule in rules) {
        if (currentState == rule.qFrom && tape[head] == rule.currentSymbol) {
          rejected = false;
          currentState = rule.qTo;
          tape[head] = rule.replaceSymbol;
          rule.direction == true ? head++ : head--;
        }
        if (currentState == finalState) {
          accept = true;
          return accept;
        }
      }
      if (rejected) {
        accept = false;
        return accept;
      }
    }
  }
}
