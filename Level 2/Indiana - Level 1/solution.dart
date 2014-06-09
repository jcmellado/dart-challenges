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
  Dart solution to the "Indiana - Level 1" CodinGame challenge.

  Visit http://www.codingame.com/ for more information.
*/

import "dart:io";

void main() {
    var init = readIntLine();
    var w = init[0];
    var h = init[1];
    var grid = readGrid(h);
    var ex = readInt();
    
    while (true) {
        var turn = readLine();
        var xi = int.parse(turn[0]);
        var yi = int.parse(turn[1]);
        var pos = turn[2];

        switch(grid[yi][xi]) {
            case 0: break;
            case 1: yi ++; break;
            case 2: if (pos == "LEFT") xi ++; else xi --; break;
            case 3: yi ++; break;
            case 4: if (pos == "TOP") xi --; else yi ++; break;
            case 5: if (pos == "TOP") xi ++; else yi ++; break;
            case 6: if (pos == "LEFT") xi ++; else xi --; break;
            case 7: yi ++; break;
            case 8: yi ++; break;
            case 9: yi ++; break;
            case 10: xi --; break;
            case 11: xi ++; break;
            case 12: yi ++; break;
            case 13: yi ++; break;
        }

        print("$xi $yi");
    }
}

String readString() => stdin.readLineSync();

int readInt() => int.parse(readString());

List readLine() => readString().split(" ");

List<int> readIntLine()
    => readString().split(" ").map(int.parse).toList();

List<List<int>> readGrid(int h)
    => new List<List<int>>.generate(h, (_) => readIntLine());
