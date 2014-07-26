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
  Dart solution to the "Chuck Norris" CodinGame challenge.

  Visit http://www.codingame.com for more information.
*/

import "dart:io" show stdin;
import "dart:convert" show ASCII;

void main() {
  var message = readString();

  message = ASCII.encode(message);

  var solution = "";
  var count = 0;
  var old;

  for (var char in message) {

    // Extracts one bit each time.
    for (var i = 6; i >= 0; --i) {
      var bit = (char >> i) & 0x01;

      // Detects bit value changes.
      if (old != null && old != bit) {
        solution = code(solution, old, count);
        count = 0;
      }

      count++;
      old = bit;
    }
  }

  // Takes care of trailing bits.
  solution = code(solution, old, count);

  print(solution);
}

String code(String solution, int bit, int count) {

  if (solution != "") solution += " ";

  solution += bit == 0 ? "00 " : "0 ";

  for (var i = 0; i < count; ++i) {
    solution += "0";
  }

  return solution;
}

String readString() => stdin.readLineSync();
