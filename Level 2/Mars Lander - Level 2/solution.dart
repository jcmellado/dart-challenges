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
  Dart solution to the "Mars Lander - Level 2" CodinGame challenge.

  Visit http://www.codingame.com/ for more information.
*/

import "dart:io";
import "dart:math";

void main() {
    var n = readInt();
    var mars = readPoints(n);
    
    var target = findTarget(mars);
    
    var ship = new Ship();
    
    while (true) {
        var line = readListInt();
        
        ship.update(line);
        
        ship.move(target);

        print("${ship.r} ${ship.p}");
    }
}

Point findTarget(List<Point> mars) {
    var a = mars[0];
    
    for (var b in mars.skip(1)) {
        if (a.y == b.y) {
            
            // Center of the landing area.
            var x = ((a.x + b.x) / 2).toInt();
            var y = a.y;
            
            return new Point(x, y);
        }
        a = b;
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
    
    bool landing = false;
    
    bool starting = true;

    void update(line) {
        x = line[0];
        y = line[1];
        hs = line[2];
        vs = line[3];
        f = line[4];
        r = line[5];
        p = line[6];
    }
    
    void move(Point target) {

        if (landing) {
            
            // Keep the ship in vertical position and avoid crash with the ground too fast.
            r = 0;
            p = vs < -30 ? 4 : 0;

        } else {
            
            // Distance from the ship to the center of the landing area.
            var dx = target.x - x;

            // Special case:
            // - If the ship started with an horizontal speed of zero then rotate it in the right direction and wait.
            if (starting && hs.abs() <= 40) {
                
                // Rotate the ship in the right direction.
                if (dx == 0) r = 0; else r = dx < 0 ? 45 : -45;

            } else {
                starting = false;

                // The ship must stop on the target point:
                // x = target.x
                // v(x) = 0
                
                // My Physics book says:
                // v(x)^2 = v0^2 + 2 * a * (x - x0)
                // So:
                // a = (V(x)^2 - v0^2) / (2 * (x - x0))
                // a = (0 - ship.hs^2) / (2 * (target.x - ship.x)
                var a = -(hs * hs) / (2 * dx);

                // Angle of (a, p)
                r = ((atan(p / a) * 180 / PI)).round();
                
                // Change atan result from [-PI, PI] to [-2PI, 2PI]
                if (a < 0) r += 180;
                
                // Special case:
                // - The ship is going too fast, now it's beyond the target point, change its direction.
                if (dx.sign != hs.sign) r = 90 - r;

                // Change the angle to adjust it to the ship control [-90, 90]
                r -= 90;
            }

            // Avoid the ship going to outer space.
            // Note: Don't care about fuel tank capacity :)
            p = (vs > 0) && (y > target.y) ? 0 : 4;

            // Almost stopped and very near of the target point? Time for landing!
            landing = (hs.abs() <= 10) && (dx.abs() < 10);
        }

        r = r.clamp(-45, 45);
        p = p.clamp(0, 4);
    }
}

class Point {
    int x;
    int y;
    
    Point(this.x, this.y);
}

List<Point> readPoints(int n) 
    => new List<Point>.generate(n, (_) => readPoint());

Point readPoint() {
    var line = readListInt();
    return new Point(line[0], line[1]);
}

String readString() => stdin.readLineSync();

int readInt() => int.parse(readString());

List<int> readListInt() 
    => readString().split(" ").map(int.parse).toList();
