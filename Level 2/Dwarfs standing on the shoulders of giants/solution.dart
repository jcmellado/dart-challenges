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
  Dart solution to the "Dwarfs standing on the shoulders of giants" CodinGame challenge.

  Visit http://www.codingame.com/ for more information.
*/

import "dart:io";
import "dart:collection" show HashMap;

void main() {
    var N = readInt();

    var solver = new Solver(N);
    var solution = solver.solve();
    
    print(solution);
}

class Solver {
    final Map<int, int> persons = new HashMap<int, int>();
    final List<int> relations = new List<int>();
    
    Solver(int n) {
        readRelations(n);
    }

    void readRelations(int n) {
        for (var i = 0; i < n; ++ i) {
            var line = readLine();
            
            var prev = persons[line[0]];
            persons[line[0]] = relations.length;
            relations.addAll([line[1], prev]);
        }
    }
    
    int solve() {
        var max = 0;
        
        for (var person in persons.keys) {
            var len = chain(person);
            if (len > max) {
                max = len;
            }
        }
        
        return max;
    }
    
    int chain(int person) {
        var max = 1;
        
        var index = persons[person];
        while (index != null) {
            
            var len = 1 + chain(relations[index]);
            if (len > max) {
                max = len;
            }
            
            index = relations[index + 1];
        }
        
        return max;
    }
}

String readString() => stdin.readLineSync();

int readInt() => int.parse(readString());

List<int> readLine()
    => readString().split(" ").map(int.parse).toList();
