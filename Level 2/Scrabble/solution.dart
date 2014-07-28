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
  Dart solution to the "Scrabble" CodinGame challenge.

  Visit http://www.codingame.com for more information.
*/

import "dart:io" show stdin;
import "dart:convert" show ASCII;

const int A = 97;

const List<int> POINTS = const <int>[
  1, 3, 3, 2, 1,
  4, 2, 4, 1, 8,
  5, 1, 3, 1, 1,
  3, 10, 1, 1, 1,
  1, 4, 4, 8, 4,
  10];

void main() {
  var n = readInt();
  var dict = readDict(n);
  var letters = ASCII.encode(readString());

  var solution;
  var max = 0;

  for (var word in dict) {
    var points = 0;

    // Creates a copy of the available letters.
    var chars = new List<int>.from(letters);

    for (var char in ASCII.encode(word)) {
      var pos = chars.indexOf(char);

      // Letter not found, abort.
      if (pos == -1) {
        points = 0;
        break;
      }

      // Removes the used letter of the copy list.
      chars.removeAt(pos);

      points += POINTS[char - A];
    }

    if (points > max) {
      max = points;
      solution = word;
    }
  }

  print(solution);
}

String readString() => stdin.readLineSync();

int readInt() => int.parse(readString());

List<String> readDict(int n)
  => new List<String>.generate(n, (_) => readString());
