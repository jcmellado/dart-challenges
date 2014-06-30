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
  Dart solution to the "Shadows of the Knight - Level 1" CodinGame challenge.

  Visit http://www.codingame.com/ for more information.
*/

import "dart:io";

void main() {
    var wh = readListInt();
    var w = wh[0];
    var h = wh[1];
    
    var n = readInt();
    
    var xy = readListInt();
    var x = xy[0];
    var y = xy[1];

    // Search area dimensions.
    var xsize, ysize;

    while (true) {
        var dir = readString();
        
        // First time here? Compute search area dimensions.
        if (xsize == null && ysize == null) {
            
            // Left: [0, x)
            // Right: (x, w)
            if (dir.contains("L")) xsize = x;
            else if (dir.contains("R")) xsize = w - x - 1;
            else xsize = 0;
            
            // Up: [0, y)
            // Down: (y, h)
            if (dir.contains("U")) ysize = y;
            else if (dir.contains("D")) ysize = h - y - 1;
            else ysize = 0;
        }

        // Heuristic: Divide and conquer!
        xsize /= 2;
        ysize /= 2;

        // Move Batman to the center of the search area.
        var dx, dy;

        if (dir.contains("L")) dx = -xsize;
        else if (dir.contains("R")) dx = xsize;
        else dx = 0;
        
        if (dir.contains("U")) dy = -ysize;
        else if (dir.contains("D")) dy = ysize;
        else dy = 0;
        
        x += dx.round();
        y += dy.round();

        print("$x $y");
    }
}

String readString() => stdin.readLineSync();

int readInt() => int.parse(readString());

List<int> readListInt()
    => readString().split(" ").map(int.parse).toList();
