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
  Dart solution to the "Mars Lander - Level 1" CodinGame challenge.

  Visit http://www.codingame.com for more information.
*/

import "dart:io" show stdin;
import "dart:math" show Point;

void main() {
  var n = readInt();
  var mars = readPoints(n);

  while (true) {
    var ship = readShip();

    var rotation = 0;
    var power = ship.p;

    // Just stop the ship.
    if (ship.vs < -30) power = 4;

    print("$rotation $power");
  }
}

class Ship {
  final int x;
  final int y;
  final int hs;
  final int vs;
  final int f;
  final int r;
  final int p;

  const Ship(this.x, this.y, this.hs, this.vs, this.f, this.r, this.p);
}

String readString() => stdin.readLineSync();

int readInt() => int.parse(readString());

List<int> readLine() => readString().split(" ").map(int.parse).toList();

Ship readShip() {
  var line = readLine();

  return new Ship(line[0], line[1], line[2], line[3], line[4], line[5], line[6]);
}

List<Point> readPoints(int n)
  => new List<Point>.generate(n, (_) => readPoint());

Point readPoint() {
  var line = readLine();

  return new Point(line[0], line[1]);
}
