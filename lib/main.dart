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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String receivedText = "";
  Map<String, double?> usersVariables = {};
  List<String> simbol = [
    '+',
    '-',
    '/',
    '*',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '0',
    '.',
    '='
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                '',
                style: TextStyle(color: Colors.grey, fontSize: 25),
              ),
            ),
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                '0',
                style: TextStyle(color: Colors.white, fontSize: 40),
              ),
            ),
            const Divider(
              color: Colors.white,
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: 4,
                children: List.generate(
                  simbol.length,
                  (index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: index < 4 ? Colors.amber : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            simbol[index].toString(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 40),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      // body: Column(
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      //       child: TextField(
      //         textDirection: ,
      //           onSubmitted: (text) {
      //             ExpressionInterpreter interpreter =
      //                 ExpressionInterpreter(text);
      //             var result = interpreter.analyzeInput(usersVariables);
      //
      //             setState(() {
      //               receivedText = result.toString();
      //             });
      //           },
      //           decoration:  const InputDecoration(
      //             border: OutlineInputBorder(),
      //             icon: Icon(Icons.login),
      //             hintText: "Введите математическое выражение",
      //           )),
      //     ),
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         const SizedBox(
      //           width: 30,
      //           height: 30,
      //           child: Align(
      //             alignment: Alignment.center,
      //             child: Text(
      //               'X = ',
      //               style: TextStyle(color: Colors.white),
      //             ),
      //           ),
      //         ),
      //         SizedBox(
      //           width: 50,
      //           height: 50,
      //           child: Align(
      //             alignment: Alignment.center,
      //             child: TextField(
      //                 onSubmitted: (text) {
      //                   var xValue = double.tryParse(text);
      //                   setState(() {
      //                     usersVariables.putIfAbsent('x', () => xValue);
      //                   });
      //                 },
      //                 decoration: const InputDecoration(
      //                   border: OutlineInputBorder(),
      //                   hintText: "x",
      //                 )),
      //           ),
      //         ),
      //       ],
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.only(top: 10),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           const Text(
      //             'Ответ:',
      //             style: TextStyle(color: Colors.white),
      //           ),
      //           Text(
      //             receivedText,
      //             style: TextStyle(color: Colors.white),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
