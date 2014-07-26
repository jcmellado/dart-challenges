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
  Dart solution to the "Horse-racing Duals" CodinGame challenge.

  Visit http://www.codingame.com for more information.
*/

import "dart:io" show stdin;

// Note: This solution is a bit weird, there is a better
// one in the same folder where this file is located.

void main() {
  var n = readInt();
  var horses = new List<int>(n)
      ..[0] = readInt()
      ..[1] = readInt();

  // Creates the interval [a  b] with the first two values.
  var a = horses[0] < horses[1] ? horses[0] : horses[1];
  var b = horses[0] > horses[1] ? horses[0] : horses[1];
  var min = b - a;

  // Compares the rest of values against [a b]
  for (var i = 2; i < n; ++i) {
    var dist;

    // Reads a new value.
    var c = readInt();

    // c [a  b] => [c  b]
    if (c < a) {
      dist = a - c;
      a = c;

      // [a  b] c => [a  c]
    } else if (c > b) {
      dist = c - b;
      b = c;

      // [a c b]
    } else {

      // Worst scenario? Brute force approach!
      // Compares the value against all the rest.
      for (var d in horses.take(i)) {
        dist = (c - d).abs();
        if (dist < min) {
          min = dist;
        }
      }
    }

    if (dist < min) {
      min = dist;
    }

    horses[i] = c;
  }

  print(min);
}

String readString() => stdin.readLineSync();

int readInt() => int.parse(readString());
