enum LexemeType {
  LEFT_BRACKET, //левая скобка
  RIGHT_BRACKET, //правая скобка
  OP_PLUS, //оператор плюс
  OP_MINUS, //оператор минус
  OP_MUL, //оператор умножения
  OP_DIV, //оператор деления
  NUMBBER, //номер
  EOF, //конец строки
}

class Lexeme {
  final LexemeType type;
  final String value;

  Lexeme({required this.type, required this.value});

  @override
  String toString() {
    return "Lexeme{" +
        "type{" +
        type.toString() +
        ", value" +
        value +
        '\'' +
        '}';
  }
}

class LexemeBuffer {
  List<Lexeme> lexemes = [];

  LexemeBuffer(this.lexemes);

  int pos = 0;

  Lexeme next() {
    return lexemes[pos++];
  }

  void back() {
    pos--;
  }

  getPos() {
    return pos;
  }
}

class LexAnalyze {
  ///Разбите строки на символы и првоерка этих символов
  static List<Lexeme> lexAnalyze({required String expText}) {
    ///проверяем на X
    String textCheckX = checkForX(expText);

    ///Проверяем на унарный минус
    String unaryMinus = checkForUnaryMinus(textCheckX);

    ///присваиваем готовый текст в основную переменную
    String resultText = unaryMinus;

    List<Lexeme> lexemes = [];
    int pos = 0;
    while (pos < resultText.length) {
      String c = resultText[pos];
      bool result = false;

      ///проверка на символы
      switch (c) {
        case '(':
          lexemes.add(Lexeme(type: LexemeType.LEFT_BRACKET, value: c));
          pos++;
          continue;
        case ')':
          lexemes.add(Lexeme(type: LexemeType.RIGHT_BRACKET, value: c));
          pos++;
          continue;
        case '+':
          lexemes.add(Lexeme(type: LexemeType.OP_PLUS, value: c));
          pos++;
          continue;
        case '-':
          lexemes.add(Lexeme(type: LexemeType.OP_MINUS, value: c));
          pos++;
          continue;
        case '*':
          lexemes.add(Lexeme(type: LexemeType.OP_MUL, value: c));
          pos++;
          continue;
        case '/':
          lexemes.add(Lexeme(type: LexemeType.OP_DIV, value: c));
          pos++;
          continue;
        case ' ':
          pos++;
          continue;
        default:
          if (int.tryParse(c)! <= 9 && int.tryParse(c)! >= 0) {
            String a = '';
            do {
              a = a + c;
              pos++;
              if (pos >= resultText.length) {
                break;
              }
              c = resultText[pos];
              switch (c) {
                case '(':
                  result = true;
                  break;
                case ')':
                  result = true;
                  break;
                case '+':
                  result = true;
                  break;
                case '-':
                  result = true;
                  break;
                case '*':
                  result = true;
                  break;
                case '/':
                  result = true;
                  break;
                case ' ':
                  result = true;
                  pos++;
                  break;
              }
              continue;
            } while (result == false);
            lexemes.add(Lexeme(type: LexemeType.NUMBBER, value: a));
            result == false;
          } else {
            if (c != ' ') {
              throw Exception();
            }
            pos++;
          }
      }
    }
    lexemes.add(Lexeme(type: LexemeType.EOF, value: ''));
    return lexemes;
  }

  ///проверка на конец строки
  static int expr(LexemeBuffer lexemes) {
    Lexeme lexeme = lexemes.next();
    if (lexeme.type == LexemeType.EOF) {
      return 0;
    } else {
      lexemes.back();
      return plusAndMinus(lexemes);
    }
  }

  ///плюс минус
  static int plusAndMinus(LexemeBuffer lexemes) {
    int value = multiplicationAndDivision(lexemes);
    while (true) {
      Lexeme lexeme = lexemes.next();
      switch (lexeme.type) {
        case LexemeType.OP_PLUS:
          value += multiplicationAndDivision(lexemes);
          break;
        case LexemeType.OP_MINUS:
          value -= multiplicationAndDivision(lexemes);
          break;
        case LexemeType.EOF:
        case LexemeType.RIGHT_BRACKET:
          lexemes.back();
          return value;
        default:
          throw Exception('Неизвестный символ${lexeme.value}');
      }
    }
  }

  ///Умножение или деление
  static int multiplicationAndDivision(LexemeBuffer lexemes) {
    int value = factor(lexemes);
    while (true) {
      Lexeme lexeme = lexemes.next();
      switch (lexeme.type) {
        case LexemeType.OP_MUL:
          value *= factor(lexemes);
          break;
        case LexemeType.OP_DIV:
          value ~/= factor(lexemes);
          break;
        case LexemeType.EOF:
        case LexemeType.RIGHT_BRACKET:
        case LexemeType.OP_PLUS:
        case LexemeType.OP_MINUS:
          lexemes.back();
          return value;
        default:
          throw Exception('Неизвестный символ');
      }
    }
  }

  static int factor(LexemeBuffer lexemes) {
    Lexeme lexeme = lexemes.next();
    switch (lexeme.type) {
      case LexemeType.NUMBBER:
        return int.parse(lexeme.value);
      case LexemeType.LEFT_BRACKET:
        int value = plusAndMinus(lexemes);
        lexeme = lexemes.next();
        if (lexeme.type != LexemeType.RIGHT_BRACKET) {
          throw Exception('Неизвестный символ');
        }
        return value;
      default:
        throw Exception('Неизвестный символ');
    }
  }

  ///Проверка на x (пересобираем строку)
  static String checkForX(String text) {
    String result = '';
    for (int position = 0; position < text.length; position++) {
      if (text[position] == 'x') {
        result = result + "10";

        ///По дефолту у нас x = 10
      } else {
        result = result + text[position];
      }
    }
    return result;
  }

  ///Проверка на унарный минус
  static String checkForUnaryMinus(String text) {
    String result = '';
    for (int position = 0; position < text.length; position++) {
      if (text[position] == '+' && text[position + 1] == '-') {
        result = result + "+(0-" + text[position + 2] + ")";
        position = position + 2;
      } else if (text[position] == '-' && text[position + 1] == '-') {
        result = result + "-(0-" + text[position + 2] + ")";
        position = position + 2;
      } else if (text[position] == '*' && text[position + 1] == '-') {
        result = result + "*(0-" + text[position + 2] + ")";
        position = position + 2;
      } else if (text[position] == '/' && text[position + 1] == '-') {
        result = result + "/(0-" + text[position + 2] + ")";
        position = position + 2;
      } else {
        result = result + text[position];
      }
    }
    return result;
  }
}
