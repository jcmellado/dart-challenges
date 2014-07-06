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
  Dart solution to the "Roller Coaster" CodinGame challenge.

  Visit http://www.codingame.com/ for more information.
*/

import "dart:io";
import "dart:typed_data" show Int32List;

void main() {
    var line = readLine();
    var places = line[0];
    var rides = line[1];
    var n = line[2];
    
    var groups = readGroups(n);

    var solution = solve(places, rides, groups);
    
    print(solution);
}

int solve(int places, int rides, List<int> groups) {
    var queued = groups.fold(0, (prev, element) => prev + element);

    // Optimization: Happy day? All the people rides it again and again!
    return queued <= places ? rides * queued : analyze(places, rides, groups);
}

int analyze(int places, int rides, List<int> groups) {
    var dirhams = 0;
    
    var pos = 0;
    var persons = 0;
    
    while(true) {
        
        // Welcome aboard!
        persons += groups[pos ++];
        
        if (persons >= places) {
            
            // Reject the last group if necessary.
            if (persons > places) persons -= groups[-- pos];
            
            // Take the money.
            dirhams += persons;
            
            // Done?
            if (-- rides == 0) break;

            // Start again.            
            persons = 0;
        }
        
        // Avoid going out of bounds.
        if (pos == groups.length) pos = 0;
    }

    return dirhams;
}

String readString() => stdin.readLineSync();

int readInt() => int.parse(readString());

List<int> readLine() => readString().split(" ").map(int.parse).toList();

List<int> readGroups(int n) {
    var list = new Int32List(n); // Optimized list implementation.
    
    for (var i = 0; i < n; ++ i) {
        list[i] = int.parse(stdin.readLineSync());
    }
    
    return list;
}
