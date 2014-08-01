/*
  Copyright (c) 2014 Juan Mellado

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
*/

/*
  Dart solution to the "CGX Formatter" CodinGame challenge.

  Visit http://www.codingame.com for more information.
*/

import "dart:io" show stdin;

void main() {
  var n = readInt();
  var lines = readListString(n);

  var formatter = new Formatter();

  var pretty = formatter.format(lines);

  print(pretty);
}

class Formatter {
  String content;
  int pos;
  int tab;

  String pretty;

  String format(List<String> lines) {
    content = lines.join("").trim();
    pos = 0;
    tab = 0;

    return prettify();
  }

  String prettify() {
    pretty = "";

    while (!eof()) {
      element();
    }

    return pretty;
  }

  void element() {
    switch (content[pos]) {
      case "(":
        block();
        break;
      case "'":
        stringOrKeyValue();
        break;
      default:
        primitive();
        break;
    }
  }

  void block() {
    pretty += content[pos++]; // (
    pretty += "\n";

    tab++;

    trimLeft();

    while (content[pos] != ")") {
      padRight();
      element();

      trimLeft();

      if (content[pos] == ';') {
        pretty += content[pos++]; // ;
      }
      pretty += "\n";

      trimLeft();
    }

    tab--;

    padRight();
    pretty += content[pos++]; // )
  }

  void stringOrKeyValue() {
    pretty += content[pos++]; // '

    while (content[pos] != "'") {
      pretty += content[pos++];
    }

    pretty += content[pos++]; // '

    trimLeft();

    if (!eof() && content[pos] == '=') {
      pretty += content[pos++]; // =

      trimLeft();

      if (content[pos] == '(') {
        pretty += "\n";
        padRight();
      }

      element();
    }
  }

  void primitive() {
    if ("0123456789".contains(content[pos])) {
      while (!eof() && "0123456789".contains(content[pos])) {
        pretty += content[pos++];
      }
    } else if (content.substring(pos).startsWith("true")) {
      pretty += "true";
      pos += 4;
    } else if (content.substring(pos).startsWith("false")) {
      pretty += "false";
      pos += 5;
    } else if (content.substring(pos).startsWith("null")) {
      pretty += "null";
      pos += 4;
    }
  }

  bool eof() => pos == content.length;

  void trimLeft() {
    while (!eof() && " \t\r\n".contains(content[pos])) {
      pos++;
    }
  }

  void padRight() {
    for (var i = 0; i < tab; ++i) {
      pretty += "    ";
    }
  }
}

String readString() => stdin.readLineSync();

int readInt() => int.parse(readString());

List<String> readListString(int n) =>
    new List<String>.generate(n, (_) => readString());
