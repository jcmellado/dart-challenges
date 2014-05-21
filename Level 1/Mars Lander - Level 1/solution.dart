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

  Visit http://www.codingame.com/ for more information.
*/

import "dart:io";

void main() {
    var n = readInt();
    var mars = readPoints(n);
    
    while (true) {
        var ship = readShip();

        var rotation = 0;
        var power = ship.p;
        
        if (ship.vs < -40) power = (ship.p + 1).clamp(0, 4); 

        print("$rotation $power");
    }
}

class Ship {
    int x;
    int y;
    int hs;
    int vs;
    int f;
    int r;
    int p;
}

Ship readShip() {
    var line = readListInt();
    
    return new Ship()
        ..x = line[0]
        ..y = line[1]
        ..hs = line[2]
        ..vs = line[3]
        ..f = line[4]
        ..r = line[5]
        ..p = line[6];
}

class Point {
    int x;
    int y;
}

List<Point> readPoints(int n) 
    => new List<Point>.generate(n, (_) => readPoint());

Point readPoint() {
    var line = readListInt();
    
    return new Point()
        ..x = line[0]
        ..y = line[1];
}

String readString() => stdin.readLineSync();

int readInt() => int.parse(readString());

List<int> readListInt() 
    => readString().split(" ").map(int.parse).toList();
