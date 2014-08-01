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
  Dart solution to the "Skynet - The Bridge" CodinGame challenge.

  Visit http://www.codingame.com for more information.
*/

import "dart:io" show stdin;

void main() {
  var m = readInt();
  var survive = readInt();
  var road = readRoad(4);

  var solver;

  while (true) {
    var speed = readInt();
    var motos = readMotos(m);

    // First time here? Solve the puzzle!
    if (solver == null) {
      solver = new Solver(survive, road);

      solver.solve(speed, motos);
    }

    print(solver.next());
  }
}

class Solver {
  final int survive;
  final List<String> road;

  final List<String> solution = new List<String>();

  Solver(this.survive, this.road);

  String next() => solution.removeLast();

  final List<String> COMMANDS = const <String>[
      "SPEED", "WAIT", "JUMP", "SLOW", "UP", "DOWN"];

  bool solve(int speed, List<Moto> motos) =>
      solveFrom(new Context(speed, motos));

  bool solveFrom(Context context) {

    // Done?
    if (isDone(context)) {
      return true;
    }

    // Tries all the commands.
    for (var command in COMMANDS) {

      // Move!
      var moved = move(context, command);
      if (isValid(moved)) {

        // Tries to solve from here.
        if (solveFrom(moved)) {
          solution.add(command);
          return true;
        }
      }
    }

    return false;
  }

  // One moto reaches the end of the road.
  bool isDone(Context context) =>
      context.motos.any((moto) => moto.x > road[moto.y].length);

  // At least v motos are still active.
  bool isValid(Context context) =>
      context.motos.fold(0, (value, moto) => value + (moto.active ? 1 : 0)) >=
          survive;

  Context move(Context context, String command) {
    var moved = context.clone();

    // Can move up/down?
    var up = !context.motos.any((moto) => moto.active && moto.y == 0);
    var down = !context.motos.any((moto) => moto.active && moto.y == 3);

    // Speed command.
    switch (command) {
      case "SPEED":
        moved.speed++;
        break;
      case "SLOW":
        if (moved.speed > 1) moved.speed--;
        break;
    }

    // Movement command.
    for (var moto in moved.motos) {

      if (moto.active) {

        switch (command) {
          case "SPEED":
          case "SLOW":
          case "WAIT":
            moto.active = allGround(moto, moved.speed, 0);
            break;
          case "JUMP":
            moto.active = isGround(moto, moved.speed);
            break;
          case "UP":
            if (up) {
              moto.active = canUp(moto, moved.speed);
              if (moto.active) moto.y--;
            } else {
              moto.active = allGround(moto, moved.speed, 0);
            }
            break;
          case "DOWN":
            if (down) {
              moto.active = canDown(moto, moved.speed);
              if (moto.active) moto.y++;
            } else {
              moto.active = allGround(moto, moved.speed, 0);
            }
            break;
        }

        if (moto.active) moto.x += moved.speed;
      }
    }

    return moved;
  }

  bool canUp(Moto moto, int speed) =>
      allGround(moto, speed - 1, 0) && allGround(moto, speed, -1);

  bool canDown(Moto moto, int speed) =>
      allGround(moto, speed - 1, 0) && allGround(moto, speed, 1);

  bool allGround(Moto moto, int speed, int y) {
    for (var i = moto.x + 1; i <= moto.x + speed; ++i) {

      // End of the road?
      if (i >= road[moto.y + y].length) return true;

      // Hollow?
      if (road[moto.y + y][i] == "0")  return false;
    }
    return true;
  }

  bool isGround(Moto moto, int speed) =>

      // End of the road?
      (moto.x + speed >= road[moto.y].length) ||

      // Ground?
      (road[moto.y][moto.x + speed] == ".");
}

class Moto {
  int x;
  int y;
  bool active;

  Moto(this.x, this.y, this.active);

  Moto clone() => new Moto(this.x, this.y, this.active);
}

class Context {
  int speed;
  List<Moto> motos;

  Context(this.speed, this.motos);

  Context clone() =>
      new Context(
          this.speed,
          new List.generate(motos.length, (i) => motos[i].clone()));
}

String readString() => stdin.readLineSync();

int readInt() => int.parse(readString());

List<int> readLine() => readString().split(" ").map(int.parse).toList();

List<Moto> readMotos(int n) => new List<Moto>.generate(n, (_) => readMoto());

Moto readMoto() {
  var line = readLine();
  return new Moto(line[0], line[1], line[2] == 1);
}

List<String> readRoad(int n) =>
    new List<String>.generate(n, (_) => readString());
