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
  Dart solution to the "ASCII Art" CodinGame challenge.

  Visit http://www.codingame.com for more information.
*/

import "dart:io" show stdin;
import "dart:convert" show ASCII;

const int A = 65;
const int Z = 90;
const int QUESTION_MARK = 91;

void main() {
  var width = readInt();
  var height = readInt();
  var text = readString();
  var ascii = readAscii(height);

  text = ASCII.encode(text.toUpperCase());

  // Rows.
  for (var i = 0; i < height; ++i) {
    var output = "";

    // Characters
    for (var char in text) {

      if (char < A || char > Z) {
        char = QUESTION_MARK;
      }

      var pos = (char - A) * width;

      // Columns.
      for (var j = 0; j < width; ++j) {
        output += ascii[i][pos + j];
      }
    }

    print(output);
  }
}

String readString() => stdin.readLineSync();

int readInt() => int.parse(readString());

List<String> readAscii(int n)
  => new List<String>.generate(n, (_) => readString());
