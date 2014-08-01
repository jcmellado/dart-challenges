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
  Dart solution to the "Bender - Complexity" CodinGame challenge.

  Visit http://www.codingame.com for more information.
*/

import "dart:io" show stdin;
import "dart:math" show Point, log, pow;

void main() {
  var n = readInt();
  var points = readPoints(n);

  var solution = solve(points);

  print("O(${solution})");
}

Map<String, Function> complexities = {
  "1": (int n) => 1,
  "log n": (int n) => log(n),
  "n": (int n) => n,
  "n log n": (int n) => n * log(n),
  "n^2": (int n) => n * n,
  "n^2 log n": (int n) => n * n * log(n),
  "n^3": (int n) => n * n * n,
  "2^n": (int n) => pow(2, n),
};

// Note: This solution is probably wrong, but it passed the tests :)
String solve(List<Point> points) {
  var complexity;

  var best;

  complexities.forEach((name, fn) {

    var a = points[0];

    // Computes the vertical size of the area
    // covered by the two functions.
    var min1 = a.y;
    var max1 = min1;

    var min2 = fn(a.x);
    var max2 = min2;

    for (var b in points.skip(1)) {
      var y1 = b.y;
      var y2 = fn(b.x);

      if (y1 < min1) min1 = y1;
      if (y1 > max1) max1 = y1;

      if (y2 < min2) min2 = y2;
      if (y2 > max2) max2 = y2;
    }

    var size1 = max1 - min1;
    var size2 = max2 - min2;

    // Now computes the differences (aka errors)
    // between the two functions, using the calculated
    // area size to get values in the range [0..1].
    var error = 0.0;

    for (var b in points.skip(1)) {
      var dy1 = size1 == 0 ? 0 : (b.y - a.y) / size1;
      var dy2 = size2 == 0 ? 0 : (fn(b.x) - fn(a.x)) / size2;

      error += (dy2 - dy1).abs();

      a = b;
    }

    // Takes the "best" error.
    if (best == null || error < best) {
      best = error;

      complexity = name;
    }
  });

  return complexity;
}

String readString() => stdin.readLineSync();

int readInt() => int.parse(readString());

List<Point> readPoints(int n) =>
    new List<Point>.generate(n, (_) => readPoint());

Point readPoint() {
  var line = readString().split(" ").map(int.parse).toList();
  return new Point(line[0], line[1]);
}
