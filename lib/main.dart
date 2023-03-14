import 'package:calculator/lexeme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String receivedText = "";
  Map<String, double?> usersVariables = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Center(child: Text('Калькулятор')),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: TextField(
                onSubmitted: (text) {
                  ExpressionInterpreter interpreter =
                      ExpressionInterpreter(text);
                  var result = interpreter.analyzeInput(usersVariables);
                  // LexemeBuffer lexemeBuffer = LexemeBuffer(result);
                  // var end = interpreter.expr(lexemeBuffer);
                  setState(() {
                    receivedText = result.toString();
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.login),
                  hintText: "Введите математическое выражение",
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 30,
                height: 30,
                child: Align(
                  alignment: Alignment.center,
                  child: Text('X = '),
                ),
              ),
              SizedBox(
                width: 40,
                height: 40,
                child: Align(
                  alignment: Alignment.center,
                  child: TextField(
                      onSubmitted: (text) {
                        var xValue = double.tryParse(text);
                        setState(() {
                          usersVariables.putIfAbsent('x', () => xValue);
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "x",
                      )),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Ответ:'),
                Text(receivedText),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
