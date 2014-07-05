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

  Visit http://www.codingame.com/ for more information.
*/

import "dart:io";

void main() {
    var l = readInt();
    var h = readInt();
    var map = readMap(h);
    var n = readInt();
    var points = readPoints(n);
    
    var solver = new Solver(map, h, l);
    
    var areas = solver.solve(points);
    
    areas.forEach(print);
}

class Solver {
    final List<String> map;
    final int h;
    final int l;
    
    List<List<bool>> unvisited;

    Solver(this.map, this.h, this.l) {
        unvisited = new List<List<bool>>.generate(h, (_) => new List<bool>(l));
    }
    
    // Calculate the surface area for each given point.
    List<int> solve(List<Point> points) => points.map(area).toList();

    int area(Point point) {
        var size = 0;

        // Set all cells as unvisited.
        unvisited.forEach((row) => row.fillRange(0, l, true));

        // Use a local array instead of a recursive method to avoid the infamous stackoverflow exception.        
        var points = new List<Point>()..add(point);
        
        while(points.isNotEmpty) {
            var p = points.removeLast();
            var x = p.x;
            var y = p.y;
            
            // Unvisited water cell?
            if (unvisited[y][x] && (map[y][x] == 'O')) {
                
                // Mark the cell as visited.
                unvisited[y][x] = false;

                // Increment the surface area size.
                size ++;
    
                // Be polite, visit your neighbours.
                if (x > 0    ) points.add(new Point(x - 1, y));
                if (x < l - 1) points.add(new Point(x + 1, y));
                if (y > 0    ) points.add(new Point(x, y - 1));
                if (y < h - 1) points.add(new Point(x, y + 1));
            }
        }

        return size;
    }
}

class Point {
    final int x;
    final int y;
    
    Point(this.x, this.y);
}

String readString() => stdin.readLineSync();

int readInt() => int.parse(readString());

List<String> readMap(int n)
    => new List<String>.generate(n, (_) => readString());
    
Point readPoint() {
    var line = readString().split(" ").map(int.parse).toList();
    return new Point(line[0], line[1]);
}

List<Point> readPoints(int n)
    => new List<Point>.generate(n, (_) => readPoint());
