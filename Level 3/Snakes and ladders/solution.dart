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
  Dart solution to the "Snakes and ladders" CodinGame challenge.

  Visit http://www.codingame.com for more information.
*/

import "dart:io" show stdin;

void main() {
  var n = readInt();
  var board = readBoard(n);

  var solver = new Solver(board);

  var solution = solver.solve();

  print(solution == null ? "impossible" : solution);
}

class Solver {
  final List<String> board;

  List<int> costs;

  Solver(this.board) {
    costs = new List<int>(board.length);
  }

  int solve() {
    var start = board.indexOf("S");

    return play(start, 0);
  }

  int play(int pos, int depth) {

    // Stay on the board, please.
    if (pos < 0 || pos >= board.length) return null;

    // Has another cheaper solution already been found?
    if (costs[pos] != null && costs[pos] <= depth) return null;

    // Cost of the current solution being analyzed.
    costs[pos] = depth;

    var cost;

    switch (board[pos]) {

      // End?
      case "E":
        cost = depth;
        break;

      // Throw the dice! Minimum cost wins!
      case "S":
      case "R":
        for (var i = 1; i <= 6; ++i) {
          cost = min(cost, play(pos + i, depth + 1));
        }
        break;

      // Come on, move on!
      default:
        cost = play(pos + int.parse(board[pos]), depth + 1);
        break;
    }

    return cost;
  }
}

int min(int a, int b) => a == null ? b : (b == null ? a : (a < b ? a : b));

String readString() => stdin.readLineSync();

int readInt() => int.parse(readString());

List<String> readBoard(int n) =>
    new List<String>.generate(n, (_) => readString());
