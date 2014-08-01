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
  Dart solution to the "Surface" CodinGame challenge.

  Visit http://www.codingame.com for more information.
*/

import "dart:io" show stdin;
import "dart:math" show Point;

void main() {
  var width = readInt();
  var height = readInt();
  var map = readMap(height);
  var n = readInt();
  var points = readPoints(n);

  var solver = new Solver(map, width, height);

  var areas = solver.solve(points);

  areas.forEach(print);
}

class Solver {
  final List<String> map;
  final int width;
  final int height;

  List<List<bool>> unvisited;

  Solver(this.map, this.width, this.height) {
    unvisited = new List<List<bool>>.generate(height, (_) => new List<bool>(width));
  }

  // Calculates the surface area for each given point.
  List<int> solve(List<Point> points) => points.map(area).toList();

  int area(Point point) {
    var size = 0;

    // Sets all cells as unvisited.
    unvisited.forEach((row) => row.fillRange(0, width, true));

    // Use a local array instead of a recursive method
    // to avoid the infamous stackoverflow exception.
    var points = new List<Point>()..add(point);

    while (points.isNotEmpty) {
      var p = points.removeLast();
      var x = p.x;
      var y = p.y;

      // Unvisited water cell?
      if (unvisited[y][x] && (map[y][x] == 'O')) {

        // Marks thes cell as visited.
        unvisited[y][x] = false;

        // Increment the surface area size.
        size++;

        // Be polite, visit your neighbours.
        if (x > 0) points.add(new Point(x - 1, y));
        if (x < width - 1) points.add(new Point(x + 1, y));
        if (y > 0) points.add(new Point(x, y - 1));
        if (y < height - 1) points.add(new Point(x, y + 1));
      }
    }

    return size;
  }
}

String readString() => stdin.readLineSync();

int readInt() => int.parse(readString());

List<String> readMap(int n) =>
    new List<String>.generate(n, (_) => readString());

Point readPoint() {
  var line = readString().split(" ").map(int.parse).toList();
  return new Point(line[0], line[1]);
}

List<Point> readPoints(int n) =>
    new List<Point>.generate(n, (_) => readPoint());
