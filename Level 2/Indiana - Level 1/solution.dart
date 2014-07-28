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

  Visit http://www.codingame.com for more information.
*/

import "dart:io" show stdin;

void main() {
  var init = readIntLine();
  var width = init[0];
  var height = init[1];
  var grid = readGrid(height);
  var exit = readInt();

  while (true) {
    var turn = readLine();
    var x = int.parse(turn[0]);
    var y = int.parse(turn[1]);
    var entry = turn[2];

    switch (grid[y][x]) {
      case 0: break;
      case 1: y++; break;
      case 2: if (entry == "LEFT") x++; else x--; break;
      case 3: y++; break;
      case 4: if (entry == "TOP") x--; else y++; break;
      case 5: if (entry == "TOP") x++; else y++; break;
      case 6: if (entry == "LEFT") x++; else x--; break;
      case 7: y++; break;
      case 8: y++; break;
      case 9: y++; break;
      case 10: x--; break;
      case 11: x++; break;
      case 12: y++; break;
      case 13: y++; break;
    }

    print("$x $y");
  }
}

String readString() => stdin.readLineSync();

int readInt() => int.parse(readString());

List readLine() => readString().split(" ");

List<int> readIntLine() => readString().split(" ").map(int.parse).toList();

List<List<int>> readGrid(int h)
  => new List<List<int>>.generate(h, (_) => readIntLine());
