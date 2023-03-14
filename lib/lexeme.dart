class ExpressionInterpreter {
  final String mathExpression;

  ExpressionInterpreter(this.mathExpression);

  String analyzeInput(Map<String, double?> inputVariables) {
    String mathExp = mathExpression;

    // подстановка переменных
    inputVariables.forEach((key, value) {
      if (value == null) {
        return;
      }
      RegExp pattern = RegExp(key, caseSensitive: false);
      mathExp = mathExp.replaceAll(pattern, value.toString());
    });

    return computeWithBrackets(mathExp);
  }

  // сделать првоерку чтобы скобки были парными
  String computeWithBrackets(String expr) {
    Iterable bracketMatches = RegExp(r'\(').allMatches(expr);
    if (bracketMatches.isNotEmpty) {
      RegExpMatch lastBracketMatch = bracketMatches.last;
      int firstBracketIndex = lastBracketMatch.end;
      String stringWithClosingBracket = expr.substring(firstBracketIndex);
      String stringBeforeOpeningBracket =
          expr.substring(0, firstBracketIndex - 1);
      Iterable closingBracketMatch =
          RegExp(r'\)').allMatches(stringWithClosingBracket);
      RegExpMatch firstBracketMatch = closingBracketMatch.first;
      int lastBracketIndex = firstBracketMatch.end;
      String stringAfterClosingBracket =
          stringWithClosingBracket.substring(lastBracketIndex);
      String toCalculate =
          stringWithClosingBracket.substring(0, lastBracketIndex - 1);
      String calculationResult = calculator(toCalculate);
      return computeWithBrackets(stringBeforeOpeningBracket +
          calculationResult +
          stringAfterClosingBracket);
    }
    return calculator(expr).replaceFirst(RegExp(r'\.?0*$'), '');
  }

  String calculator(String expr) {
    String mathExp = expr;
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
    return result.toString();
  }
}
