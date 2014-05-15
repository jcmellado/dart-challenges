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

  Visit http://www.codingame.com/ for more information.
*/

import "dart:io";

void main() {
    
    // Init information
    var m = readInt();
    var v = readInt();
    
    var road = new List<String>(4);
    road[0] = readString();
    road[1] = readString();
    road[2] = readString();
    road[3] = readString();

    stderr.writeln("m:$m v:$v");
    stderr.writeln("${road[0]}");
    stderr.writeln("${road[1]}");
    stderr.writeln("${road[2]}");
    stderr.writeln("${road[3]}");
    
    var solver;
    
    while (true) {
        
        // Turn information
        var speed = readInt();
        
        var motos = new List<Moto>(m); 
        for (var i = 0; i < m; ++ i) {
            var line = readLine();
            motos[i] = new Moto(line[0], line[1], line[2] == 1);
        }

        // Solve
        if (solver == null) {
            solver = new Solver(m, v, road, speed, motos);
        }
        
        print(solver.next());
    }
}

class Solver {
    int _m;
    int _v;
    List<String> _road;

    List<String> _solution = new List<String>();

    Solver(this._m, this._v, this._road, int speed, List<Moto> motos) {
        var context = new Context(speed, motos);
        
        solve(context, 1);
    }
    
    String next() => _solution.removeLast();
    
    List<String> _commands = ["SPEED", "WAIT", "JUMP", "SLOW", "UP", "DOWN"];
    
    bool solve(Context context, int depth) { 
        if (depth > 50) {
            return false;
        }
        if (isDone(context)) {
            return true;
        }
        for (var command in _commands) {
            var moved = move(context, command);
            if (isValid(moved)) {
                if (solve(moved, depth + 1)) {
                    _solution.add(command);
                    return true;
                }
            }
        }
        return false;
    }
    
    // Any moto reach the end of the road
    bool isDone(Context context) 
        => context.motos.any((moto) => moto.x > _road[moto.y].length);

    // At least v motos are still active
    bool isValid(Context context)
        => context.motos.fold(0, (value, moto) => value + (moto.active ? 1 : 0)) >= _v;

    Context move(Context context, String command) {
        var moved = context.clone();
        
        var up = !context.motos.any((moto) => moto.active && moto.y == 0);
        var down = !context.motos.any((moto) => moto.active && moto.y == 3);
        
        switch(command) {
            case "SPEED": moved.speed ++; break;
            case "SLOW": if (moved.speed > 1) moved.speed --; break;
        }
        
        for (var moto in moved.motos) {
            if (moto.active) {
                switch(command) {
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
                            if (moto.active) moto.y -= 1;
                        } else {
                            moto.active = allGround(moto, moved.speed, 0);
                        }
                        break;
                    case "DOWN":
                        if (down) {
                            moto.active = canDown(moto, moved.speed);
                            if (moto.active) moto.y += 1;
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

    bool canUp(Moto moto, int speed)
	    => allGround(moto, speed - 1, 0) && allGround(moto, speed, -1);
    
    bool canDown(Moto moto, int speed)
	    => allGround(moto, speed - 1, 0) && allGround(moto, speed, 1);

    bool allGround(Moto moto, int speed, int y) {
        for (var i = moto.x + 1; i <= moto.x + speed; ++ i) {
            if (i >= _road[moto.y + y].length) { // End of road
                return true;
            }
            if (_road[moto.y + y][i] == "0") {
                return false;
            }
        }
        return true;
    }
    
    bool isGround(Moto moto, int speed)
        => (moto.x + speed >= _road[moto.y].length) // End of road
        || (_road[moto.y][moto.x + speed] == ".");
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
    
    Context clone() => new Context(this.speed, 
        new List.generate(motos.length, (i) => motos[i].clone()));
}

int readInt() => int.parse(stdin.readLineSync());

String readString() => stdin.readLineSync();

List<int> readLine() => stdin.readLineSync().split(" ").map(int.parse).toList();
