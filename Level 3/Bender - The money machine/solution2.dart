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
  Dart solution to the "Bender - The money machine" CodinGame challenge.

  Visit http://www.codingame.com for more information.
*/

import "dart:io" show stdin;
import "dart:math" show max;

void main() {
  var n = readInt();
  var rooms = readRooms(n);

  var solver = new Solver(rooms);

  var money = solver.solve();

  print(money);
}

class Solver {
  final List<Room> rooms;

  Solver(this.rooms);

  // Bender starts in the room number 0 with no money.
  int solve() => visit(0);

  int visit(int door) {

    // Exit door?
    if (door == null) return 0;

    // It's a room!
    var room = rooms[door];

    // Has this room already been visited?
    if (room.found != null) return room.found;

    // Open the doors, maybe you'll get lucky!
    var a = visit(room.a);
    var b = visit(room.b);

    return room.found = room.money + max(a, b);
  }
}

class Room {
  final int money;
  final int a;
  final int b;

  // Money found so far visiting this room.
  int found;

  Room(this.money, this.a, this.b);
}

String readString() => stdin.readLineSync();

int readInt() => int.parse(readString());

List<Room> readRooms(int n) => new List<Room>.generate(n, (_) => readRoom());

Room readRoom() {
  var fields = readString().split(" ");

  var money = int.parse(fields[1]);
  var a = fields[2] == 'E' ? null : int.parse(fields[2]);
  var b = fields[3] == 'E' ? null : int.parse(fields[3]);

  return new Room(money, a, b);
}
