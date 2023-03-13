class ExpressionInterpreter {
  final String mathExpression;

  ExpressionInterpreter(this.mathExpression);

  double analyzeInput(Map<String, double> inputVariables) {
    String mathExp = mathExpression;
//TODO: разобраться
    ///replaceAll
    ///переменных с человеческим видом
    ///скобки
    inputVariables.forEach((key, value) {
      print(key);
      if (value > 0) {
        return;
      }
      RegExp pattern = RegExp(key, caseSensitive: false);
      mathExp = mathExp.replaceAll(pattern, value.toString());
    });
    print(mathExp);

    final baseNumberRegExp = RegExp(r'^-?\d+(\.\d+)?');

    String _parseFloatString(String text) {
      RegExpMatch? baseNumberMatch = baseNumberRegExp.firstMatch(text);
      if (baseNumberMatch == null) {
        return '';
      }
      return baseNumberMatch.group(0) ?? '';
    }

    double _parseFloat(String text) {
      return text.isNotEmpty ? double.parse(text) : 0;
    }

    String baseValueString = _parseFloatString(mathExp);
    mathExp = mathExp.replaceFirst(baseValueString, '');
    var result = _parseFloat(baseValueString);

    while (mathExp.isNotEmpty) {
      String operand = mathExp[0];
      mathExp = mathExp.substring(1);
      String secondValueString = _parseFloatString(mathExp);
      mathExp = mathExp.replaceFirst(secondValueString, '');
      double secondValue = _parseFloat(secondValueString);

      switch (operand) {
        case '-':
          result = result - secondValue;
          break;
        case '+':
          result = result + secondValue;
          break;
        case '*':
          result = result * secondValue;
          break;
        case '/':
          result = result / secondValue;
          break;
        default:
          // TODO: ошибка вернуть 0
          print('неизвестный опперанд "$operand"');
      }
    }
    return result;
  }
}
