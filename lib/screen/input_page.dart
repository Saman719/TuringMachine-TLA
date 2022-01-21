import 'package:flutter/material.dart';
import 'package:turing_machine/logic/turing_machine.dart';
import 'package:turing_machine/model/rule.dart';

class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  late TuringMachineManager turingMachineManager;
  final stringController = TextEditingController();
  final startStateController = TextEditingController();
  final finalStateController = TextEditingController();

  List<Widget> ruleInputs = [RuleInput(), RuleInput()];
  void addRuleInputs() {
    setState(() {
      ruleInputs.add(RuleInput()..currentSymbolController);
    });
  }

  void startProcess() {
    turingMachineManager = TuringMachineManager(
        rules: extraxtRules(ruleInputs),
        w: stringController.text,
        startState: startStateController.text,
        finalState: finalStateController.text);
    turingMachineManager.start();
    print(turingMachineManager.accept);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    print(width);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: width > 1650 ? 1000 : 500,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(border: Border.all()),
                width: 400,
                child: TextField(
                  controller: stringController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'String',
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(border: Border.all()),
                width: 75,
                child: TextField(
                  controller: startStateController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'S-State',
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(border: Border.all()),
                width: 75,
                child: TextField(
                  controller: finalStateController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'F-State',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                decoration: BoxDecoration(border: Border.all()),
                height: MediaQuery.of(context).size.height - 239,
                child: GridView.count(
                  childAspectRatio: 4,
                  padding: EdgeInsets.zero,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                  crossAxisCount: width > 1650 ? 2 : 1,
                  children: ruleInputs +
                      [
                        IconButton(
                          onPressed: addRuleInputs,
                          icon: const Icon(Icons.add),
                        )
                      ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
            width: 10,
            child: Center(
                child: Container(
              color: Colors.black,
            ))),
        Container(
          width: 200,
          height: 100,
          child: MaterialButton(
            child: Text("Run"),
            onPressed: startProcess,
          ),
        ),
        Container(
          width: 200,
          height: 100,
          color: Colors.green,
        )
      ],
    );
  }
}

class RuleInput extends StatefulWidget {
  final fromController = TextEditingController();
  final toController = TextEditingController();
  final currentSymbolController = TextEditingController();
  final replaceSymbolController = TextEditingController();
  final directionController = TextEditingController();

  RuleInput({Key? key}) : super(key: key);

  @override
  State<RuleInput> createState() => _RuleInputState();
}

class _RuleInputState extends State<RuleInput> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(right: BorderSide(color: Colors.black, width: 1))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 75,
            child: TextField(
              controller: widget.fromController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'From',
              ),
            ),
          ),
          const SizedBox(
              width: 20,
              child: Center(
                  child: Text(
                ",",
                style: TextStyle(fontSize: 30),
              ))),
          SizedBox(
            width: 75,
            child: TextField(
              controller: widget.toController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'To',
              ),
            ),
          ),
          const SizedBox(
              width: 20,
              child: Center(
                  child: Text(
                ",",
                style: TextStyle(fontSize: 30),
              ))),
          SizedBox(
            width: 75,
            child: TextField(
              controller: widget.currentSymbolController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'C-Symbol',
              ),
            ),
          ),
          const SizedBox(
              width: 20,
              child: Center(
                  child: Text(
                ",",
                style: TextStyle(fontSize: 30),
              ))),
          SizedBox(
            width: 75,
            child: TextField(
              controller: widget.replaceSymbolController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'R-Symbol',
              ),
            ),
          ),
          const SizedBox(
              width: 20,
              child: Center(
                  child: Text(
                ",",
                style: TextStyle(fontSize: 30),
              ))),
          SizedBox(
            width: 75,
            child: TextField(
              controller: widget.directionController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Direction',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<Rule> extraxtRules(List<Widget> ruleInputs) {
  List<Rule> rules = [];
  for (var ruleInput in ruleInputs) {
    ruleInput = (ruleInput as RuleInput);
    if (ruleInput.fromController.text == null ||
        ruleInput.fromController.text == "") {
      continue;
    }
    Rule rule = Rule(
      qFrom: ruleInput.fromController.text,
      qTo: ruleInput.toController.text,
      currentSymbol: ruleInput.currentSymbolController.text,
      replaceSymbol: ruleInput.replaceSymbolController.text,
      direction: ruleInput.directionController.text == "R" ? true : false,
    );
    rules.add(rule);
  }
  return rules;
}
