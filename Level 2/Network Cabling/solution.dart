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
  Dart solution to the "Network Cabling" CodinGame challenge.

  Visit http://www.codingame.com for more information.
*/

import "dart:io" show stdin;

void main() {
  var n = readInt();
  var points = readList(n);

  // Calculates the horizontal min/max coordinates
  // and the vertical average coordinate.
  var xmin, xmax, yavg = 0;

  for (var point in points) {
    if (xmin == null || point[0] < xmin) xmin = point[0];
    if (xmax == null || point[0] > xmax) xmax = point[0];

    yavg += point[1];
  }

  yavg ~/= n;

  // Now calculates the minimum length from each building
  // to the vertical average coordinate.
  var dmin, ycenter;

  for (var point in points) {
    var dist = (point[1] - yavg).abs();

    if (dmin == null || dist < dmin) {
      dmin = dist;

      ycenter = point[1];
    }
  }

  // Length of the shared horizontal cable.
  var solution = xmax - xmin;

  // Length of each dedicated vertical cable.
  for (var point in points) {
    solution += (point[1] - ycenter).abs();
  }

  print(solution);
}

String readString() => stdin.readLineSync();

int readInt() => int.parse(readString());

List<int> readLine() => readString().split(" ").map(int.parse).toList();

List<List<int>> readList(int n) => new List.generate(n, (_) => readLine());
