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

  Visit http://www.codingame.com/ for more information.
*/

import "dart:io";

void main() {
    var init = readLineInt();
    var L = init[0];
    var C = init[1];
    var MAP = readListString(L);

    var solver = new Solver(L, C, MAP);
    var solution = solver.solve();
    
    solution.forEach(print);
}

class Solver {
    final int L;
    final int C;
    final List<List<String>> MAP;
    
    final List<String> DIRS = const ["SOUTH", "EAST", "NORTH", "WEST"];

    Solver(this.L, this.C, this.MAP);

    List<String> solve() {
        var solution = new List<String>();
        
        var history = new List<State>();
        
        var state = start();
        do {
            var dir = state.dir;
            
            switch(MAP[state.row][state.col]) {
                case "S": dir = "SOUTH"; break;
                case "E": dir = "EAST"; break;
                case "N": dir = "NORTH"; break;
                case "W": dir = "WEST"; break;
                case "I": state.inverter = !state.inverter; break;
                case "B": state.breaker = !state.breaker; break;
                case "X": MAP[state.row][state.col] = " "; break;
                case "T": teleport(state); break;
            }
            
            var next = move(state, dir);
            if (isObstacle(next)) {
                next = changeDir(state);
            }
            
            if (isLoop(history, next)) return ["LOOP"];
            
            history.add(next);
            solution.add(next.dir);
        
            state = next;
        } while(MAP[state.row][state.col] != r"$");
        
        return solution;
    }
    
    State start() {
        for (var row = 1; row < L - 1; ++ row) {
            for (var col = 1; col < C - 1; ++ col) {
                if (MAP[row][col] == "@") {
                    return new State(row, col, "SOUTH", false, false);
                }
            }
        }
    }
    
    State move(State state, String dir) {
        var row = state.row;
        var col = state.col;
        
        switch(dir) {
            case "SOUTH" : row ++; break;
            case "EAST" : col ++; break;
            case "NORTH" : row --; break;
            case "WEST" : col --; break;
        }
        
        return new State(row, col, dir, state.breaker, state.inverter);
    }

    bool isObstacle(State state) {
        var cell = MAP[state.row][state.col];
        return cell == "#" || (cell == "X" && !state.breaker);
    }

    State changeDir(State state) {
        for (var dir in (state.inverter ? DIRS.reversed : DIRS)) {
            var next = move(state, dir);
            if (!isObstacle(next)) {
                return next;
            }
        }
    }
    
    void teleport(State state) {
        for (var row = 1; row < L - 1; ++ row) {
            for (var col = 1; col < C - 1; ++ col) {
                if (MAP[row][col] == "T" && (row != state.row || col != state.col)) {
                    state.row = row;
                    state.col = col;
                    return;
                }
            }
        }
    }
    
    bool isLoop(List<State> history, State state) {
        var count = 0;
        for (var old in history) {
            if (old.row == state.row &&
                old.col == state.col &&
                old.dir == state.dir &&
                old.breaker == state.breaker &&
                old.inverter == state.inverter) {
                    
                count ++;
            }
        }
        return count == 5; // ...
    }
}

class State {
    int row;
    int col;
    String dir;
    bool breaker;
    bool inverter;
    
    State(this.row, this.col, this.dir, this.breaker, this.inverter);
}

String readString() => stdin.readLineSync();

List<int> readLineInt()
    => readString().split(" ").map(int.parse).toList();

List<List<String>> readListString(int n)
    => new List<List<String>>.generate(n, (_) => readString().split(""));
