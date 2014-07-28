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
  Dart solution to the "Conway Sequence" CodinGame challenge.

  Visit http://www.codingame.com for more information.
*/

import "dart:io" show stdin;

void main() {
  var root = readInt();
  var lines = readInt();

  var solution = [root];

  for (var i = 1; i < lines; ++i) {
    solution = next(solution);
  }

  print(solution.join(" "));
}

List<int> next(List<int> sequence) {
  var result = new List<int>();

  var count = 1;
  var old = sequence[0];

  for (var symbol in sequence.skip(1)) {

    // Counts symbols.
    if (symbol == old) {
      count++;

      // Adds the counter to the result and restarts it.
    } else {
      result..add(count)..add(old);

      count = 1;
      old = symbol;
    }
  }

  // Takes care of trailing symbols.
  if (count != 0) result..add(count)..add(old);

  return result;
}

String readString() => stdin.readLineSync();

int readInt() => int.parse(readString());
