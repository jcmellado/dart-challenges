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
  Dart solution to the "Bender - A depressed robot" CodinGame challenge.

  Visit http://www.codingame.com for more information.
*/

import "dart:io" show stdin;

void main() {
  var line = readLine();
  var rows = line[0];
  var cols = line[1];
  var map = readMap(rows);

  var solver = new Solver(rows, cols, map);

  var solution = solver.solve();

  solution.forEach(print);
}

class Solver {
  final int rows;
  final int cols;
  final List<List<String>> map;

  final List<String> DIRS = const <String>["SOUTH", "EAST", "NORTH", "WEST"];

  Solver(this.rows, this.cols, this.map);

  List<String> solve() {
    var solution = new List<String>();

    // Bender's state history, used to check infinite loops.
    var history = new List<State>();

    // Finds Bender's starting position.
    var state = start();
    do {
      var dir = state.dir;

      switch (map[state.row][state.col]) {

        // Changes current Bender's direction.
        case "S": dir = "SOUTH"; break;
        case "E": dir = "EAST"; break;
        case "N": dir = "NORTH"; break;
        case "W": dir = "WEST"; break;

        // Mode inverter on/off.
        case "I": state.inverter = !state.inverter; break;

        // Mode breaker on/off.
        case "B": state.breaker = !state.breaker; break;

        // Breaks the obstacle.
        case "X": map[state.row][state.col] = " "; break;

        // Beam me up, Scotty!
        case "T": teleport(state); break;
      }

      // Moves or inverts current Bender's direction.
      var next = move(state, dir);
      if (isObstacle(next)) {
        next = changeDir(state);
      }

      // Avoid infinite loop.
      if (isLoop(history, next)) return ["LOOP"];

      history.add(next);
      solution.add(next.dir);

      state = next;
    } while (map[state.row][state.col] != r"$");

    return solution;
  }

  // Finds Bender's starting position.
  State start() {
    for (var row = 1; row < rows - 1; ++row) {
      for (var col = 1; col < cols - 1; ++col) {
        if (map[row][col] == "@") {
          return new State(row, col, "SOUTH", false, false);
        }
      }
    }
    return null;
  }

  // Moves Bender in the given direction.
  State move(State state, String dir) {
    var row = state.row;
    var col = state.col;

    switch (dir) {
      case "SOUTH": row++; break;
      case "EAST": col++; break;
      case "NORTH": row--; break;
      case "WEST": col--; break;
    }

    return new State(row, col, dir, state.breaker, state.inverter);
  }

  // Inverts the current Bender's direction.
  State changeDir(State state) {
    var dirs = state.inverter ? DIRS.reversed : DIRS;

    for (var dir in dirs) {
      var next = move(state, dir);
      if (!isObstacle(next)) {
        return next;
      }
    }

    return null;
  }

  // Finds the telerport's position different to the current Bender's position.
  void teleport(State state) {
    for (var row = 1; row < rows - 1; ++row) {
      for (var col = 1; col < cols - 1; ++col) {
        if (map[row][col] == "T" && (row != state.row || col != state.col)) {
          state.row = row;
          state.col = col;
          return;
        }
      }
    }
  }

  bool isObstacle(State state) {
    var cell = map[state.row][state.col];

    return cell == "#" || (cell == "X" && !state.breaker);
  }

  bool isLoop(List<State> history, State state) {
    var count = 0;
    for (var old in history) {
      if (old.row == state.row &&
          old.col == state.col &&
          old.dir == state.dir &&
          old.breaker == state.breaker &&
          old.inverter == state.inverter) {

        count++;
      }
    }
    return count == 5; // Enough to me.
  }
}

// Bender's state.
class State {
  int row;
  int col;
  String dir;
  bool breaker;
  bool inverter;

  State(this.row, this.col, this.dir, this.breaker, this.inverter);
}

String readString() => stdin.readLineSync();

List<int> readLine() => readString().split(" ").map(int.parse).toList();

List<List<String>> readMap(int n)
  => new List<List<String>>.generate(n, (_) => readString().split(""));
