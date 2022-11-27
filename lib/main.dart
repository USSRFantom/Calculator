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
                  ///разбиваем строку на тип и значение
                  List<Lexeme> result = LexAnalyze.lexAnalyze(expText: text);
                  LexemeBuffer lexemeBuffer = LexemeBuffer(result);
                  var end = LexAnalyze.expr(lexemeBuffer);

                  setState(() {
                    receivedText = end.toString();
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.login),
                  hintText: "Введите математическое выражение",
                )),
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
